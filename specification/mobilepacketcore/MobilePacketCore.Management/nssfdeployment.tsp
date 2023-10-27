import "@typespec/http";
import "@typespec/rest";
import "@typespec/openapi";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using Azure.Core;
using OpenAPI;

namespace Microsoft.MobilePacketCore;

@doc("Azure for Operators 5G Core NSSF Deployment Resource")
@resource("nssfDeployments")
model NssfDeploymentResource
  is TrackedResource<NssfDeploymentResourceProperties> {
  @doc("The name of the NssfDeployment")
  @pattern("^[a-zA-Z0-9][a-zA-Z0-9-]+[a-zA-Z0-9]$")
  @minLength(1)
  @maxLength(63)
  @key("nssfDeploymentName")
  @path
  @segment("nssfDeployments")
  @visibility("create", "read")
  name: string;
}

@doc("NSSF Deployment Properties.")
model NssfDeploymentResourceProperties {
  @doc("The status of the last operation.")
  @visibility("read")
  provisioningState?: ProvisioningState;

  @doc("UnityCloud NF Federation Parameters")
  unityCloudDeploymentParameters: UnityCloudFederationParameters;

  @doc("Cluster where the NF is deployed")
  @visibility("create", "read")
  cluster: ClusterIdProperty;

  @doc("Unity Cloud Release version of the NF. This is inherited from the cluster")
  unityCloudRelease?: UnityCloudRelease;

  @doc("Deployment status")
  @visibility("read")
  deploymentStatus?: DeploymentStatus;
}

@armResourceOperations(NssfDeploymentResource)
interface NssfDeployments {
  get is ArmResourceRead<NssfDeploymentResource>;
  createOrUpdate is ArmResourceCreateOrUpdate2Async<NssfDeploymentResource>;
  updateTags is ArmTagsPatchSync<NssfDeploymentResource>;
  delete is ArmResourceDeleteSync<NssfDeploymentResource>;
  listByResourceGroup is ArmResourceListByParent<NssfDeploymentResource>;
  listBySubscription is ArmListBySubscription<NssfDeploymentResource>;
}
