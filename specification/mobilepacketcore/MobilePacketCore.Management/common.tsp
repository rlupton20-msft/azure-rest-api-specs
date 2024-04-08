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

/** Compliant create or update template */
/**
 * A long-running resource CreateOrUpdate (PUT)
 * @template TResource the resource being patched
 * @template TBaseParameters Optional. Allows overriding the operation parameters
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-operation" "This is a valid template"
@autoRoute
@doc("Create a {name}", TResource)
@OpenAPI.extension("x-ms-long-running-operation", true)
@OpenAPI.extension(
  "x-ms-long-running-operation-options",
  {
    `final-state-via`: "azure-async-operation",
  }
)
@armResourceCreateOrUpdate(TResource)
@put
op ArmResourceCreateOrUpdate2Async<
  TResource extends Azure.ResourceManager.Foundations.ArmResource,
  TBaseParameters = Azure.ResourceManager.Foundations.BaseParameters<TResource>
>(
  ...ResourceInstanceParameters<TResource, TBaseParameters>,

  @doc("Resource create parameters.")
  @body
  resource: TResource,
): ArmUpdatedResponse<TResource> | ArmCreatedResponse<TResource> | ErrorResponse;

@doc("ARM resource update successful")
model ArmUpdatedResponse<TResource extends Azure.ResourceManager.Foundations.ArmResource>
  is ArmResponse<TResource>;

#suppress "@azure-tools/typespec-azure-core/no-enum"
@doc("Provisioning state of the resource")
@Azure.Core.lroStatus
enum ProvisioningState {
  ...ResourceProvisioningState,

  @doc("Resource is getting provisioned")
  Provisioning,

  @doc("Resource is updating")
  Updating,

  @doc("Resource is getting deleted")
  Deleting,

  @doc("Resource has been accepted")
  Accepted,
}

@doc("ARM resource ID of a cluster.")
scalar ClusterServiceIdProperty
  extends Azure.Core.armResourceIdentifier<[
    {
      type: "Microsoft.MobilePacketCore/clusterServices",
    }
  ]>;

@doc("ARM resource ID of a custom location.")
scalar CustomLocationIdProperty
  extends Azure.Core.armResourceIdentifier<[
    {
      type: "Microsoft.ExtendedLocation/customLocations",
    }
  ]>;

@doc("Operational Status of the resource")
model OperationalStatus {
  @doc("Status of the deployed workload")
  @visibility("read")
  workload?: string;

  @doc("Health check results")
  @visibility("read")
  healthCheck?: string;
}

#suppress "@azure-tools/typespec-azure-core/no-enum"
@doc("Infrastructure Type Definitions")
enum InfrastructureType {
  @doc("Azure Core")
  AzureCore,

  @doc("Azure Operator Nexus")
  AzureOperatorNexus,
}

#suppress "@azure-tools/typespec-azure-core/no-enum"
@doc("Deployment Type Definitions")
enum SkuDeploymentType {
  @doc("Production Deployment")
  Production,

  @doc("Lab Deployment")
  Lab,
}

#suppress "@azure-tools/typespec-azure-core/no-enum"
@doc("Cluster Type Definitions")
enum ClusterType {
  @doc("Azure Kubernetes Service")
  Aks,

  @doc("Azure Operator Nexus Kubernetes Service")
  NexusAks,
}

@doc("Usage SKU Definition")
scalar UsageSku extends string;

@doc("Mobile Core Scaling Unit SKU Definition")
scalar MobileCoreScalingUnitSku extends string;

@doc("Azure for Operators 5G Core Release Version.")
scalar ReleaseVersion extends string;

@doc("Containerized Network Function (CNF) Component Deployment Parameters")
scalar ComponentDeploymentParameters extends string;

@doc("Containerized Network Function (CNF) Component Secrets")
@secret
scalar ComponentDeploymentSecrets extends string;

@doc("Containerized Network Function (CNF) Component Deployment Type")
scalar ComponentDeploymentType extends string;

@doc("Containerized Network Function (CNF) Qualified Deployment Parameters")
model QualifiedComponentDeploymentParameters {
  @doc("Component Type")
  type: ComponentDeploymentType;

  @doc("Deployment Parameters")
  parameters?: ComponentDeploymentParameters;

  @doc("Deployment secrets")
  @visibility("create", "update")
  secrets?: ComponentDeploymentSecrets;
}

@added(Versions.v2024_03_15_preview)
@doc("Configuration of the managed on behalf of resource")
model ManagedOnBehalfOfConfiguration {
  @visibility("read")
  @doc("Associated MoboBrokerResources.")
  moboBrokerResources: MoboBrokerResource[];
}

@added(Versions.v2024_03_15_preview)
@doc("MoboBroker resource")
model MoboBrokerResource {
  @visibility("read")
  @doc("Resource identifier of a Managed-On-Behalf-Of broker resource")
  id: string;
}
