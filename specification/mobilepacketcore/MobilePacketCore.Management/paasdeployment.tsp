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

@doc("Azure for Operators 5G Core PaaS Deployment Resource")
@resource("paasDeployments")
model PaasDeploymentResource
  is TrackedResource<PaasDeploymentResourceProperties> {
  @doc("The name of the PAAS Deployment")
  @pattern("^[a-zA-Z0-9][a-zA-Z0-9-]+[a-zA-Z0-9]$")
  @minLength(1)
  @maxLength(63)
  @key("paasDeploymentName")
  @path
  @segment("paasDeployments")
  @visibility("create", "read")
  name: string;
}

@doc("PAAS Deployment Properties.")
model PaasDeploymentResourceProperties {
  @doc("The status of the last operation.")
  @visibility("read")
  provisioningState?: ProvisioningState;

  @doc("Unity Cloud Observability PaaS federation parameters.  One set per federation type")
  @extension("x-ms-identifiers", ["type"])
  unityCloudFederationParameters: UnityCloudDeploymentParameters[];

  @doc("Operational status")
  @visibility("read")
  operationalStatus?: OperationalStatus;
}

@armResourceOperations(PaasDeploymentResource)
interface PaasDeployments {
  get is ArmResourceRead<PaasDeploymentResource>;
  createOrUpdate is ArmResourceCreateOrUpdate2Async<PaasDeploymentResource>;
  updateTags is ArmTagsPatchSync<PaasDeploymentResource>;
  delete is ArmResourceDeleteSync<PaasDeploymentResource>;
  listByResourceGroup is ArmResourceListByParent<PaasDeploymentResource>;
  listBySubscription is ArmListBySubscription<PaasDeploymentResource>;
}
