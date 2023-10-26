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

@doc("Azure for Operators 5G Core SMF/SAEGW-CP/GGSN Deployment Resource")
@resource("smfDeployment")
model SmfDeploymentResource
  is TrackedResource<SmfDeploymentResourceProperties> {
  @doc("The name of the SmfDeployment")
  @pattern("^[a-zA-Z0-9][a-zA-Z0-9-]+[a-zA-Z0-9]$")
  @minLength(1)
  @maxLength(63)
  @key("smfDeploymentName")
  @path
  @segment("smfDeployment")
  @visibility("create", "read")
  name: string;
}

@doc("SMF Deployment Properties.")
model SmfDeploymentResourceProperties {
  @doc("The status of the last operation.")
  @visibility("read")
  provisioningState?: ProvisioningState;

  @doc("Usage SKU")
  @visibility("create", "read")
  usageSku: UsageSku;

  @doc("UnityCloud NF Federation Parameters")
  unityCloudDeploymentParameters: UnityCloudFederationParameters;

  @doc("Cluster where the NF is deployed")
  @visibility("create", "read")
  cluster: ClusterIdProperty;

  @doc("Unity Cloud Release version of the NF. This is inherited from the cluster")
  unityCloudRelease?: UnityCloudRelease;

  @doc("PDN/PDU Sessions")
  @visibility("read")
  sessionCount?: int32;

  @doc("Deployment status")
  @visibility("read")
  deploymentStatus?: DeploymentStatus;
}

@armResourceOperations(SmfDeploymentResource)
interface SmfDeployments {
  get is ArmResourceRead<SmfDeploymentResource>;
  createOrUpdate is ArmResourceCreateOrUpdate2Async<SmfDeploymentResource>;
  updateTags is ArmTagsPatchSync<SmfDeploymentResource>;
  delete is ArmResourceDeleteSync<SmfDeploymentResource>;
  listByResourceGroup is ArmResourceListByParent<SmfDeploymentResource>;
  listBySubscription is ArmListBySubscription<SmfDeploymentResource>;
}
