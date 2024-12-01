import "@typespec/http";

using TypeSpec.Rest;
using TypeSpec.Http;
using TypeSpec.Versioning;
using Azure.Core;
using Azure.ResourceManager;

namespace Private.Workloads;

/**
 * Defines the possible values for system lifecycle stage.
 */
union SystemLifecycleStage {
  string,

  /**
   * The stage indicating that the workload system is fully built, and is up & running.
   */
  Active: "Active",

  /**
   * The stage indicating that the workload system is fully built but either not running or being decommissioned.
   */
  InActive: "InActive",

  /**
   * The stage indicating that the workload system is being built.
   */
  InBuild: "InBuild",
}

/**
 * Defines the environment type.
 */
union EnvironmentType {
  string,

  /**
   * Non Production system.
   */
  NonProduction: "NonProduction",

  /**
   * Production system.
   */
  Production: "Production",
}

/**
 * Defines the resource group type.
 */
union ResourceGroupType {
  string,

  /**
   * The managed resource group which the service will create and use to deploy any supporting resources. Service is responsible for managing its lifecycle.
   */
  ManagedResourceGroup: "ManagedResourceGroup",

  /**
   * User provided resource group which will be created beforehand by the user. Service will only use this RG to deploy any supporting resources and won't manage the lifecycle of this.
   */
  UserResourceGroup: "UserResourceGroup",
}

/**
 * Defines the resource group configuration.
 */
@discriminator("type")
model ResourceGroupConfiguration {
  /**
   * Type of the resource group - User RG / Managed RG.
   */
  type: ResourceGroupType;
}

/**
 * Defines the managed resource group configuration.
 */
model ManagedResourceGroupConfiguration extends ResourceGroupConfiguration {
  /**
   * The resource group type.
   */
  type: ResourceGroupType.ManagedResourceGroup;

  /**
   * Name of the managed resource group.
   */
  managedResourceGroupName?: string;
}

/**
 * Defines the user provided resource group configuration.
 */
model UserResourceGroupConfiguration extends ResourceGroupConfiguration {
  /**
   * The resource group type.
   */
  type: ResourceGroupType.UserResourceGroup;

  /**
   * Name of the user provided resource group.
   */
  resourceGroupName: string;
}

/**
 * Defines the Virtual Instance state.
 */
union VirtualInstanceState {
  string,

  /**
   * Registration is in progress.
   */
  RegistrationInProgress: "RegistrationInProgress",

  /**
   * Registration has failed.
   */
  RegistrationFailed: "RegistrationFailed",

  /**
   * Registration is complete.
   */
  RegistrationComplete: "RegistrationComplete",
}

/**
 * Defines the resource provisioning states.
 */
union ResourceProvisioningState {
  string,

  /**
   * The succeeded provisioning state.
   */
  Succeeded: "Succeeded",

  /**
   * The updating provisioning state.
   */
  Updating: "Updating",

  /**
   * The Creating provisioning state.
   */
  Creating: "Creating",

  /**
   * The Failed provisioning state.
   */
  Failed: "Failed",

  /**
   * The Deleting provisioning state.
   */
  Deleting: "Deleting",

  /**
   * The Canceled provisioning state.
   */
  Canceled: "Canceled",
}

/**
 * An error response from the Workload Center service.
 */
model VirtualInstanceError {
  /**
   * The Virtual Instance error body.
   */
  properties?: ErrorDefinition;
}

/**
 * Error definition.
 */
model ErrorDefinition {
  /**
   * Service specific error code which serves as the substatus for the HTTP error code.
   */
  @visibility("read")
  code?: string;

  /**
   * Description of the error.
   */
  @visibility("read")
  message?: string;

  /**
   * Internal error details.
   */
  @visibility("read")
  @OpenAPI.extension("x-ms-identifiers", [])
  details?: ErrorDefinition[];
}

scalar WorkloadResourceId
  extends Azure.Core.armResourceIdentifier<[
    {
      type: "Private.Workloads/virtualInstances",
    }
  ]>;

/**
 * Defines the Virtual Instance resource properties.
 */
model VirtualInstanceProperties {
  /**
   * The ID corresponding to the deployment architecture of the system.
   */
  architectureId: string;

  /**
   * The type of environment in which the workload system is deployed - Production / Non Production.
   */
  environmentType: EnvironmentType;

  /**
   * The user defined label indicating the sub category of the environment in which the workload system is deployed.
   */
  environmentLabel?: string;

  /**
   * The priority of the workload system. The value must be an integer between 0 (highest priority) and 9 (lowest priority).
   */
  @minValue(0)
  @maxValue(9)
  systemPriority: int32;

  /**
   * The current stage in the lifecycle of the workload system.
   */
  systemLifecycleStage: SystemLifecycleStage;

  /**
   * Metadata pertaining to the workload system.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Keys of this field are dynamic and vary based on the type of the workload (kind of the virtual instance). We cannot use tags here as this field is supposed to be understood by the service and is not for customer usage. Values will always be strings."
  metadata?: Record<string>;

  /**
   * The list of ARM IDs of the virtual instances that the system is dependent on. The ARM IDs must belong to the resources of type 'Private.Workloads/virtualInstances'.
   */
  dependsOn?: WorkloadResourceId[];

  /**
   * The configuration object for resource group (Managed or User provided) where supporting resources will be deployed. If this field is passed as null, this will be defaulted to UserResourceGroupConfiguration and resource group name will be same as that of the RG in which the Virtual Instance resource will be created.
   */
  resourceGroupConfiguration?: ResourceGroupConfiguration;

  /**
   * Defines the state of the virtual instance.
   */
  @visibility("read")
  state?: VirtualInstanceState;

  /**
   * Defines the virtual instance provisioning state.
   */
  @visibility("read")
  provisioningState?: ResourceProvisioningState;

  /**
   * Indicates any errors on the Virtual Instance resource.
   */
  @visibility("read")
  errors?: VirtualInstanceError;
}

/**
 * Defines the request body for updating the Virtual Instance resource.
 */
model UpdateVirtualInstanceRequest {
  /**
   * Gets or sets the Resource tags.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Existing field"
  tags?: Record<string>;

  /**
   * Managed service identity (user assigned identities)
   */
  identity?: CommonTypes.ManagedServiceIdentity;

  /**
   * The properties to be updated.
   */
  properties?: UpdateVirtualInstanceProperties;
}

/**
 * Defines the update request body properties for updating the Virtual Instance resource.
 */
model UpdateVirtualInstanceProperties {
  /**
   * The user defined label indicating the sub category of the environment in which the workload system is deployed.
   */
  environmentLabel?: string;

  /**
   * The priority of the workload system. The value must be an integer between 0 (highest priority) and 9 (lowest priority).
   */
  systemPriority?: int32;

  /**
   * The current stage in the lifecycle of the workload system.
   */
  systemLifecycleStage?: SystemLifecycleStage;

  /**
   * Metadata pertaining to the workload system.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Keys of this field are dynamic and vary based on the type of the workload (kind of the virtual instance). We cannot use tags here as this field is supposed to be understood by the service and is not for customer usage. Values will always be strings."
  metadata?: Record<string>;
}

/**
 * Defines the workload component properties.
 */
model WorkloadComponentProperties {
  /**
   * Type of the component. Allowed values change based on the workload type and will be defined in the workload definition. Examples include "application", "database", "central" etc.
   */
  componentType: string;

  /**
   * Role of the component. There can be multiple roles for a same component type. Allowed values change based on the workload type and will be defined in the workload definition. Examples include "pas"/"aas" for application component, "ascs"/"ers" for central component, "backup", etc.
   */
  componentRole?: string;

  /**
   * Resources that are part of the component.
   */
  @OpenAPI.extension("x-ms-identifiers", [])
  resources: ResourceConfiguration[];

  /**
   * Metadata pertaining to the component.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Keys of this field are dynamic and vary based on the component, which itself would vary based on the type of the workload (kind of the virtual instance). We cannot use tags here as this field is supposed to be understood by the service and is not for customer usage. Values will always be strings."
  metadata?: Record<string>;

  /**
   * Defines the workload component provisioning state.
   */
  @visibility("read")
  provisioningState?: ResourceProvisioningState;

  /**
   * Indicates any errors on the workload component resource.
   */
  @visibility("read")
  errors?: VirtualInstanceError;
}

/**
 * Defines the resource configuration.
 */
model ResourceConfiguration {
  /**
   * ARM ID of the resource.
   */
  resourceId: armResourceIdentifier;
}

/**
 * Defines the request body for updating the workload component resource.
 */
model UpdateWorkloadComponentRequest {
  /**
   * Gets or sets the Resource tags.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Existing field"
  tags?: Record<string>;

  /**
   * Managed service identity (user assigned identities)
   */
  identity?: CommonTypes.ManagedServiceIdentity;

  /**
   * The properties to be updated.
   */
  properties?: UpdateWorkloadComponentProperties;
}

/**
 * Defines the update request body properties for updating the workload component resource.
 */
model UpdateWorkloadComponentProperties {
  /**
   * Resources that are part of the component.
   */
  @OpenAPI.extension("x-ms-identifiers", [])
  resources?: ResourceConfiguration[];

  /**
   * Metadata pertaining to the component.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Keys of this field are dynamic and vary based on the component, which itself would vary based on the type of the workload (kind of the virtual instance). We cannot use tags here as this field is supposed to be understood by the service and is not for customer usage. Values will always be strings."
  metadata?: Record<string>;
}
