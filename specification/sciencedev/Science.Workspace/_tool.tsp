import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "./common.tsp";
import "../Science.Catalog.Management/common.tsp";

using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.Core;

@versioned(Microsoft.Science.Workspace.Versions)
namespace Microsoft.Science.Workspace;

@doc("A Scientific tool.")
@resource("tools")
model Tool {
  /*
   * Note that this model exists purely to provide a data plane "resource" to submit
   * executions to. There are no data plane CRUD operations on the Tool resource because
   * these are done via the control plane. The data plane exists purely for tool execution.
   */
  @doc("The scientific tool name.")
  @visibility(Lifecycle.Read)
  @key("toolName")
  name: string;
}

/*
 * The interplay between command, inlineFiles, inputDataAssets and outputDataAssets warrants a
 * worked example.
 *
 * Imagine a scenario in which an agent generates a Python script wrapper.py which:
 * - Takes a single command line argument, --input, which is a text file containing a list of
 *   SMILES strings.
 * - Reads the SMILES strings from the file, and for each SMILES string uses RDKit to generate
 *   multiple conformers for the molecule, and uses iomanager.py to write the conformers to file
 *
 * If the dataplane receives the following request:
 *
 * ```json
 * {
 *   "command": "python wrapper.py --input abcdef-input-1/*",
 *   "inlineFiles": [
 *     {
 *       "relativePath": "iomanager.py",
 *       "encodedFile": "IiIiQmFzaWMgb..."
 *     },
 *     {
 *       "relativePath": "wrapper.py",
 *       "encodedFile": "3RlcHMve3NlbG..."
 *     }
 *   ],
 *   "inputDataAssets": {
 *     "abcdef-input-1": "SmilesTxtDataAsset"
 *   },
 *   "outputDataAssets": {
 *     "abcdef-output-1": [
 *       "MySharedStorageDataAsset1"
 *     ]
 *   },
 *   "sharedStorageId": "MySharedStorage"
 * }
 * ```
 * where SmilesTxtDataAsset refers to a blob DataAsset containing a single smiles.txt file, and
 * MySharedStorageDataAsset1 refers to a SharedStorage DataAsset on MySharedStorage, then the
 * following filesystem layout will be presented to the tool container:
 *
 * WORKDIR/
 * ├── iomanager.py
 * ├── wrapper.py
 * ├── abcdef-input-1/
 * │   └── smiles.txt
 * └── abcdef-output-1/
 *
 * Supercomputer will ensure that the abcdef-output-1/ directory is backed, via filesystem mounts,
 * by the SharedStorage path referenced in MySharedStorageDataAsset1.
 *
 * The container will be launched with the command python wrapper.py --input abcdef-input-1/* which
 * will be expanded by the shell to python wrapper.py --input abcdef-input-1/smiles.txt.
 *
 * wrapper.py will write its output to abcdef-output-1/, meaning it is persisted to the
 * specified SharedStorage DataAsset.
 */
@doc("An execution of a Tool")
model ExecutionRequest {
  @doc("Command to pass to tool container's entrypoint. If omitted, entrypoint is executed.")
  command?: string;

  /*
   * Up to 10 files can be provided inline. This
   * is primarily intended for submitting agent-generated code.
   *
   * We impose a 10 file limit in order to place some bounds on how much
   * code can be submitted in this way. For submitting larger amounts of data,
   * a DataAsset should be used.
   *
   * It would be preferable to have a Record here with the relativePath as key, but
   * typespec doesn't allow @maxItems to be applied to a Record.
   *
   * Each of these files is made available at the specified path, relative to the
   * container's working directory.
   */
  @doc("Encoded inline files to be mounted into the container, e.g. for generated code.")
  @maxItems(10)
  inlineFiles?: Array<InlineFile>;

  /*
   * DataAssets to expose as input to the execution.
   *
   * All of the data referenced by these DataAssetIds is made available to the
   * tool container in its working directory. The keys in this Record specify
   * the directory, relative to the working directory, where the data will be
   * made available.
   *
   * Any DataAssetIds which point to SharedStorage must point to
   * the same SharedStorage specified by sharedStorageId, otherwise the
   * request will be rejected.
   */
  @doc("Input data assets to use for this execution.")
  inputDataAssets?: Record<DataAssetId>;

  /*
   * DataAssets to which to persist the output of the execution.
   *
   * Each key in this Record specifies a directory, relative to the container's
   * working directory, from which to collect output.
   *
   * The values in this record are an array of DataAssetIds specifying one or more
   * locations to which to persist the data specified by the key. We accept an
   * array here to support e.g. persisting the data to SharedStorage for consumption
   * by subsequent tools and to Blob storage for exposure to the Studio.
   *
   * Any DataAssetIds which point to SharedStorage must point to
   * the same SharedStorage specified by sharedStorageId, otherwise the
   * request will be rejected.
   */
  @doc("Data assets to which to emit output of this execution")
  outputDataAssets?: Record<DataAssetId[]>;

  @doc("IDs of NodePools to use for this execution. If not specified, suitable NodePools will be selected based on the infra requirements of the Tool.")
  nodePoolIds?: NodePoolId[];

  @doc("The shared storage to use for this execution.")
  sharedStorageId: StorageId;
}

@doc("A file to be included in the input data for a tool execution.")
model InlineFile {
  @doc("The relative path of the file within the input directory.")
  relativePath: string;

  /*
   * Limit the size of this field to ~20kB. This is a reasonable limit for
   * small code files, which are the primary use case for this feature.
   *
   * For reference, at the time of writing, iomanager.py was 7kB without
   * gzipping or encoding it.
   */
  @doc("base64-encoding of the gzipped contents of the file.")
  @maxLength(20000)
  encodedFile: string;
}

@doc("Execution status model")
model ExecutionStatusResult {
  @doc("Human-readable details about the execution status.")
  runtimeDetails: string;

  @doc("The time the execution was created.")
  createdTime: utcDateTime;

  @doc("The time the execution completed.")
  completedTime?: utcDateTime;

  @doc("Details provided by the tool (rather than the platform).")
  toolReport?: {
    estimatedCompletionTime?: utcDateTime;
    statusInformation?: {};
  };

  /*
   * The intention is to place the original request payload in this field as
   * an escaped JSON string. We do this instead of making this model an extension
   * of ExecutionRequest to avoid consumers taking a hard dependency on this
   * information being present.
   */
  @doc("Debugging information.")
  debugInfo: string;
}

interface Tools {
  @doc("Used for to poll status of a Tool execution.")
  getExecutionStatus is Operations.GetResourceOperationStatus<
    Tool,
    ExecutionStatusResult
  >;

  @doc("Execute a Tool.")
  @pollingOperation(Tools.getExecutionStatus)
  execute is Operations.LongRunningResourceAction<
    Tool,
    ExecutionRequest,
    ExecutionStatusResult
  >;
}
