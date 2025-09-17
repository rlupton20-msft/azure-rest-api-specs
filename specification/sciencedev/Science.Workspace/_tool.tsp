import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "./common.tsp";
import "../Science.Catalog.Management/common.tsp";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.Core;
using Microsoft.Science.Shared;
using Azure.ClientGenerator.Core;

@versioned(Microsoft.Science.Workspace.Versions)
namespace Microsoft.Science.Workspace;

/** Enum for run status */
@lroStatus
union RunStatus {
  /** Not Running */
  NotRunning: "NotRunning",

  /** Running */
  Running: "Running",

  /** Succeeded */
  @lroSucceeded
  Succeeded: "Succeeded",

  /** Aborted */
  @lroCanceled
  Canceled: "Canceled",

  /** Failed */
  @lroFailed
  Failed: "Failed",

  string,
}

/** For tracking mount path */
@access(Access.internal)
model WithMountPath {
  /** Mount path, relative to the working directory. */
  relativeMountPath: string;
}

/** DataAsset and path where it will be mounted, relative to the working directory . */
model DataAssetMount {
  /** ID of DataAsset */
  dataAssetId: DataAssetId;

  ...WithMountPath;
}
/*
 * The interplay between command, inlineFiles, inputDataAssets and outputDataAssets warrants an example.
 *
 * Imagine a scenario in which an agent generates a Python script wrapper.py which:
 * - Takes a single command line argument, --input, which is a text file containing a list of
 *   SMILES strings.
 * - Reads the SMILES strings from the file, and for each SMILES string uses RDKit to generate
 *   multiple conformers for the molecule, and uses iomanager.py to write the conformers to file
 *
 * If the data plane receives the following request:
 *
 * ```json
 * {
 *   "command": "python wrapper.py --input abcdef-input-1/* --output abcdef-output-1",
 *   "inlineFiles": [
 *     {
 *       "relativeMountPath": "iomanager.py",
 *       "encodedFile": "IiIiQmFzaWMgb..."
 *     },
 *     {
 *       "relativeMountPath": "wrapper.py",
 *       "encodedFile": "3RlcHMve3NlbG..."
 *     }
 *   ],
 *   "inputDataAssets": [
 *     {
 *         "relativeMountPath": "abcdef-input-1",
 *         "dataAssetId": "/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Private.Science/dataContainers/{dataContainerName}/dataAssets/SmilesTxtDataAsset",
 *     }
 *   ],
 *   "outputDataAssets": [
 *     {
 *         "relativeMountPath": "abcdef-output-1",
 *         "dataAssetId": "/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Private.Science/dataContainers/{dataContainerName}/dataAssets/MySharedStorageDataAsset1",
 *     }
 *   ],
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
@doc("Parameters to run a Tool")
model RunRequest {
  /** ID of the tool to execute */
  toolId: ToolId;

  /** Name of the Project to run the tool under. This Project must exist as a child of the Workspace whose endpoint the RunRequest is submitted to. */
  projectName: string;

  /** Command to pass to tool container entrypoint.
   *
   * If the tool has multiple containers defined, this command is executed on all of them.
   *
   * If omitted, all containers execute their raw entrypoints.
   */
  /*
   * Note that we will likely extend this API in M2 to better support tools with
   * heterogeneous pools/containers where we want to run different code in some containers.
   *
   * Doing so will likely involve moving to accept a Dictionary of commands to run on
   * different containers.
   */
  command?: string;

  /*
   * Up to 10 files can be provided inline. This
   * is primarily intended for submitting agent-generated code.
   *
   * We impose a 10 file limit in order to place some bounds on how much
   * code can be submitted in this way. For submitting larger amounts of data,
   * a DataAsset should be used.
   *
   * Each of these files is made available at the specified path, relative to the
   * container's working directory.
   */
  @doc("Encoded inline files to be mounted into the container, e.g. for generated code.")
  @maxItems(10)
  inlineFiles?: Array<InlineFile>;

  @doc("The Storage resource to use for this run.")
  storageId: StorageId;

  // KnowledgeBase configuration is under discussion.
  // Currently this is called KnowledgeBaseDefinition, which really does not make sense.
  //   @doc("The indexed KnowledgeBase data plane resources to use for the run.")
  //   knowledgeBaseIds: string[];

  /**
   * Input DataAssets and associated relativeMountPath for each, relative to the working directory.
   *
   * Any DataAssetIds which point to SharedStorage must point to
   * the same SharedStorage specified by sharedStorageId, otherwise the
   * request will be rejected.
   */
  inputDataAssets?: DataAssetMount[];

  /**
   * Output DataAssets and associated relativeMountPath for each, relative to the working directory.
   *
   * Any DataAssetIds which point to SharedStorage must point to
   * the same SharedStorage specified by sharedStorageId, otherwise the
   * request will be rejected.
   */
  outputDataAssets?: DataAssetMount[];

  @doc("IDs of NodePools to use for this run. If not specified, suitable NodePools will be selected based on the infra requirements of the Tool.")
  nodePoolIds?: NodePoolId[];
}

@doc("A file to be included in the input data for a tool run and the path where it will be mounted, relative to the working directory.")
model InlineFile {
  ...WithMountPath;

  /*
   * Expected reasonable limit for small code files,
   * which are the primary use case for this feature.
   *
   * For reference, at the time of writing, iomanager.py was 7kB without
   * zipping or encoding it.
   */
  @doc("File contents: Compressed using .gz then base64-encoded.")
  @maxLength(20000) // ~20kB
  encodedFile: string;
}

/** For tracking when it completed. */
@access(Access.internal)
model WithCompletedAt {
  @visibility(Lifecycle.Read)
  @doc("The time the run completed.")
  completedAt?: utcDateTime;
}

@doc("Run result")
model RunResult {
  @doc("Human-readable details about the run status.")
  runtimeDetails: string;

  ...WithCreatedAt;
  ...WithCompletedAt;

  @doc("Details provided by the tool (rather than the platform).")
  toolReport?: {
    /** Percentage compete */
    percentageComplete: int8;

    statusInformation?: {};
  };

  /*
   * The intention is to place the original request payload in this field as
   * an escaped JSON string. We do this instead of making this model an extension
   * of RunRequest to avoid consumers taking a hard dependency on this
   * information being present.
   */
  @doc("Debugging information.")
  debugInfo: string;
}

interface Tools {
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations"
  @doc("Used for to poll status of a Tool run.")
  @route("/tools/operations")
  getRunStatus is Foundations.GetOperationStatus<{}, RunResult>;

  /** Run the specified tool in the context of the specified project. */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations"
  @route("/tools:run")
  @pollingOperation(Tools.getRunStatus)
  run is Foundations.LongRunningOperation<RunRequest, AcceptedResponse>;
}
