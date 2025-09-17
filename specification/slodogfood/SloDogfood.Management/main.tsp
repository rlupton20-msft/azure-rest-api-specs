import "@typespec/http";
import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.ResourceManager;

@armProviderNamespace("Microsoft.SloDogfood")
@service({
  title: "Microsoft.SloDogfood",
})
@versioned(Versions)
@armCommonTypesVersion(Azure.ResourceManager.CommonTypes.Versions.v5)
namespace Microsoft.SloDogfood;

enum Versions {
  @useDependency(Azure.ResourceManager.Versions.v1_0_Preview_1)
  `2025-01-01-preview`,
}

interface Operations extends Azure.ResourceManager.Operations {}

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-path-segment-invalid-chars" "Existing Template"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-key-invalid-chars" "Existing template"
@doc("A SloTestProviderHub resource")
model Slo is ExtensionResource<SloResource> {
  @doc("The name of the SLO")
  @pattern("^[a-zA-Z0-9-]{3,128}$")
  @key("name")
  @segment("slos")
  @path
  name: string;

  ...ManagedServiceIdentityProperty;
}

@doc("The status of the current operation.")
@Azure.Core.lroStatus
union ProvisioningState {
  ResourceProvisioningState,

  @doc("Initial provisioning in progress")
  Provisioning: "Provisioning",

  @doc("Update in progress")
  Updating: "Updating",

  @doc("Deletion in progress")
  Deleting: "Deleting",

  @doc("Change accepted for processing")
  Accepted: "Accepted",
}

@doc("Resource properties model")
model SloResource {
  @visibility("read")
  @doc("The status of the last operation.")
  provisioningState?: ProvisioningState;

  @doc("SLO description")
  description: string;

  @doc("SLO type")
  sloType: string;

  @doc("SLO evalution type")
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

@armResourceOperations(Slo)
interface Slos {
  @doc("Gets a Slo")
  get is ArmResourceRead<Slo>;

  @doc("Creates or updates a Slo")
  createOrUpdate is ArmResourceCreateOrReplaceSync<Slo>;

  @doc("Deletes a Slo")
  delete is ArmResourceDeleteSync<Slo>;

  @doc("Lists all Slos")
  listByParent is ArmResourceListByParent<Slo>;
}
