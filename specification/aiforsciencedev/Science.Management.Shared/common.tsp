import "@typespec/http";
import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.Core;
using Azure.ResourceManager;

/** Microsoft.Science Resource Provider management API. */
@armProviderNamespace
@service({
  title: "Microsoft.Science management service",
})
@versioned(Microsoft.Science.Versions)
namespace Microsoft.Science;

/** The available API versions. */
enum Versions {
  /** 2024-11-01-preview version */
  @useDependency(Azure.ResourceManager.Versions.v1_0_Preview_1)
  @useDependency(Azure.Core.Versions.v1_0_Preview_2)
  @armCommonTypesVersion(Azure.ResourceManager.CommonTypes.Versions.v5)
  v2024_11_01_preview: "2024-11-01-preview",
}

/** The resource provisioning state. */
@lroStatus
union ProvisioningState {
  ResourceProvisioningState,

  /** The resource create request has been accepted */
  Accepted: "Accepted",

  /** The resource is being provisioned */
  Provisioning: "Provisioning",

  /** The resource is updating */
  Updating: "Updating",

  /** The resource is being deleted */
  Deleting: "Deleting",

  string,
}

@doc("For adding title to display instead of name.")
model WithTitle {
  @doc("The title")
  @visibility("read", "create", "update")
  // Defaults to name."
  title: string;
}
