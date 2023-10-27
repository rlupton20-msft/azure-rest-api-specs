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

@doc("Azure for Operators 5G Core virtual MME/SGSN Deployment Resource")
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

  @doc("MME deployment type")
  @visibility("create", "read")
  deploymentType: SkuDeploymentType;

  @doc("Billing Details")
  @visibility("read")
  billingDetails?: BillingDetails;

  @doc("Operational status")
  @visibility("read")
  operationalStatus?: OperationalStatus;

  @doc("EMS instance managing this MME")
  @visibility("read", "create")
  emsDeployment: EmsDeploymentIdProperty;

  @doc("MME Release Version")
  mmeRelease: VirtualMmeRelease;

  @doc("MME Parameters")
  mmeParameters: MmeParameters;

  @doc("MME Secrets")
  @secret
  mmeSecrets: MmeSecrets;

  @doc("MME deployment NFVI type specific data")
  @visibility("read", "create")
  typeSpecificData: MmeDeploymentProfileTypeSpecificData;
}

@armResourceOperations(MmeDeploymentResource)
interface MmeDeployments {
  get is ArmResourceRead<MmeDeploymentResource>;
  createOrUpdate is ArmResourceCreateOrUpdate2Async<MmeDeploymentResource>;
  updateTags is ArmTagsPatchSync<MmeDeploymentResource>;
  delete is ArmResourceDeleteSync<MmeDeploymentResource>;
  listByResourceGroup is ArmResourceListByParent<MmeDeploymentResource>;
  listBySubscription is ArmListBySubscription<MmeDeploymentResource>;
}

/* Type definitions */
@doc("MME Deployment Profile type specific data.")
@discriminator("type")
model MmeDeploymentProfileTypeSpecificData {
  @doc("NFVI Type")
  type: InfrastructureType;
}

@doc("MME Deployment Profile Azure Core specific data.")
model MmeDeploymentProfileAzureCoreData
  extends MmeDeploymentProfileTypeSpecificData {
  @doc("MME Deployment Properties.")
  type: InfrastructureType.AzureCore;
}

@doc("Azure for Operators 5G Core MME Deployment Resource")
model MmeProfileAzureOperatorNexusData
  extends MmeDeploymentProfileTypeSpecificData {
  @doc("MME Deployment Nexus Properties.")
  type: InfrastructureType.AzureOperatorNexus;

  @doc("Custom Location resource ID")
  customLocationId: CustomLocationIdProperty;
}
