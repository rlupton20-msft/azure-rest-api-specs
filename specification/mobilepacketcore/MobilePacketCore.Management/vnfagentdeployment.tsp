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

@doc("Azure for Operators 5G Core Virtual Network Function Agent (VnfAgent) Deployment Resource")
@resource("vnfAgentDeployments")
model VnfAgentDeploymentResource
  is TrackedResource<VnfAgentDeploymentResourceProperties> {
  @doc("The name of the VnfAgent Deployment")
  @pattern("^[a-zA-Z0-9][a-zA-Z0-9-]+[a-zA-Z0-9]$")
  @minLength(1)
  @maxLength(63)
  @key("vnfAgentDeploymentName")
  @path
  @segment("vnfAgentDeployments")
  @visibility("create", "read")
  name: string;
}

@doc("VnfAgent Deployment Properties.")
model VnfAgentDeploymentResourceProperties {
  @doc("The status of the last operation.")
  @visibility("read")
  provisioningState?: ProvisioningState;

  @doc("Managed Resource Group Configuration")
  @visibility("create", "read")
  managedResourceGroupConfiguration?: ManagedResourceGroupConfiguration;

  @doc("Azure for Operators 5G Core Release Version.")
  releaseVersion: ReleaseVersion;

  @doc("VnfAgent deployment type (Lab or Production)")
  @visibility("create", "read")
  deploymentType: SkuDeploymentType;

  @doc("Infrastructure type specific data.  Contents depend on the infrastructure type")
  typeSpecificData: VnfAgentDeploymentTypeSpecificData;

  @doc("VnfAgent Parameters")
  vnfAgentParameters: VnfAgentParameters;

  @doc("VnfAgent Secrets")
  @secret
  vnfAgentSecrets: VnfAgentSecrets;

  @doc("Operational status")
  @visibility("read")
  operationalStatus?: OperationalStatus;
}

@armResourceOperations(VnfAgentDeploymentResource)
interface VnfAgentDeployments {
  get is ArmResourceRead<VnfAgentDeploymentResource>;
  createOrUpdate is ArmResourceCreateOrUpdate2Async<VnfAgentDeploymentResource>;
  updateTags is ArmTagsPatchSync<VnfAgentDeploymentResource>;
  delete is ArmResourceDeleteWithoutOkAsync<VnfAgentDeploymentResource>;
  listByResourceGroup is ArmResourceListByParent<VnfAgentDeploymentResource>;
  listBySubscription is ArmListBySubscription<VnfAgentDeploymentResource>;
}

/* Type definitions */

@doc("VnfAgent Deployment type specific data.")
@discriminator("type")
model VnfAgentDeploymentTypeSpecificData {
  @doc("Network Function Virtualization Infrastructure Type")
  type: InfrastructureType;
}

@doc("VnfAgent Deployment Azure Core specific data.")
model VnfAgentDeploymentAzureCoreData
  extends VnfAgentDeploymentTypeSpecificData {
  @doc("VnfAgent Azure Core Deployment Properties.")
  type: InfrastructureType.AzureCore;
}

@doc("VnfAgent Deployment Azure Nexus specific data")
model VnfAgentDeploymentAzureOperatorNexusData
  extends VnfAgentDeploymentTypeSpecificData {
  @doc("VnfAgent Azure Nexus Deployment Properties.")
  type: InfrastructureType.AzureOperatorNexus;

  @doc("Custom Location resource ID")
  customLocationId: CustomLocationIdProperty;
}

@doc("VnfAgent Release definition.")
scalar VnfAgentRelease extends string;

@doc("VnfAgent Parameters")
scalar VnfAgentParameters extends string;

@doc("VnfAgent Secrets")
scalar VnfAgentSecrets extends string;
