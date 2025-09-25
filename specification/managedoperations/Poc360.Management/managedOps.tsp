import "@typespec/http";
import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

using Http;
using Rest;
using Versioning;
using Azure.Core;
using Azure.ResourceManager;

@armProviderNamespace
@service(#{ title: "Managed Operations control plane service" })
@doc("Managed Operations API.")
@versioned(global.Private.Poc360.Versions)
namespace global.Private.Poc360;

@doc("The Managed Operations resource.")
@subscriptionResource
@added(Versions.v2024_08_01_preview)
@added(Versions.v2023_04_01_preview)
model ManagedOp is ProxyResource<ManagedOpsProperties> {
  /** Fix the name of the resource to ensure it is a singleton */
  @doc("Name of the resource.")
  @key("managedOpsName")
  @pattern("default")
  @segment("managedOps")
  @path
  name: string;
}

/** The operations that can be performed on our resource */
@armResourceOperations(ManagedOp)
@added(Versions.v2024_08_01_preview)
@added(Versions.v2023_04_01_preview)
interface ManagedOps {
  @doc("Gets the information of the ManagedOps instance.")
  get is ArmResourceRead<ManagedOp>;

  @doc("Creates or updates the ManagedOps instance.")
  createOrUpdate is ArmResourceCreateOrUpdateAsync<ManagedOp>;

  @doc("Updates the ManagedOps instance with the supplied fields.")
  update is ArmCustomPatchAsync<
    ManagedOp,
    Azure.ResourceManager.Foundations.ResourceUpdateModel<
      ManagedOp,
      ManagedOpsProperties
    >
  >;

  @doc("Deletes the ManagedOps instance.")
  delete is ArmResourceDeleteWithoutOkAsync<ManagedOp>;

  @doc("Makes a POST operation on the ManagedOps instance.")
  remediate is ArmResourceActionNoResponseContentAsync<ManagedOp, void>;
}

@doc("Properties of the ManagedOps resource.")
@added(Versions.v2024_08_01_preview)
@added(Versions.v2023_04_01_preview)
model ManagedOpsProperties {
  @doc("Product plan details of this resource.")
  @visibility(Lifecycle.Read)
  sku?: ManagedOpsSku;

  @doc("Provisioning state of the resource.")
  @visibility(Lifecycle.Read)
  provisioningState?: ManagedOpsProvisioningState;

  @doc("Desired configuration used when provisioning the resource.")
  @visibility(Lifecycle.Read, Lifecycle.Create, Lifecycle.Update)
  desiredConfiguration: ManagedOpsDesiredConfiguration;

  @doc("Services provisioned by this resource.")
  @visibility(Lifecycle.Read)
  services?: ManagedOpsServiceInformation;

  @doc("Policy assignments created for managing services.")
  @visibility(Lifecycle.Read)
  policyAssignmentProperties?: PolicyAssignmentProperties;
}

@doc("Services provisioned by this resource.")
@added(Versions.v2024_08_01_preview)
@added(Versions.v2023_04_01_preview)
model ManagedOpsServiceInformation {
  @doc("Change Tracking and Inventory service information.")
  @visibility(Lifecycle.Read)
  changeTrackingAndInventory?: ManagedOpsChangeTrackingInformation;

  @doc("Azure Monitor Insights service information.")
  @visibility(Lifecycle.Read)
  azureMonitorInsights?: ManagedOpsAzureMonitorInformation;

  @doc("Azure Update Manager service information.")
  @visibility(Lifecycle.Read)
  azureUpdateManager?: ManagedOpsUpdateManagerInformation;

  @doc("Azure Policy and Machine Configuration service information.")
  @visibility(Lifecycle.Read)
  azurePolicyAndMachineConfiguration?: ManagedOpsGuestConfigurationInformation;

  @doc("Defender for Servers service information.")
  @visibility(Lifecycle.Read)
  defenderForServers?: DefenderForServersInformation;

  @doc("Defender for Cloud's Cloud security posture management (CSPM) service information.")
  @visibility(Lifecycle.Read)
  defenderCspm?: DefenderCspmInformation;
}

@doc("Policy assignments created for managing services.")
@added(Versions.v2024_08_01_preview)
@added(Versions.v2023_04_01_preview)
model PolicyAssignmentProperties {
  @doc("Policy initiative assignment ID.")
  policyInitiativeAssignmentId: armResourceIdentifier<[
    {
      type: "Microsoft.Authorization/policyassignments";
    }
  ]>;
}

alias enablementState =
  | "Enabled"
  | "InProgress"
  | "Failed"
  | "Disabled"
  | string;

@doc("Change Tracking and Inventory service information.")
@added(Versions.v2024_08_01_preview)
@added(Versions.v2023_04_01_preview)
model ManagedOpsChangeTrackingInformation {
  @doc("ID of Data Collection Rule (DCR) associated with this service.")
  dcrId?: armResourceIdentifier<[
    {
      type: "Microsoft.Insights/dataCollectionRules";
    }
  ]>;

  @doc("Indicates whether the service is enabled.")
  enablementStatus: enablementState;
}

@doc("Azure Monitor service information.")
model ManagedOpsAzureMonitorInformation {
  @doc("ID of Data Collection Rule (DCR) associated with this service.")
  dcrId?: armResourceIdentifier<[
    {
      type: "Microsoft.Insights/dataCollectionRules";
    }
  ]>;

  @doc("Indicates whether the service is enabled.")
  enablementStatus: enablementState;
}

@doc("Azure Update Manager service information.")
@added(Versions.v2024_08_01_preview)
@added(Versions.v2023_04_01_preview)
model ManagedOpsUpdateManagerInformation {
  @doc("ID of Data Collection Rule (DCR) associated with this service.")
  dcrId?: armResourceIdentifier<[
    {
      type: "Microsoft.Insights/dataCollectionRules";
    }
  ]>;

  @doc("ID of Data Collection Endpoint (DCE) associated with this service.")
  dceId?: armResourceIdentifier<[
    {
      type: "Microsoft.Insights/dataCollectionEndpoints";
    }
  ]>;

  @doc("Indicates whether the service is enabled.")
  enablementStatus: enablementState;
}

@doc("Azure Policy and Machine Configuration service information.")
@added(Versions.v2024_08_01_preview)
@added(Versions.v2023_04_01_preview)
model ManagedOpsGuestConfigurationInformation {
  @doc("Indicates whether the service is enabled.")
  enablementStatus: enablementState;
}

@doc("Defender for Servers service information.")
@added(Versions.v2024_08_01_preview)
@added(Versions.v2023_04_01_preview)
model DefenderForServersInformation {
  @doc("Indicates whether the service is enabled.")
  enablementStatus: enablementState;
}

@doc("Defender Cloud Security Posture Management (CSPM) service information.")
@added(Versions.v2024_08_01_preview)
@added(Versions.v2023_04_01_preview)
model DefenderCspmInformation {
  @doc("Indicates whether the service is enabled.")
  enablementStatus: enablementState;
}

@doc("Specifies the service plan for this resource.")
@added(Versions.v2024_08_01_preview)
@added(Versions.v2023_04_01_preview)
model ManagedOpsSku {
  @doc("Name of the SKU.")
  name: string;

  @doc("Pricing tier of the SKU.")
  tier: string;
}

@doc("Desired configuration parameters.")
@added(Versions.v2024_08_01_preview)
@added(Versions.v2023_04_01_preview)
model ManagedOpsDesiredConfiguration {
  @doc("Configuration for the Change Tracking and Inventory service.")
  @visibility(Lifecycle.Read, Lifecycle.Create)
  changeTrackingAndInventory: ManagedOpsChangeTrackingConfiguration;

  @doc("Configuration for the Azure Monitor service.")
  @visibility(Lifecycle.Read, Lifecycle.Create)
  azureMonitorInsights: ManagedOpsAzureMonitorConfiguration;

  @doc("User assigned Managed Identity used to perform operations on machines managed by Ops360.")
  @visibility(Lifecycle.Read, Lifecycle.Create)
  userAssignedManagedIdentityId: armResourceIdentifier<[
    {
      type: "Microsoft.ManagedIdentity/userAssignedIdentities";
    }
  ]>;

  @doc("Desired enablement state of the Defender For Servers service.")
  @visibility(Lifecycle.Read, Lifecycle.Update, Lifecycle.Create)
  defenderForServers?: desiredEnablementState;

  @doc("Desired enablement state of the Defender Cloud Security Posture Management (CSPM) service.")
  @visibility(Lifecycle.Read, Lifecycle.Update, Lifecycle.Create)
  defenderCspm?: desiredEnablementState;
}

alias desiredEnablementState = "Enable" | "Disable" | string;

@doc("Configuration for the Change Tracking and Inventory service.")
@added(Versions.v2024_08_01_preview)
@added(Versions.v2023_04_01_preview)
model ManagedOpsChangeTrackingConfiguration {
  @doc("Log analytics workspace resource ID used by the service.")
  logAnalyticsWorkspaceId: armResourceIdentifier<[
    {
      type: "Microsoft.OperationalInsights/workspaces";
    }
  ]>;
}

@doc("Configuration for the Change Tracking and Inventory service.")
@added(Versions.v2024_08_01_preview)
@added(Versions.v2023_04_01_preview)
model ManagedOpsAzureMonitorConfiguration {
  @doc("Azure Monitor workspace resource ID used by the service.")
  azureMonitorWorkspaceId: armResourceIdentifier<[
    {
      type: "Microsoft.Monitor/accounts";
    }
  ]>;
}

@doc("The provisioning state of a resource.")
@lroStatus
@added(Versions.v2024_08_01_preview)
@added(Versions.v2023_04_01_preview)
union ManagedOpsProvisioningState {
  string,
  ResourceProvisioningState,

  @doc("The resource has begun provisioning.")
  Provisioning: "Provisioning",

  @doc("The resource is being deleted.")
  Deleting: "Deleting",
}
