using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.Core;
using Azure.ResourceManager;
using OpenAPI;

namespace Private.OracleDatabaseDev;

@added(Versions.v20250301_preview)
@doc("Network Anchor resource model.")
model NetworkAnchor is TrackedResource<NetworkAnchorProperties> {
  ...ResourceNameParameter<NetworkAnchor>;
  ...AvailabilityZonesProperty;
}

@added(Versions.v20250301_preview)
@doc("Network Anchor properties")
model NetworkAnchorProperties {
  @doc("Corresponding resource anchor Azure ID")
  @visibility(Lifecycle.Create, Lifecycle.Read)
  resourceAnchorId: string;

  @doc("NetworkAnchor provisioning state")
  @visibility(Lifecycle.Read)
  provisioningState?: AzureResourceProvisioningState;

  @doc("VNET for network connectivity")
  @visibility(Lifecycle.Read)
  vnetId?: VnetId;

  @doc("Delegated Azure subnet.")
  @visibility(Lifecycle.Create, Lifecycle.Read)
  subnetId: SubnetId;

  @doc("Delegated Azure subnet cidr block.")
  @visibility(Lifecycle.Read)
  cidrBlock?: string;

  @doc("Oracle Cloud Infrastructure VCN OCID")
  @visibility(Lifecycle.Read)
  ociVcnId?: Ocid;

  @doc("OCI DNS label. This is optional if DNS config is provided.")
  @visibility(Lifecycle.Create, Lifecycle.Read)
  ociVcnDnsLabel?: string;

  @doc("Oracle Cloud Infrastructure subnet OCID")
  @visibility(Lifecycle.Read)
  ociSubnetId?: Ocid;

  @doc("OCI backup subnet cidr block.")
  @visibility(Lifecycle.Create, Lifecycle.Update, Lifecycle.Read)
  ociBackupCidrBlock?: string;

  @added(Versions.v20250701_preview)
  @doc("DnsResolutionFromOciToAzure properties")
  @visibility(Lifecycle.Create, Lifecycle.Update, Lifecycle.Read)
  dnsResolutionFromOciToAzureProperties?: DnsResolutionFromOciToAzureProperties;

  @added(Versions.v20250701_preview)
  @doc("DnsResolutionFromAzureToOci properties")
  @visibility(Lifecycle.Create, Lifecycle.Update, Lifecycle.Read)
  dnsResolutionFromAzureToOciProperties?: DnsResolutionFromAzureToOciProperties;
}

@added(Versions.v20250701_preview)
@doc("DnsResolutionFromOciToAzure properties")
model DnsResolutionFromOciToAzureProperties {
  @doc("Indicates whether DNS forwarding from OCI to Azure is enabled for the Network Anchor.")
  isEnabled?: boolean = false;

  @doc("The domain name used for DNS forwarding from OCI to Azure.")
  @minLength(1)
  @maxLength(255)
  domainName?: string;

  @doc("The IP address used for DNS forwarding from OCI to Azure.")
  forwardingIpAddress?: string;
}

@added(Versions.v20250701_preview)
@doc("DnsResolutionFromAzureToOci properties")
model DnsResolutionFromAzureToOciProperties {
  @doc("Indicates whether DNS forwarding from Azure to OCI is enabled for the Network Anchor.")
  isEnabled?: boolean = false;

  @doc("The IP address used for DNS forwarding from Azure to OCI.")
  listeningEndpointIpAddress?: string;
}
