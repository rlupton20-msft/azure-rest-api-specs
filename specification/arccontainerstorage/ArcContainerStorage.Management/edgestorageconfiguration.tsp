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

@doc("EdgeStorageConfiguration is a custom resource that defines the configuration for edge storage settings.")
model EdgeStorageConfiguration
  is ExtensionResource<EdgeStorageConfigurationProperties> {
  @doc("The name of the EdgeStorageConfiguration resource, which must be 'edge-storage-configuration'.")
  @key("edgeStorageConfigurationName")
  @path
  @segment("edgestorageconfigurations")
  // Enforce the singleton name 'edge-storage-configuration'
  @pattern("^edge-storage-configuration$")
  name: string;
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
  @visibility("read")
  defaultDiskStorageClasses: StorageClass[];

  @doc("Automatically failover edge volume consumers.")
  failoverEdgeVolumeConsumers: boolean = true;

  @doc("DEPRECATED field for backward compatibility. Which service mesh to use.")
  serviceMesh: ServiceMesh = ServiceMesh.osm; // Default is "osm"

  @doc("Object containing optional workload identity information.")
  workloadIdentity: WorkloadIdentity;

  @doc("The provisioning state of the resource.")
  @visibility("read")
  provisioningState?: provisioningState;

  @doc("Read only object to reflect changes that have occurred on the Edge. Similar to Kubernetes status property for custom resources.")
  @visibility("read")
  status: EdgeStorageConfigurationStatus;
}

//
// Service Mesh Enum -- tried writing as a enum https://azure.github.io/typespec-azure/docs/libraries/azure-core/rules/no-enum/
// because of that guideline used union
//
@doc("Possible service meshes to use. Field is deprecated; kept for backward compatibility.")
union ServiceMesh {
  @doc("Open Service Mesh")
  osm: "osm",

  @doc("Use cert-manager for traffic encryption")
  `cert-manager`: "cert-manager",

  @doc("No service mesh used")
  none: "none",

  string,
}

//
// Workload Identity
//
@doc("Defines the workload identity properties.")
model WorkloadIdentity {
  @doc("The client ID for the workload identity.")
  @pattern("^[0-9a-fA-F-]{36}$") // basic check for UUID
  clientId: string;

  @doc("The tenant ID for the workload identity.")
  @pattern("^[0-9a-fA-F-]{36}$") // basic check for UUID
  tenantId: string;
}

//
// Status
//
@doc("Defines the observed status of the EdgeStorageConfiguration resource.")
model EdgeStorageConfigurationStatus {
  @doc("The current state of the configuration.")
  state: string;

  @doc("Additional details about the configuration's status.")
  details: string;
}

//
// Operations
//
@armResourceOperations
interface EdgeStorageConfigurations {
  get is ArmResourceRead<EdgeStorageConfiguration>;
  createOrReplace is ArmResourceCreateOrReplaceAsync<EdgeStorageConfiguration>;
  delete is ArmResourceDeleteWithoutOkAsync<EdgeStorageConfiguration>;
  listByResourceGroup is ArmResourceListByParent<EdgeStorageConfiguration>;
}
