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

@added(Versions.v2024_03_15_preview)
@doc("Azure for Operators 5G Core virtual Mobility Management Entity (MME) Deployment Resource")
@resource("virtualizedMmeDeployments")
model VirtualizedMmeDeploymentResource
  is TrackedResource<VirtualizedMmeDeploymentResourceProperties> {
  @doc("The name of the Virtualized MME Deployment")
  @pattern("^[a-zA-Z0-9][a-zA-Z0-9-]+[a-zA-Z0-9]$")
  @minLength(1)
  @maxLength(63)
  @key("virtualizedMmeDeploymentName")
  @path
  @segment("virtualizedMmeDeployments")
  @visibility("create", "read")
  name: string;
}

@added(Versions.v2024_03_15_preview)
@doc("Virtualized MME Deployment Properties.")
model VirtualizedMmeDeploymentResourceProperties {
  @doc("The status of the last operation.")
  @visibility("read")
  provisioningState?: ProvisioningState;

  @doc("Operational status")
  @visibility("read")
  operationalStatus?: OperationalStatus;

  @doc("VNF Agent instance managing this Virtualized MME")
  @visibility("read", "create")
  vnfAgent: VnfAgentDeploymentIdProperty;

  @doc("Azure for Operators 5G Core Release Version for Virtualized MME.")
  releaseVersion: ReleaseVersion;

  @doc("Virtualized MME parameters")
  @visibility("read", "create")
  parameters: VirtualizedMmeParameters;

  @doc("Managed On Behalf Of Configuration.")
  @visibility("read")
  managedOnBehalfOfConfiguration?: ManagedOnBehalfOfConfiguration;
}

@added(Versions.v2024_03_15_preview)
@armResourceOperations(VirtualizedMmeDeploymentResource)
interface VirtualizedMmeDeployments {
  get is ArmResourceRead<VirtualizedMmeDeploymentResource>;
  createOrUpdate is ArmResourceCreateOrUpdate2Async<VirtualizedMmeDeploymentResource>;
  updateTags is ArmTagsPatchSync<VirtualizedMmeDeploymentResource>;
  delete is ArmResourceDeleteWithoutOkAsync<VirtualizedMmeDeploymentResource>;
  listByResourceGroup is ArmResourceListByParent<VirtualizedMmeDeploymentResource>;
  listBySubscription is ArmListBySubscription<VirtualizedMmeDeploymentResource>;
}

/* Type definitions */
@added(Versions.v2024_03_15_preview)
@doc("ARM resource ID of a VNF Agent deployment.")
scalar VnfAgentDeploymentIdProperty
  extends Azure.Core.armResourceIdentifier<[
    {
      type: "Microsoft.MobilePacketCore/vnfAgentDeployments",
    }
  ]>;

@added(Versions.v2024_03_15_preview)
@doc("Virtualized MME Parameters")
scalar VirtualizedMmeParameters extends string;
