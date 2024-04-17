import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-autorest";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

using OpenAPI;
using TypeSpec.Http;
using TypeSpec.Rest;
using Azure.ResourceManager;
using Autorest;

namespace Microsoft.AzureCis;

@doc("Defines the array of whitelists for a secret")
model Whitelists {
  @doc("Whitelist elements")
  @extension("x-ms-identifiers", [])
  elements: Whitelist[];
}

@doc("Defines the whitelist element for a secret.")
model Whitelist {
  @doc("Gets or sets the type of the whitelist. ServiceID: whitelisting a service. SubscriptionID : whitelisting subscription ID for creating storage account objects. DnsDomain :whitelisting a DNS domain for creating chained certificates. ServiceTreeID: whitelisting a service tree ID.")
  type: string;

  @doc("Gets or sets the values of the whitelist. A list of values are separated by semicolon.")
  values: string;
}

@doc("Defines where the secret should be replicated to.")
model Replicate {
  @doc("Local: This secret is not replicated to other dSMS instance. AllDsmsRegions: This secret can be replicated to all dSMS instances. SpecifiedDsmsRegions: This secret can only be replicated to the specified dSMS instances.")
  type: string;

  @doc("The regions the secret will be replicated to (Applicable when the type of replication is SpecifiedDsmsRegions). Regions are separated by semicolon.")
  regions: string;
}

union CertificateType {
  Chained: "Chained",
  SelfSigned: "SelfSigned",
  string
};

@doc("sslAdminCertificateDsms properties")
model DsmsCertificateProperties {
  @doc("Name of the certificate")
  certificateName: string;

  @doc("Certificate type, Chained or SelfSigned")
  certificateType: CertificateType;

  @doc("Root path of the certificate")
  rootPath: string;

  @doc("Define in which region of dSMS to provision the storage account, such as global-dsms.dsms.%(HostNameSuffix), uswest-dsms.dsms.%(HostNameSuffix). This is used only when provision storage account in non-home-dsms endpoint.")
  dsmsDns: string;

  @doc("Certificate whitelist in dSMS.")
  whitelist: Whitelists;

  @doc("Block auto key roll over")
  blockAutoRollover?: boolean;

  @doc("Certificate rotation period in days")
  customRolloverPeriodDays?: int32;

  @doc("Certificate Replication in dSMS.")
  replicate: Replicate;

  @doc("Certificate Subject Name")
  subject: string;

  @doc("Certificae Subject Alternative Name")
  san?: string;

  @doc("CA name")
  caName?: string;

  @doc("Valid days of this certificate")
  validDays?: int32;

  @doc("Enable CA signing")
  caSigning?: boolean;

  @doc("Enable certificate transparency")
  certificateTransparency?: boolean;

  @doc("Block ninety day enforcement")
  blockNinetyDayEnforcement?: boolean;

  @doc("Provisioning state")
  @visibility("read")
  provisioningState?: CertificateProvisioningState;
}

@doc("dsmsCertificate Resource")
model DsmsCertificateResource
  is ProxyResource<DsmsCertificateProperties> { // this can be TrackedResource based on resourcetype
  @doc("The name of resource.")
  @pattern("^[a-zA-Z0-9-]{3,80}$")
  @key("resourceName")
  @segment("dsmsCertificate") // Start with lower case. Should be plural
  @visibility("read")
  @path
  name: string;
}

#suppress "@azure-tools/typespec-azure-resource-manager/no-resource-delete-operation" "The resource must have a delete operation.TypeSpec"
@armResourceOperations
interface DsmsCertificate {
  createOrUpdate is ArmResourceCreateOrUpdateAsync<DsmsCertificateResource>;
  listBySubscription is ArmListBySubscription<DsmsCertificateResource>;
  listByResourceGroup is ArmResourceListByParent<DsmsCertificateResource>;
  get is ArmResourceRead<DsmsCertificateResource>;
}
