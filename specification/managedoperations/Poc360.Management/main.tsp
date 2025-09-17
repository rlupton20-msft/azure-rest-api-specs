import "@typespec/http";
import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "./managedOps.tsp";

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

enum Versions {
  @useDependency(Azure.ResourceManager.Versions.v1_0_Preview_1)
  @useDependency(Azure.Core.Versions.v1_0_Preview_2)
  @armCommonTypesVersion(Azure.ResourceManager.CommonTypes.Versions.v5)
  @doc("2023-04-01-preview")
  v2023_04_01_preview: "2023-04-01-preview",

  @useDependency(Azure.ResourceManager.Versions.v1_0_Preview_1)
  @useDependency(Azure.Core.Versions.v1_0_Preview_2)
  @armCommonTypesVersion(Azure.ResourceManager.CommonTypes.Versions.v5)
  @doc("2024-08-01-preview")
  v2024_08_01_preview: "2024-08-01-preview",

  @useDependency(Azure.ResourceManager.Versions.v1_0_Preview_1)
  @useDependency(Azure.Core.Versions.v1_0_Preview_2)
  @armCommonTypesVersion(Azure.ResourceManager.CommonTypes.Versions.v6)
  @doc("2025-05-19-preview")
  v2025_05_19_preview: "2025-05-19-preview",

  @useDependency(Azure.ResourceManager.Versions.v1_0_Preview_1)
  @useDependency(Azure.Core.Versions.v1_0_Preview_2)
  @armCommonTypesVersion(Azure.ResourceManager.CommonTypes.Versions.v6)
  @doc("2025-07-28-preview")
  v2025_07_28_preview: "2025-07-28-preview",
}

interface Operations extends Azure.ResourceManager.Operations {}

@doc("The managed operations resource.")
model ExtManagedOperation is ExtensionResource<ExtManagedOperationsProperties> {
  /** We fix the name of the resource to ensure it is a singleton */
  @doc("Name of the resource.")
  @key("extManagedOperationsName")
  @pattern("default")
  @segment("extManagedOperations")
  @path
  name: string;
}

@doc("Properties of the Managed Ops resource.")
model ExtManagedOperationsProperties {
  @doc("SKU details for this resource.")
  sku?: Sku;

  @doc("Provisioning state of the resource.")
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningState;

  @doc("Initial configuration used when provisioning the resource.")
  initialConfiguration: InitialConfiguration;

  @doc("Services provisioned by this resource.")
  @visibility(Lifecycle.Read)
  services?: ServiceInformation;
}

@doc("Specifies the service plan for this resource.")
model Sku {
  @doc("Name of the SKU.")
  name: string;

  @doc("Pricing tier of the SKU.")
  tier: string;
}

@doc("Initial configuration parameters.")
model InitialConfiguration {
  @doc("Configuration for the Change Tracking and Inventory service.")
  changeTrackingAndInventory: ChangeTrackingConfiguration;
}

@doc("Configuration for the Change Tracking and Inventory service.")
model ChangeTrackingConfiguration {
  @doc("Log analytics workspace resource ID used by the services.")
  logAnalyticsWorkspaceId: string;
}

@doc("Services provisioned by this resource.")
model ServiceInformation {
  @doc("Change Tracking and Inventory service's information.")
  @visibility(Lifecycle.Read)
  changeTrackingAndInventory: ChangeTrackingInformation;

  @doc("Azure Monitor Insights service's information.")
  @visibility(Lifecycle.Read)
  azureMonitorInsights: AzureMonitorInformation;

  @doc("Azure Update Manager service's information.")
  @visibility(Lifecycle.Read)
  azureUpdateManager: UpdateManagerInformation;

  @doc("Azure Policy and Machine Configuration service's information.")
  @visibility(Lifecycle.Read)
  azurePolicyAndMachineConfiguration: GuestConfigurationInformation;
}

@doc("Change Tracking and Inventory service's information.")
model ChangeTrackingInformation {
  @doc("Resource ID of the Change Tracking extension.")
  @visibility(Lifecycle.Read)
  resourceId?: string;

  @doc("Provisioning state of the Change Tracking service.")
  @visibility(Lifecycle.Read)
  provisioningState: ProvisioningState;

  @doc("If the provisioning state is 'Failed', contains the error leading to failure.")
  @visibility(Lifecycle.Read)
  error?: ProvisioningError;
}

@doc("Azure Monitor Insights service's information.")
model AzureMonitorInformation {
  @doc("Resource ID of the Azure Monitor extension.")
  @visibility(Lifecycle.Read)
  resourceId?: string;

  @doc("Provisioning state of the Azure Monitor service.")
  @visibility(Lifecycle.Read)
  provisioningState: ProvisioningState;

  @doc("If the provisioning state is 'Failed', contains the error leading to failure.")
  @visibility(Lifecycle.Read)
  error?: ProvisioningError;
}

@doc("Azure Update Manager service's information.")
model UpdateManagerInformation {
  @doc("Resource ID of the Update Manager extension.")
  @visibility(Lifecycle.Read)
  resourceId?: string;

  @doc("Provisioning state of the Update Manager service.")
  @visibility(Lifecycle.Read)
  provisioningState: ProvisioningState;

  @doc("If the provisioning state is 'Failed', contains the error leading to failure.")
  @visibility(Lifecycle.Read)
  error?: ProvisioningError;
}

@doc("Azure Policy and Machine Configuration service's information.")
model GuestConfigurationInformation {
  @doc("Resource ID of the Guest Configuration extension. Null for Arc machines as the extension is built into the machine.")
  @visibility(Lifecycle.Read)
  resourceId?: string;

  @doc("Provisioning state of the Guest Configuration service.")
  @visibility(Lifecycle.Read)
  provisioningState: ProvisioningState;

  @doc("If the provisioning state is 'Failed', contains the error leading to failure.")
  @visibility(Lifecycle.Read)
  error?: ProvisioningError;
}

@doc("Contains the information regarding the error that lead to provisioning failure.")
@error
model ProvisioningError {
  @doc("Code corresponding to the type of provisioning failure.")
  @visibility(Lifecycle.Read)
  code: string;

  @doc("Detailed message explaining the cause of the provisioning failure.")
  @visibility(Lifecycle.Read)
  message: string;
}

@doc("The provisioning state of a resource.")
@lroStatus
union ProvisioningState {
  string,
  ResourceProvisioningState,

  @doc("The resource has begun provisioning.")
  Provisioning: "Provisioning",

  @doc("The resource is being deleted.")
  Deleting: "Deleting",
}

/** The operations that can be performed on our resource */
@armResourceOperations(ExtManagedOperation)
interface ExtManagedOperations {
  get is ArmResourceRead<ExtManagedOperation>;
  create is ArmResourceCreateOrUpdateAsync<ExtManagedOperation>;
  delete is ArmResourceDeleteWithoutOkAsync<ExtManagedOperation>;
}
