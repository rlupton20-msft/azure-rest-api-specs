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
  `2024-09-01-preview`,
}

interface Operations extends Azure.ResourceManager.Operations {}

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-path-segment-invalid-chars" "Existing Template"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-key-invalid-chars" "Existing template"
@doc("A SloTestProviderHub resource")
model Slo is ExtensionResource<SloResource> {
  @doc("The name of the SLO")
  @pattern("^[a-zA-Z0-9-]{3,128}$")
  @key("sloName")
  @segment("slos")
  @path
  name: string;
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

@doc("SLO Request body")
model SloResource {
  @visibility("read")
  @doc("The status of the last operation.")
  provisioningState?: ProvisioningState;

  @doc("This will be the ARM Id for this SLO.")
  sloId: string;

  @doc("Identities assigned to the SLO resource.")
  identity: Identity;

  @doc("The properties that define the Service Level Objective.")
  sloProperties: SloProperties;

  @doc("The properties that define the Service Level Indicators.")
  sliProperties: SliProperties;
}

@doc("SLO Properties")
model SloProperties {
  @doc("One of these values: Availability | Latency")
  sloCategory: string;

  @doc("The targets that this SLO should achieve. An SLO may have multiple targets.")
  targets: SloTargets;

  @doc("The zoom window for aggregating the SLI signals.")
  zoomMinutes: int32;

  @doc("Number of days. When LookbackType is Rolling, this is the rolling window (in days).")
  lookbackWindowDays: int32;

  @doc("One of Rolling or Calendar.")
  lookbackType: string;
}

@doc("SLI Properties")
model Identity {
  @doc("Identity type: UserAssigned | SystemAssigned")
  type: string;

  @doc("User assigned managed identity")
  userAssignedIdentities: {};
}

@doc("SLI Properties")
model SliProperties {
  @doc("The AMW account from where the metrics will originate")
  @OpenAPI.extension("x-ms-identifiers", ["resourceId"])
  sourceAccounts: SourceAccountMetadata[];

  @doc("The AMW account to where the metrics will be sent")
  destinationAccount: DestinationAccountMetadata;
}

@doc("SLO Target Properties")
model SloTargets {
  @doc("A user-friendly name given to this target.")
  targetName: string;

  @doc("For latency, this would typically be a milliseconds value. For Availability or SuccessRate, users may specify a percentage value.")
  @minValue(0)
  targetValue: float32;

  @doc("SLO target window")
  targetWindow: string;

  @doc("SLO target percentile")
  targetPercentile?: string;

  @doc("SLO target operator")
  operator: string;
}

@doc("The Azure Monitor Workspace account metadata")
model SourceAccountMetadata {
  @doc("ARM resource id for the account where metrics related to this SLO are emitted by the service.")
  resourceId: string;

  @doc("ARM resource id for teh managed identity with access to the source account.")
  identity: string;
}

@doc("The Azure Monitor Workspace account metadata")
model DestinationAccountMetadata {
  @doc("ARM resource id for the account where metrics related to this SLO are emitted by the service.")
  resourceId: string;

  @doc("ARM resource id for teh managed identity with access to the source account.")
  identity: string;
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
