import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "./common.tsp";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.Core;
using Azure.Core.Traits;

@versioned(Microsoft.Science.Workspace.Versions)
namespace Microsoft.Science.Workspace;

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
  ...WithResultUri;
}

interface RunSteps {
  @doc("Fetch a RunStep by name.")
  getStep is ResourceRead<RunStep>;

  @doc("List Runs")
  listSteps is ResourceList<
    RunStep,
    QueryParametersTrait<WithQueryCreatedSince>
  >;

  @doc("Resume a paused run.")
  cancel is Operations.ResourceAction<RunStep, {}, RunStep>;

  @doc("Pause a run.")
  start is Operations.ResourceAction<RunStep, {}, RunStep>;

  @doc("Resume a paused run.")
  resume is Operations.ResourceAction<RunStep, {}, RunStep>;
}
