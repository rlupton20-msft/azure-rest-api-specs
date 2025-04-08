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
@service(#{ title: "Microsoft.Science management service" })
@versioned(Microsoft.Science.Versions)
namespace Microsoft.Science;

/** The available API versions. */
enum Versions {
  /** 2024-11-01-preview version */
  @useDependency(Azure.ResourceManager.Versions.v1_0_Preview_1)
  @useDependency(Azure.Core.Versions.v1_0_Preview_2)
  @armCommonTypesVersion(Azure.ResourceManager.CommonTypes.Versions.v6)
  v2024_11_01_preview: "2024-11-01-preview",

  /** 2025-07-01-preview version */
  @useDependency(Azure.ResourceManager.Versions.v1_0_Preview_1)
  @useDependency(Azure.Core.Versions.v1_0_Preview_2)
  @armCommonTypesVersion(Azure.ResourceManager.CommonTypes.Versions.v6)
  v2025_07_01_preview: "2025-07-01-preview",
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
  @visibility(Lifecycle.Read, Lifecycle.Create, Lifecycle.Update)
  displayName: string;
}

@doc("For adding description.")
model WithDescription {
  @doc("The description")
  @visibility(Lifecycle.Read, Lifecycle.Create, Lifecycle.Update)
  description: string;
}

@doc("Managed-On-Behalf-Of broker resource. This resource is created by the Resource Provider to manage some resources on behalf of the user.")
model MoboBrokerResource {
  @doc("Resource identifier of a Managed-On-Behalf-Of broker resource")
  @visibility(Lifecycle.Read)
  id: armResourceIdentifier;
}

/** For tracking mobo resources */
model WithMoboBrokerResources {
  @doc("Managed-On-Behalf-Of broker resources")
  // TODO: Azure.ResourceManager.CommonTypes.MoboBrokerResource was in common types v5 but not v6. Find out why.
  @visibility(Lifecycle.Read)
  moboBrokerResources?: MoboBrokerResource[];
}

@doc("Managed-On-Behalf-Of configuration properties. This configuration exists for the resources where a resource provider manages those resources on behalf of the resource owner.")
model MoboConfigurationWithMrg {
  @doc("The resource group for resources managed on behalf of customer.")
  @visibility(Lifecycle.Read)
  managedResourceGroup?: string;

  /** Managed-On-Behalf-Of configuration properties. This configuration exists for the resources where a resource provider manages those resources on behalf of the resource owner. */
  @visibility(Lifecycle.Read)
  managedOnBehalfOfConfiguration?: WithMoboBrokerResources;
}

alias DataContainerId = Azure.Core.armResourceIdentifier<[
  {
    type: "Microsoft.Science/DataContainers";
  }
]>;

alias DataAssetId = Azure.Core.armResourceIdentifier<[
  {
    type: "Microsoft.Science/DataContainers/DataAssets";
  }
]>;

alias StorageId = Azure.Core.armResourceIdentifier<[
  {
    type: "Microsoft.Science/Storages";
  }
]>;

alias BookShelfId = Azure.Core.armResourceIdentifier<[
  {
    type: "Microsoft.Science/Bookshelves";
  }
]>;

alias SuperComputerId = Azure.Core.armResourceIdentifier<[
  {
    type: "Microsoft.Science/SuperComputers";
  }
]>;

alias ToolId = Azure.Core.armResourceIdentifier<[
  {
    type: "Microsoft.Science/Tools";
  }
]>;

alias AgentId = Azure.Core.armResourceIdentifier<[
  {
    type: "Microsoft.Science/Agents";
  }
]>;

alias ModelId = Azure.Core.armResourceIdentifier<[
  {
    type: "Microsoft.Science/Models";
  }
]>;

alias NodePoolId = Azure.Core.armResourceIdentifier<[
  {
    type: "Microsoft.Science/Supercomputers/NodePools";
  }
]>;

alias WorkspaceId = Azure.Core.armResourceIdentifier<[
  {
    type: "Microsoft.Science/workspaces";
  }
]>;
