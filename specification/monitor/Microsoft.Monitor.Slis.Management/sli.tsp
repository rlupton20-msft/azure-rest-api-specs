import "@typespec/http";
import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.ResourceManager;

namespace Microsoft.Monitor;

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-path-segment-invalid-chars" "Existing Template"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-key-invalid-chars" "Existing template"
@doc("A SliTestProviderHub resource")
model Sli is ExtensionResource<SliResource> {
  @doc("The name of the SLI")
  @pattern("^[a-zA-Z0-9-]{3,128}$")
  @key("name")
  @segment("slis")
  @path
  name: string;

  ...ManagedServiceIdentityProperty;
}

@doc("Resource properties model")
model SliResource {
  @visibility("read")
  @doc("The status of the last operation.")
  provisioningState?: ProvisioningState;

  @doc("SLO description")
  description: string;

  @doc("SLO type")
  sloType: string;

  @doc("SLO evaluation type")
  evaluationType: string;

  @doc("SLO properties")
  sloProperties: SloProperties;

  @doc("SLI properties")
  sliProperties: SliProperties;
}

@doc("SLO properties model")
model SloProperties {
  @doc("SLO target")
  target: SloTarget;

  @doc("Destination AMW accounts")
  @OpenAPI.extension("x-ms-identifiers", ["resourceId"])
  destinationAmwAccounts: AmwAccount[];

  @doc("Destination metrics")
  @OpenAPI.extension("x-ms-identifiers", ["metricNamespace", "metricName"])
  destinationMetrics: Metric[];
}

@doc("SLI properties model")
model SliProperties {
  @doc("Source AMW accounts")
  @OpenAPI.extension("x-ms-identifiers", ["resourceId"])
  sourceAmwAccounts: AmwAccount[];

  @doc("Request based good signals")
  goodSignals?: Signal;

  @doc("Request based total signals")
  totalSignals?: Signal;

  @doc("Window based signals")
  signals?: Signal;

  @doc("Window uptime criteria")
  windowUptimeCriteria?: WindowUptimeCriteria;
}

@doc("signal model")
model Signal {
  @doc("Signal sources")
  @OpenAPI.extension("x-ms-identifiers", ["signalSourceId"])
  signalSources: SignalSource[];

  @doc("Signal formula")
  signalFormula: string;
}

@doc("Signal source model")
model SignalSource {
  @doc("The signal source id")
  signalSourceId: string;

  @doc("Metric namespace")
  metricNamespace: string;

  @doc("Metric name")
  metricName: string;

  @doc("Filter")
  @OpenAPI.extension("x-ms-identifiers", ["logic", "queries"])
  filters: Filter[];

  @doc("Aggregation")
  spatialAggregation: SpatialAggregation;
}

@doc("Filter model")
model Filter {
  @doc("Filter logic")
  logic: string;

  @doc("Filter queries")
  @OpenAPI.extension("x-ms-identifiers", ["dimensionName", "value", "operator"])
  queries: Query[];
}

@doc("Query model")
model Query {
  @doc("Dimension name")
  dimensionName: string;

  @doc("Query operator")
  operator: string;

  @doc("Dimension value")
  value: string;
}

@doc("Spatial aggregation model")
model SpatialAggregation {
  @doc("Spatial aggregation type")
  type: string;

  @doc("Spatial aggregation dimension")
  dimensions: string[];
}

@doc("Window uptime criteria model")
model WindowUptimeCriteria {
  @doc("Window uptime target")
  target: float32;

  @doc("Window uptime comparator")
  comparator: string;

  @doc("Temporal aggregation")
  temporalAggregation: TemporalAggregation;
}

@doc("Temporal aggregation model")
model TemporalAggregation {
  @doc("Temporal aggregation type")
  type: string;

  @doc("Temporal aggregation window size in minutes")
  windowSizeMinutes: string;
}

@doc("SLO target model")
model SloTarget {
  @doc("Target name")
  name: string;

  @doc("Target value")
  target: float32;

  @doc("Compliance period days")
  compliancePeriodDays: string;

  @doc("Compliance calculation")
  complianceCalculation: string;

  @doc("Target comparator")
  comparator: string;
}

@doc("AMW account model")
model AmwAccount {
  @doc("ARM resource id for the account where metrics related to this SLO are emitted by the service.")
  resourceId: string;

  @doc("ARM resource id for the managed identity with access to the source account.")
  identity: string;
}

@doc("Metric model")
model Metric {
  @doc("Metric namespace")
  metricNamespace: string;

  @doc("Metric name")
  metricName: string;
}

@armResourceOperations(Sli)
interface Slis {
  @doc("Gets a Sli")
  get is ArmResourceRead<Sli>;

  @doc("Creates or updates a Sli")
  createOrUpdate is ArmResourceCreateOrReplaceSync<Sli>;

  @doc("Deletes a Sli")
  delete is ArmResourceDeleteSync<Sli>;

  @doc("Lists all Slis")
  listByParent is ArmResourceListByParent<Sli>;
}
