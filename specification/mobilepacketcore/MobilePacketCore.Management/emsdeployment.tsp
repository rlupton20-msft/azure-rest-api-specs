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

@doc("Azure for Operators 5G Core EMS Deployment Resource")
@resource("emsDeployments")
model EmsDeploymentResource
  is TrackedResource<EmsDeploymentResourceProperties> {
  @doc("The name of the EMS Deployment")
  @pattern("^[a-zA-Z0-9][a-zA-Z0-9-]+[a-zA-Z0-9]$")
  @minLength(1)
  @maxLength(63)
  @key("emsDeploymentName")
  @path
  @segment("emsDeployments")
  @visibility("create", "read")
  name: string;
}

@doc("EMS Deployment Properties.")
model EmsDeploymentResourceProperties {
  @doc("The status of the last operation.")
  @visibility("read")
  provisioningState?: ProvisioningState;

  @doc("Mobile Core Scaling Unit SKU")
  @visibility("create", "read")
  mobileCoreScalingUnitSku: MobileCoreScalingUnitSku;

  @doc("EMS Release Version")
  emsRelease: EmsRelease;

  @doc("Deployment status")
  @visibility("read")
  deploymentStatus?: DeploymentStatus;

  @doc("Mobile Core Scaling Units (MCSU)")
  @visibility("read")
  actualMobileCoreScalingUnits?: float32;
}

@armResourceOperations(EmsDeploymentResource)
interface EmsDeployments {
  get is ArmResourceRead<EmsDeploymentResource>;
  createOrUpdate is ArmResourceCreateOrUpdate2Async<EmsDeploymentResource>;
  updateTags is ArmTagsPatchSync<EmsDeploymentResource>;
  delete is ArmResourceDeleteSync<EmsDeploymentResource>;
  listByResourceGroup is ArmResourceListByParent<EmsDeploymentResource>;
  listBySubscription is ArmListBySubscription<EmsDeploymentResource>;
}
