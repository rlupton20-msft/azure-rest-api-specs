import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.Core;
using Azure.ResourceManager;

@armProviderNamespace
@service({
  title: "Microsoft.Relationships Management Service",
})
@doc("Microsoft.Relationships Resource Provider management API.")
@versioned(Versions)
namespace Microsoft.Relationships;

/** Relationships RP API Versions */
enum Versions {
  /** 2023-09-01-preview version */
  @useDependency(Azure.ResourceManager.Versions.v1_0_Preview_1)
  @armCommonTypesVersion(Azure.ResourceManager.CommonTypes.Versions.v5)
  `2023-09-01-preview`,
}

/*
 * Base relationship types definitions
 */

@doc("Provides information about the origin of a relationship.")
model RelationshipOriginInformation<TOrigin = string> {
  @doc("Identifies the origin type of the relationship.")
  relationshipOriginType: TOrigin;

  @doc("The name of the discovery engine that created the relationship.")
  discoveryEngine?: string
}

@doc("The provisioning state of the resource.")
@lroStatus
union ProvisioningState {
  ResourceProvisioningState,

  /** The resource is being provisioned. */
  Provisioning: "Provisioning",

  /** The resource is being updated. */
  Updating: "Updating",

  /** The resource is being deleted. */
  Deleting: "Deleting",

  /** The resource provisioning request has been accepted. */
  Accepted: "Accepted",

  string,
}

@doc("Base relationship properties.")
model BaseRelationshipProperties<TOrigin> {
  @doc("The relationship source resource id.")
  @visibility("read")
  sourceId: string;

  @doc("The relationship target resource id.")
  targetId: string;

  @doc("The relationship target tenant id.")
  targetTenant?: string;

  @doc("Information about the origin of the relationship.")
  originInformation: RelationshipOriginInformation<TOrigin>;

  @doc("The provisioning state of the relationship.")
  @visibility("read")
  provisioningState?: ProvisioningState;
}

/*
 * dependencyOf relationship type definition
 */

@doc("The possible origins of a dependencyOf relationship.")
union DependencyOfOrigins {
  @doc("The relationship was explicitly created by a system.")
  ServiceExplicitlyCreated: "ServiceExplicitlyCreated",

  @doc("The relationship was discovered by a system-created rule.")
  SystemDiscoveredByRule: "SystemDiscoveredByRule",

  @doc("The relationship was explicitly created by a user.")
  UserExplicitlyCreated: "UserExplicitlyCreated",

  @doc("The relationship was discovered by a user-created rule.")
  UserDiscoveredByRule: "UserDiscoveredByRule",

  string,
}

@doc("dependencyOf relationship properties.")
model DependencyOfRelationshipProperties
  is BaseRelationshipProperties<DependencyOfOrigins>;

@doc("Defines a dependencyOf relationship resource.")
model DependencyOfRelationship
  is ExtensionResource<DependencyOfRelationshipProperties> {
  @doc("Name of dependencyOf relationship.")
  @pattern("^[a-zA-Z0-9]{3,64}$")
  @visibility("read")
  @key
  @path
  @segment("dependencyOf")
  name: string;
}

/*
 * serviceGroupMember relationship type definition
 */

@doc("The possible origins of a ServiceGroupMember relationship.")
union ServiceGroupMemberOrigins {
  @doc("The relationship was explicitly created by a system.")
  ServiceExplicitlyCreated: "ServiceExplicitlyCreated",

  @doc("The relationship was discovered by a system-created rule.")
  SystemDiscoveredByRule: "SystemDiscoveredByRule",

  @doc("The relationship was explicitly created by a user.")
  UserExplicitlyCreated: "UserExplicitlyCreated",

  @doc("The relationship was discovered by a user-created rule.")
  UserDiscoveredByRule: "UserDiscoveredByRule",

  string,
}

@doc("ServiceGroupMember relationship properties.")
model ServiceGroupMemberRelationshipProperties
  is BaseRelationshipProperties<ServiceGroupMemberOrigins>;

@doc("Defines a ServiceGroupMember relationship resource.")
model ServiceGroupMemberRelationship
  is ExtensionResource<ServiceGroupMemberRelationshipProperties> {
  @doc("Name of ServiceGroupMember relationship.")
  @pattern("^[a-zA-Z0-9]{3,64}$")
  @visibility("read")
  @key
  @path
  @segment("serviceGroupMember")
  name: string;
}

/*
 * Microsoft.Relationships RP interface definitions
 */

interface Operations extends Azure.ResourceManager.Operations {}

@armResourceOperations
interface DependencyOfRelationships {
  createOrUpdate is ArmResourceCreateOrReplaceAsync<DependencyOfRelationship>;
  get is ArmResourceRead<DependencyOfRelationship>;
  delete is ArmResourceDeleteWithoutOkAsync<DependencyOfRelationship>;
}

@armResourceOperations
interface ServiceGroupMemberRelationships {
  createOrUpdate is ArmResourceCreateOrReplaceAsync<ServiceGroupMemberRelationship>;
  get is ArmResourceRead<ServiceGroupMemberRelationship>;
  delete is ArmResourceDeleteWithoutOkAsync<ServiceGroupMemberRelationship>;
}
