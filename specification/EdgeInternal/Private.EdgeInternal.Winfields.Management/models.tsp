import "@typespec/rest";
import "@typespec/http";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.ResourceManager;
using TypeSpec.OpenAPI;

namespace Private.EdgeInternal;

@doc("ResourceProvisioningState Enum")
enum ResourceProvisioningState {
  @doc("Resource has been created.") Succeeded,
  @doc("Resource creation failed.") Failed,
  @doc("Resource creation was canceled.") Canceled,
  @doc("Resource  is being Provisioned.") Provisioning,
  @doc("Resource has been updating.") Updating,
  @doc("Resource is being deleted.") Deleting,
  @doc("Resource was Accepted.") Accepted,
}

@doc("The resource connection intend model enum")
enum ConnectionIntend {
  @doc("Directly connected to the cloud.") DirectlyConnected,
  @doc("Indirectly connected to the cloud.") IndirectlyConnected
}

@doc("The winfield properties")
model WinfieldProperties {
  @visibility("read")
  @doc("The resource provisioning state")
  provisioningState?: ResourceProvisioningState;
  
  @doc("The connection intend")
  connectionIntend: ConnectionIntend;
}

@doc("The winfield manifest")
model WinfieldDeploymentManifest {
  @visibility("read")
  @doc("The resource Id")
  resourceId: string;

  @visibility("read")
  @doc("The resource name")
  resourceName: string;

  @visibility("read")
  @doc("The Deployment Id")
  deploymentId: string;

  @visibility("read")
  @doc("The resource location")
  location: string;
}
