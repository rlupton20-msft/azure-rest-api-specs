import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "./common.tsp";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.Core;
using Azure.Core.Traits;

@versioned(Microsoft.AiForScienceWorkspace.Versions)
namespace Microsoft.AiForScienceWorkspace;

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
}
