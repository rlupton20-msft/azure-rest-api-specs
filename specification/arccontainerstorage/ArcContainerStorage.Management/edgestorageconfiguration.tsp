import "@typespec/http";
import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "./provisioningState.tsp";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.ResourceManager;
using OpenAPI;

namespace Private.ArcContainerStorage;

//    generation: "2"

@doc("EdgeStorageConfiguration is a custom resource that defines the configuration for edge storage settings.")
model EdgeStorageConfiguration
  is ExtensionResource<
    EdgeStorageConfigurationProperties,
    PropertiesOptional = false
  > {
  ...ResourceNameParameter<
    EdgeStorageConfiguration,
    NamePattern = "^edge-storage-configuration$"
  >;
}

@minLength(1)
@maxLength(253)
scalar StorageClass extends string;

//
// Properties
//
@doc("Defines the properties of the EdgeStorageConfiguration resource.")
model EdgeStorageConfigurationProperties {
  @doc("The default disk storage class(es) to be used for edge volumes. Must not be empty and is immutable once set.")
  @minItems(1)
  @visibility(Lifecycle.Create, Lifecycle.Read)
  defaultDiskStorageClasses: StorageClass[];

  @doc("Automatically failover edge volume consumers.")
  failoverEdgeVolumeConsumers?: boolean = true;

  @doc("This indicates how to ensure mTLS")
  serviceMesh?: ServiceMesh = ServiceMesh.`cert-manager`; // Deprecated field, but have it here for backward compatibility

  @doc("Object containing optional workload identity information.")
  workloadIdentity?: WorkloadIdentity;

  @doc("The provisioning state of the resource.")
  @visibility(Lifecycle.Read)
  provisioningState?: provisioningState;

  @doc("Read only object to reflect changes that have occurred on the Edge. Similar to Kubernetes status property for custom resources.")
  @visibility(Lifecycle.Read)
  status?: EdgeStorageConfigurationStatus;
}

@doc("This indicates how to ensure mTLS (deprecated)")
union ServiceMesh {
  @doc("Open service mesh (deprecated)")
  osm: "osm",

  @doc("cert-manager")
  `cert-manager`: "cert-manager",

  string,
}

//
// Workload Identity
//
@doc("Defines the workload identity properties.")
model WorkloadIdentity {
  @doc("The client ID for the workload identity.")
  clientId: Azure.Core.uuid;

  @doc("The tenant ID for the workload identity.")
  tenantId: Azure.Core.uuid;
}

//
// Status
//
@doc("Defines the observed status of the EdgeStorageConfiguration resource.")
model EdgeStorageConfigurationStatus {
  @doc("The current state of the configuration.")
  state?: string;

  @doc("Additional details about the configuration's status.")
  details?: string;
}

//
// Operations
//
@armResourceOperations
interface EdgeStorageConfigurations {
  get is ArmResourceRead<EdgeStorageConfiguration>;
  createOrReplace is ArmResourceCreateOrReplaceSync<EdgeStorageConfiguration>;
  delete is ArmResourceDeleteWithoutOkAsync<EdgeStorageConfiguration>;
  list is ArmResourceListByParent<EdgeStorageConfiguration>;
}
