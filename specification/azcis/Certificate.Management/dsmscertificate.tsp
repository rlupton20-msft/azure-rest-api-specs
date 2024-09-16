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

@doc("Certificate Type")
union CertificateType {
  @doc("Chained certificate")
  Chained: "Chained",

  @doc("Self-signed certificate")
  SelfSigned: "SelfSigned",

  string,
}

@doc("CA type")
union CaType {
  @doc("SSLAdmin CA")
  SSLAdmin: "SSLAdmin",

  @doc("AME CA")
  AME: "AME",

  string,
}

@doc("sslAdminCertificateDsms properties")
model DsmsCertificateProperties {
  @doc("Name of the certificate")
  certificateName: string;

  @doc("Certificate type, Chained or SelfSigned")
  certificateType: CertificateType;

  @doc("Root path of the certificate")
  rootPath: string;

  @doc("Define in which region of dSMS to provision the storage account, such as global-dsms.dsms.%(HostNameSuffix), uswest-dsms.dsms.%(HostNameSuffix). This is used only when provision storage account in non-home-dsms endpoint.")
  dsmsDns?: string;

  @doc("Certificate whitelist in dSMS.")
  whitelist?: Whitelists;

  @doc("Block auto key roll over")
  blockAutoRollover?: boolean;

  @doc("Certificate rotation period in days")
  customRolloverPeriodDays?: int32;

  @doc("Certificate Replication in dSMS.")
  replicate?: Replicate;

  @doc("Certificate Subject name, e.g. \"CN=DsmsEv2Extension\" or \"CN=ev2-dsms.dsms.core.azure-test.net\"")
  subject: string;

  @doc("Certificate Subject Alternate Name, e.g. \"DNS=ev2-dsms.dsms.core.azure-test.net\"")
  san?: string;

  @doc("CA to use, \"SSLAdmin\" or \"AME\"")
  caName?: CaType; // Can be a part of provisioning ResultData output, and get PATCHed back from FRP.

  @doc("Valid days of this certificate (Self-signed certificates only)")
  validDays?: int32;

  @doc("Enable CA signing (Self-signed certificates only)")
  caSigning?: boolean;

  @doc("Enable certificate transparency")
  certificateTransparency?: boolean;

  @doc("Block ninety day enforcement")
  blockNinetyDayEnforcement?: boolean;

  @doc("The Azure location.")
  azureLocation?: azureLocation;

  @doc("Provisioning status of the resource.")
  @visibility("read")
  provisioningState?: CertificateProvisioningState;

  @doc("Self-signed Certificate DSMS name; a part of provisioning ResultData output.")
  @visibility("read") // A part of provisioning ResultData output, gets PATCHed back from FRP.
  selfSignedCertificateDsmsName?: string;

  @doc("Chained Certificate DSMS name; a part of provisioning ResultData output.")
  @visibility("read") // A part of provisioning ResultData output, gets PATCHed back from FRP.
  chainedCertificateDsmsName?: string;

  @doc("Automatically injected if the environment is a child trusted island; a part of provisioning ResultData output.")
  @visibility("read") // A part of provisioning ResultData output, gets PATCHed back from FRP.
  edgeSiteChildTrustIsland?: string;
}

@doc("dsmsCertificate Resource")
model DsmsCertificateResource
  is ProxyResource<DsmsCertificateProperties> { // this can be TrackedResource based on resourcetype
  @doc("The name of resource.")
  @pattern("^[a-zA-Z0-9-]{3,80}$")
  @key("resourceName")
  @segment("dsmsCertificates") // Start with lower case. Should be plural
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
