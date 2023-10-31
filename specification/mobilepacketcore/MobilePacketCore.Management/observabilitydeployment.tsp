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

@doc("Azure for Operators 5G Core Observability Deployment Resource")
@resource("observabilityDeployments")
model ObservabilityDeploymentResource
  is TrackedResource<ObservabilityDeploymentResourceProperties> {
  @doc("The name of the Observability Deployment")
  @pattern("^[a-zA-Z0-9][a-zA-Z0-9-]+[a-zA-Z0-9]$")
  @minLength(1)
  @maxLength(63)
  @key("observabilityDeploymentName")
  @path
  @segment("observabilityDeployments")
  @visibility("create", "read")
  name: string;
}

@doc("Observability Deployment Properties.")
model ObservabilityDeploymentResourceProperties {
  @doc("The status of the last operation.")
  @visibility("read")
  provisioningState?: ProvisioningState;

  @doc("Azure for Operators 5G Core Observability component parameters.  One set per component type")
  @extension("x-ms-identifiers", ["type"])
  componentParameters: QualifiedComponentDeploymentParameters[];

  @doc("Release version. This is inherited from the cluster")
  @visibility("read")
  releaseVersion?: ReleaseVersion;

  @doc("Operational status")
  @visibility("read")
  operationalStatus?: OperationalStatus;
}

@armResourceOperations(ObservabilityDeploymentResource)
interface ObservabilityDeployments {
  get is ArmResourceRead<ObservabilityDeploymentResource>;
  createOrUpdate is ArmResourceCreateOrUpdate2Async<ObservabilityDeploymentResource>;
  updateTags is ArmTagsPatchSync<ObservabilityDeploymentResource>;
  delete is ArmResourceDeleteSync<ObservabilityDeploymentResource>;
  listByResourceGroup is ArmResourceListByParent<ObservabilityDeploymentResource>;
  listBySubscription is ArmListBySubscription<ObservabilityDeploymentResource>;
}
