import "@typespec/http";
import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.ResourceManager;

namespace Private.StorageDataRp;

#suppress "@azure-tools/typespec-azure-core/no-closed-literal-union" "Suppress warnings for close enums"
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

// Add the "@azure-tools/typespec-azure-core/no-closed-literal-union" suppression
// and remove "string" literal once new properties are added.
@doc("The type of the backing data source")
union SourceType {
  @doc("Source type - Bucket")
  Bucket: "Bucket",

  string,
}

#suppress "@azure-tools/typespec-azure-core/no-closed-literal-union" "Suppress warnings for close enums"
@doc("The state of the connector")
union State {
  @doc("Whether the connector is enabled")
  Enabled: "Enabled",

  @doc("Whether the connector is disabled")
  Disabled: "Disabled",

  @added(Versions.`2025-01-01-preview`)
  @doc("Whether the connector is restricted with some conditions")
  Restricted: "Restricted",
}

// Add the "@azure-tools/typespec-azure-core/no-closed-literal-union" suppression
// and remove "string" literal once new properties are added.
@doc("The auth type supported for bucket connection.")
union AuthType {
  @doc("Access Key auth type")
  AccessKey: "AccessKey",

  string,
}

#suppress "@azure-tools/typespec-azure-core/no-closed-literal-union" "Suppress warnings for close enums"
@doc("The connection type for bucket connection")
union ConnectionType {
  @doc("Endpoint connection type")
  Endpoint: "Endpoint",

  @doc("Private Link connection type")
  PrivateLink: "PrivateLink",
}

#suppress "@azure-tools/typespec-azure-core/no-closed-literal-union" "Suppress warnings for close enums"
@doc("The TLS Verification options")
union TlsVerification {
  @doc("Perform TLS Verification")
  Perform: "Perform",

  @doc("Use AllowSelfSignedCerts as TlsVerification")
  AllowSelfSignedCerts: "AllowSelfSignedCerts",
}

#suppress "@azure-tools/typespec-azure-core/no-closed-literal-union" "Suppress warnings for close enums"
@doc("The supported PrivateLinkId types")
union PrivateLinkIdType {
  @doc("ResourceId for PrivateLink ID")
  ResourceId: "ResourceId",

  @doc("Alias for Private Link")
  Alias: "Alias",
}

#suppress "@azure-tools/typespec-azure-core/no-closed-literal-union" "Suppress warnings for close enums"
@doc("The status of the private link")
union PrivateLinkStatus {
  @doc("Private Link in pending")
  Pending: "Pending",

  @doc("Private Link is approved")
  Approved: "Approved",

  @doc("Private Link in rejected")
  Rejected: "Rejected",

  @doc("Private Link is disconnected")
  Disconnected: "Disconnected",

  @doc("Private Link Provisioning timed out")
  Timeout: "Timeout",
}
