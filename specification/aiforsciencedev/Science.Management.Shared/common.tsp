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

/** Microsoft.AiForScience Resource Provider management API. */
@armProviderNamespace
@service({
  title: "Microsoft.AiForScience management service",
})
@versioned(Microsoft.AiForScience.Versions)
namespace Microsoft.AiForScience;

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
  displayName: string;
}

@doc("Managed-On-Behalf-Of configuration properties. This configuration exists for the resources where a resource provider manages those resources on behalf of the resource owner.")
model ManagedOnBehalfOfConfiguration {
  @doc("The resource group for resources managed on behalf of customer.")
  @visibility("read")
  managedResourceGroup: string;

  @doc("Managed-On-Behalf-Of broker resources")
  //  @extension("x-ms-identifiers", ["id"])
  @visibility("read")
  moboBrokerResources?: Azure.ResourceManager.CommonTypes.MoboBrokerResource[];
}
