import "@typespec/http";
import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.ResourceManager;

namespace Microsoft.Storage;

// DataShare Properties
@doc("Details of the Storage DataShare.")
@added(Versions.v2025_05_01_preview)
model DataShareProperties {
  @visibility("read")
  @doc("System-generated identifier for the Storage DataShare. Not a valid input parameter when creating.")
  dataShareIdentifier?: string;

  @doc("List of access policies that specify the permission allowed to a managed identity.")
  @OpenAPI.extension("x-ms-identifiers", [])
  accessPolicies: AccessPolicy[];

  @doc("List of paths that specify the properties of a shared resource.")
  @OpenAPI.extension("x-ms-identifiers", [])
  paths: Path[];
 
  @visibility("read")
  @doc("The status of the last operation.")
  provisioningState?: ProvisioningState;
}

// Access Policy
@doc("Policy that specify the permission allowed to a managed identity.")
@added(Versions.v2025_05_01_preview)
model AccessPolicy {
  @doc("The AAD principal ID of the Managed Identity.")
  principalId: string;

  @doc("The AAD tenant ID of the Managed Identity.")
  tenantId: string;

  @doc("Allowed permissions. Currently, only supported value is ‘r’ for Read.")
  @pattern("^[r]$")
  permissions: string;
}

// Path
@doc("Properties of a shared resource.")
@added(Versions.v2025_05_01_preview)
model Path {
  @doc("Source path to be shared. It can be a folder or a blob. The physical path should contain container name followed by path within the container, e.g. /container1/logs/external.")
  physicalPath: string;
  @doc("Consumer visible path of the original path.")
  virtualPath: string;
}