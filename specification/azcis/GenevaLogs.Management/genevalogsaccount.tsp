import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-autorest";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

using OpenAPI;
using TypeSpec.Http;
using TypeSpec.Rest;
using Azure.Core;
using Azure.ResourceManager;
using Autorest;

namespace Microsoft.AzureCis;

@doc("GenevaLogsAccount properties")
model GenevaLogsAccountResourceProperties {
  @doc("The name of the warm path account. This must be unique. Logs Account name must start with a letter and can contain numbers/letters.")
  @pattern("^[a-zA-Z0-9-]{6,32}$")
  accountName: string;

  @doc("The MDS environment")
  mdsEnvironment: MdsEnvironment;

  @doc("The metrics account name")
  metricsAccountName: string;

  @doc("The contact email")
  contactEmail: string;

  @doc("The array of aliases for administrators")
  @extension("x-ms-identifiers", [])
  administratorAliases: Array<string>;

  @doc("The security group for account administrator")
  administratorSecurityGroup: string;

  @doc("An Azure subscription to use for GSM provisioning. Each subscription in the list must have granted Geneva access via RBAC.")
  @extension("x-ms-identifiers", [])
  subscriptionIds: Array<string>;

  @doc("The default storage replication type")
  defaultStorageReplicationType: string;

  @doc("The Azure location.")
  azureLocation?: azureLocation;

  @doc("Provisioning status of the resource.")
  @visibility("read")
  provisioningState?: GenevaLogsProvisioningState;

  @doc("Resource event argument result; a part of provisioning ResultData output.")
  @visibility("read") // A part of provisioning ResultData output, gets PATCHed back from FRP.
  configDetails?: ConfigDetails;
}

@doc("Configuration details result")
model ConfigDetails {
  @doc("Configuration version")
  configVersion: string;
}

@doc("MDS environment")
union MdsEnvironment {
  @doc("Smoke emvironment")
  Smoke: "Smoke",

  @doc("Canary environment")
  Canary: "Canary",

  @doc("Test environment")
  Test: "Test",

  @doc("Stage environment")
  Stage: "Stage",

  @doc("DiagnosticsProd environment")
  DiagnosticsProd: "DiagnosticsProd",

  @doc("FirstPartyProd environment")
  FirstPartyProd: "FirstPartyProd",

  @doc("BillingProd environment")
  BillingProd: "BillingProd",

  @doc("CaFairfax environment")
  CaFairfax: "CaFairfax",

  @doc("CaMooncake environment")
  CaMooncake: "CaMooncake",

  @doc("CaBlackForest environment")
  CaBlackForest: "CaBlackForest",

  @doc("UsSec environment")
  UsSec: "UsSec",

  @doc("UsNat environment")
  UsNat: "UsNat",

  @doc("ExternalProd environment")
  ExternalProd: "ExternalProd",

  @doc("CanaryEast environment")
  CanaryEast: "CanaryEast",

  @doc("CanaryWest environment")
  CanaryWest: "CanaryWest",

  @doc("CanaryNorth environment")
  CanaryNorth: "CanaryNorth",

  @doc("CanarySouth environment")
  CanarySouth: "CanarySouth",

  @doc("Bleu environment")
  Bleu: "Bleu",

  @doc("Delos environment")
  Delos: "Delos",

  @doc("GovSG environment")
  GovSG: "GovSG",

  string,
}

@doc("genevaLogsAccount Resource")
model GenevaLogsAccountResource
  is ProxyResource<GenevaLogsAccountResourceProperties> { // this can be TrackedResource based on resourcetype
  @doc("The name of resource.")
  @pattern("^[a-zA-Z0-9-]{3,80}$")
  @key("resourceName")
  @segment("genevaLogsAccounts") // start with lower case
  @visibility("read")
  @path
  name: string;
}

#suppress "@azure-tools/typespec-azure-resource-manager/no-resource-delete-operation" "The resource must have a delete operation.TypeSpec"
@armResourceOperations
interface GenevaLogsAccount {
  createOrUpdate is ArmResourceCreateOrUpdateAsync<GenevaLogsAccountResource>;
  listBySubscription is ArmListBySubscription<GenevaLogsAccountResource>;
  listByResourceGroup is ArmResourceListByParent<GenevaLogsAccountResource>;
  get is ArmResourceRead<GenevaLogsAccountResource>;
}
