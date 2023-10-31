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

@doc("Azure for Operators 5G Core Element Management System (EMS) Deployment Resource")
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

  @doc("Azure for Operators 5G Core Release Version.")
  releaseVersion: ReleaseVersion;

  @doc("EMS deployment type (Lab or Production)")
  @visibility("create", "read")
  deploymentType: SkuDeploymentType;

  @doc("Infrastructure type specific data.  Contents depend on the infrastructure type")
  typeSpecificData: EmsDeploymentTypeSpecificData;

  @doc("EMS Parameters")
  emsParameters: EmsParameters;

  @doc("EMS Secrets")
  @secret
  emsSecrets: EmsSecrets;

  @doc("Operational status")
  @visibility("read")
  operationalStatus?: OperationalStatus;
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

/* Type definitions */

@doc("EMS Deployment type specific data.")
@discriminator("type")
model EmsDeploymentTypeSpecificData {
  @doc("Network Function Virtualization Infrastructure Type")
  type: InfrastructureType;
}

@doc("EMS Deployment Azure Core specific data.")
model EmsDeploymentAzureCoreData extends EmsDeploymentTypeSpecificData {
  @doc("EMS Azure Core Deployment Properties.")
  type: InfrastructureType.AzureCore;
}

@doc("EMS Deployment Azure Nexus specific data")
model EmsDeploymentAzureOperatorNexusData
  extends EmsDeploymentTypeSpecificData {
  @doc("EMS Azure Nexus Deployment Properties.")
  type: InfrastructureType.AzureOperatorNexus;

  @doc("Custom Location resource ID")
  customLocationId: CustomLocationIdProperty;
}

@doc("EMS Release definition.")
scalar EmsRelease extends string;

@doc("EMS Parameters")
scalar EmsParameters extends string;

@doc("EMS Secrets")
scalar EmsSecrets extends string;
