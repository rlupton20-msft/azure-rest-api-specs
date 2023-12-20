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

@doc("Azure for Operators 5G Core virtual Mobility Management Entity (MME) Deployment Resource")
@resource("mmeDeployments")
model MmeDeploymentResource
  is TrackedResource<MmeDeploymentResourceProperties> {
  @doc("The name of the MME Deployment")
  @pattern("^[a-zA-Z0-9][a-zA-Z0-9-]+[a-zA-Z0-9]$")
  @minLength(1)
  @maxLength(63)
  @key("mmeDeploymentName")
  @path
  @segment("mmeDeployments")
  @visibility("create", "read")
  name: string;
}

@doc("MME Deployment Properties.")
model MmeDeploymentResourceProperties {
  @doc("The status of the last operation.")
  @visibility("read")
  provisioningState?: ProvisioningState;

  @doc("Managed Resource Group Configuration")
  @visibility("create", "read")
  managedResourceGroupConfiguration?: ManagedResourceGroupConfiguration;

  @doc("MME deployment type (Lab or Production)")
  @visibility("create", "read")
  deploymentType: SkuDeploymentType;

  @doc("Operational status")
  @visibility("read")
  operationalStatus?: OperationalStatus;

  @doc("VNF Agent instance managing this MME")
  @visibility("read", "create")
  vnfAgentDeployment: VnfAgentDeploymentIdProperty;

  @doc("Azure for Operators 5G Core Release Version.")
  releaseVersion: ReleaseVersion;

  @doc("MME Parameters")
  mmeParameters: VirtualMmeParameters;

  @doc("MME Secrets")
  @secret
  mmeSecrets: VirtualMmeSecrets;

  @doc("Infrastructure type specific data.  Contents depend on the infrastructure type")
  @visibility("read", "create")
  typeSpecificData: MmeDeploymentTypeSpecificData;
}

@armResourceOperations(MmeDeploymentResource)
interface MmeDeployments {
  get is ArmResourceRead<MmeDeploymentResource>;
  createOrUpdate is ArmResourceCreateOrUpdate2Async<MmeDeploymentResource>;
  updateTags is ArmTagsPatchSync<MmeDeploymentResource>;
  delete is ArmResourceDeleteAsync<MmeDeploymentResource>;
  listByResourceGroup is ArmResourceListByParent<MmeDeploymentResource>;
  listBySubscription is ArmListBySubscription<MmeDeploymentResource>;
}

/* Type definitions */
@doc("MME Deployment type specific data.")
@discriminator("type")
model MmeDeploymentTypeSpecificData {
  @doc("Network Function Virtualization Infrastructure Type")
  type: InfrastructureType;
}

@doc("MME Deployment Profile Azure Core specific data.")
model MmeDeploymentProfileAzureCoreData extends MmeDeploymentTypeSpecificData {
  @doc("MME Deployment Properties.")
  type: InfrastructureType.AzureCore;
}

@doc("Azure for Operators 5G Core MME Deployment Resource")
model MmeProfileAzureOperatorNexusData extends MmeDeploymentTypeSpecificData {
  @doc("MME Deployment Nexus Properties.")
  type: InfrastructureType.AzureOperatorNexus;

  @doc("Custom Location resource ID")
  customLocationId: CustomLocationIdProperty;
}

@doc("Virtual MME Release definition.")
scalar VirtualMmeRelease extends string;

@doc("Virtual MME Parameters")
scalar VirtualMmeParameters extends string;

@doc("Virtual MME Secrets")
scalar VirtualMmeSecrets extends string;
