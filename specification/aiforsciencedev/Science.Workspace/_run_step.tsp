import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "./common.tsp";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.Core;
using Azure.Core.Traits;

@versioned(Microsoft.AiForScience.Workspace.Versions)
namespace Microsoft.AiForScience.Workspace;

@doc("Step to be executed within a run")
@resource("steps")
@parentResource(Run)
model RunStep {
  @doc("The step name.")
  @visibility("read")
  @key("stepName")
  name: string;

  ...WithId;
  ...Step;
  ...WithCreatedAt;
  ...WithUpdatedAt;
  ...WithStatus<RunStatus>;
  ...WithStatusReason;
  ...WithResultAsset;

  /** Node pool used for step */
  @visibility("read", "create", "update")
  nodePoolIds?: Azure.Core.armResourceIdentifier<[
    {
      type: "Microsoft.AiForScience/nodePool";
    }
  ]>[];
}

interface RunSteps {
  @doc("Fetch a RunStep by name.")
  getStep is ResourceRead<RunStep>;

  @doc("List Runs")
  listSteps is ResourceList<
    RunStep,
    QueryParametersTrait<WithQueryCreatedSince>
  >;

  @doc("Creates or replaces Investigation.")
  createOrUpdateStep is StandardResourceOperations.ResourceCreateOrUpdate<RunStep>;

  @doc("Resume a paused run.")
  cancel is Operations.ResourceAction<RunStep, {}, RunStep>;

  @doc("Pause a run.")
  start is Operations.ResourceAction<RunStep, {}, RunStep>;
}
