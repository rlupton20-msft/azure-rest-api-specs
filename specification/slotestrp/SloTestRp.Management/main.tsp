import "@typespec/http";
import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.ResourceManager;

@armProviderNamespace("Microsoft.SloTestRp")
@service({
  title: "Microsoft.SloTestRp",
})
@versioned(Versions)
@armCommonTypesVersion(Azure.ResourceManager.CommonTypes.Versions.v5)
namespace Microsoft.SloTestRp;

enum Versions {
  @useDependency(Azure.ResourceManager.Versions.v1_0_Preview_1)
  `2024-07-01-preview`,

  `2024-08-01-preview`,
}

interface Operations extends Azure.ResourceManager.Operations {}

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-path-segment-invalid-chars" "Existing Template"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-key-invalid-chars" "Existing template"
@doc("An SLO resource")
model SloResource is ExtensionResource<SloProperties> {
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

@doc("SLO Properties")
model SloProperties {
  @visibility("read")
  @doc("The status of the last operation.")
  provisioningState?: ProvisioningState;

  @doc("SLO category")
  sloCategory: string;

  @doc("SLO target")
  sloTarget: SloTargets;

  @doc("The AMW account from where the metrics will originate")
  sourceAccount: AccountMetadata;

  @doc("The AMW account to where the metrics will be sent")
  destinationAccount: AccountMetadata;
}

@doc("SLO Target Properties")
model SloTargets {
  @doc("SLO target name")
  targetName: string;

  @doc("SLO target value")
  @minValue(0)
  @maxValue(100)
  targetValue: float32;

  @doc("SLO target window")
  targetWindow: string;

  @doc("SLO target percentile")
  targetPercentile: string;

  @doc("SLO target operator")
  operator: string;
}

@doc("The Azure Monitor Workspace account metadata")
model AccountMetadata {
  @doc("ARM resource id for the AMW")
  resourceId: string;

  @doc("ARM Id for the MSI")
  identity: string;
}

@armResourceOperations(SloResource)
interface Slos {
  get is ArmResourceRead<SloResource>;
  createOrUpdate is ArmResourceCreateOrReplaceSync<SloResource>;
  delete is ArmResourceDeleteSync<SloResource>;
}
