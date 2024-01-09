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

@added(Versions.v2024_01_15_preview)
@doc("Azure for Operators 5G Core Subscriber Data Management Function (SDM) Deployment Resource")
@resource("sdmDeployments")
model SdmDeploymentResource
  is TrackedResource<SdmDeploymentResourceProperties> {
  @doc("The name of the SdmDeployment")
  @pattern("^[a-zA-Z0-9][a-zA-Z0-9-]+[a-zA-Z0-9]$")
  @minLength(1)
  @maxLength(63)
  @key("sdmDeploymentName")
  @path
  @segment("sdmDeployment")
  @visibility("create", "read")
  name: string;
}

@added(Versions.v2024_01_15_preview)
@doc("SDM Deployment Properties.")
model SdmDeploymentResourceProperties {
  @doc("The status of the last operation.")
  @visibility("read")
  provisioningState?: ProvisioningState;

  @doc("Azure for Operators 5G Core SDM component parameters.  One set per component type")
  @extension("x-ms-identifiers", ["type"])
  componentParameters: QualifiedComponentDeploymentParameters[];
  
  @doc("Reference to cluster service in which the Network Functions are deployed")
  @visibility("create", "read")
  clusterService: ClusterServiceIdProperty;

  @doc("Release version. This is inherited from the cluster")
  @visibility("read")
  releaseVersion?: ReleaseVersion;

  @doc("Operational status")
  @visibility("read")
  operationalStatus?: OperationalStatus;
}

@added(Versions.v2024_01_15_preview)
@armResourceOperations(SdmDeploymentResource)
interface SdmDeployments {
  get is ArmResourceRead<SdmDeploymentResource>;
  createOrUpdate is ArmResourceCreateOrUpdate2Async<SdmDeploymentResource>;
  updateTags is ArmTagsPatchSync<SdmDeploymentResource>;
  delete is ArmResourceDeleteWithoutOkAsync<SdmDeploymentResource>;
  listByResourceGroup is ArmResourceListByParent<SdmDeploymentResource>;
  listBySubscription is ArmListBySubscription<SdmDeploymentResource>;
}
