using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.ResourceManager;
using OpenAPI;

namespace Microsoft.Approvals;

@doc("ApprovalSetting singleton resource.")
@singleton("default")
@subscriptionResource
model ApprovalSetting is ProxyResource<ApprovalSettingProperties> {
  ...ResourceNameParameter<ApprovalSetting>;
  ...EntityTagProperty;
}

@doc("RP-specific properties of an ApprovalSetting resource.")
model ApprovalSettingProperties {
  @doc("The status of the last operation.")
  @visibility("read")
  provisioningState?: ProvisioningState;

  @doc("The list of verification authorities.")
  @extension("x-ms-identifiers", ["name"])
  verificationAuthorities: VerificationAuthority[];

  @doc("The settings of the requested verifiable credentials in the approvals service.")
  requestedCrendentialsSetting: ApprovalRequestCrendentialsSetting;

  @doc("The settings of backend storage for approval service to use as a ledger.")
  @visibility("read", "create")
  secureLedgerSetting: SecureLedgerSetting;
}

@doc("Information about a verification authority.")
model VerificationAuthority {
  @doc("The name of the verification authority.")
  @visibility("read", "create")
  name: string;

  @doc("The API endpoint of the verification authority.")
  apiEndpoint: string;

  @doc("The requested verifiable credentials for the verification authority.")
  requestedCredential: RequestCendentialSetting;
}

@doc("Settings of the requested verifiable credentials in the approvals service.")
model ApprovalRequestCrendentialsSetting {
  @doc("The requested verifiable credentials for approvers.")
  approver: RequestCendentialSetting;

  @doc("The requested verifiable credentials for admins.")
  admin: RequestCendentialSetting;

  @doc("The requested verifiable credentials for devices.")
  device: RequestCendentialSetting;

  @doc("The requested verifiable credentials for the approver management portal.")
  approverManagementPortal: RequestCendentialSetting;
}

@doc("The requested verifiable credentials for a specific type.")
model RequestCendentialSetting {
  @doc("The list of issuers' decentralized identifiers that can be accepted.")
  acceptedIssuers: string[];

  @doc("The type of verifiable credential.")
  @visibility("read", "create")
  vcType: string;
}

@doc("Settings of backend storage for approval service to use as a ledger.")
model SecureLedgerSetting {
  @doc("The storage type.")
  @visibility("read", "create")
  type: secureLedgerStorageType;

  @doc("The regions the storage should be created at and replicated to.")
  @visibility("read", "create")
  regions: string[];

  @doc("The endpoint to access the storage.")
  @visibility("hidden")
  endpoint: string;
}

@doc("Enum of the backend storage types for approval service to use as a ledger.")
union secureLedgerStorageType {
  string,

  @doc("Azure Cosmos DB.")
  CosmosDB: "AzureCosmosDB",

  @doc("Azure Confidential Ledger.")
  AzureConfidentialLedger: "AzureConfidentialLedger",
}

@armResourceOperations(ApprovalSetting)
interface ApprovalSettings {
  get is ArmResourceRead<ApprovalSetting>;
  createOrUpdate is ArmResourceCreateOrReplaceAsync<ApprovalSetting>;
  update is ArmResourcePatchSync<ApprovalSetting, ApprovalSettingProperties>;
  delete is ArmResourceDeleteSync<ApprovalSetting>;
  listBySubscription is ArmListBySubscription<ApprovalSetting>;
}
