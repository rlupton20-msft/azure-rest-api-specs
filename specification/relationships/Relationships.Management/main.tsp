import "@typespec/http";
import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-providerhub";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.Core;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;

@armProviderNamespace
@service({
  title: "Microsoft.Relationships Management Service",
})
@doc("Microsoft.Relationships Resource Provider management API.")
@versioned(Versions)
namespace Microsoft.Relationships;

/** Rel RP API Versions */
enum Versions {
  /** 2023-09-01-preview version */
  @useDependency(Azure.ResourceManager.Versions.v1_0_Preview_1)
  @armCommonTypesVersion(Azure.ResourceManager.CommonTypes.Versions.v5)
  `2023-09-01-preview`,
}

/*
 * Base relationship types definitions
 */

alias ServiceExplicitlyCreated = "ServiceExplicitlyCreated";

alias UserExplicitlyCreated = "UserExplicitlyCreated";

@doc("Provides information about the origin of a relationship.")
model RelationshipOriginInformation<TOrigin = string> {
  @doc("Identifies the origin type of the relationship.")
  @visibility("read")
  relationshipOriginType: TOrigin;
}

@doc("Provides information about the relationship properties.")
model RelationshipMetadata {

  @doc("The type of the relationship source resource.")
  @visibility("read")
  sourceType: string;

  @doc("The type of the relationship target resource.")
  @visibility("read")
  targetType: string;
}

/** The provisioning state of a resource. */
@lroStatus
enum ProvisioningState {
  ...ResourceProvisioningState,

  /** The relationship is being provisioned */
  Provisioning,
}

@doc("Base relationship properties.")
model BaseRelationshipProperties<TOrigin> {
  @doc("The source of the current relationship.")
  @visibility("read")
  sourceId: string;

  @doc("The target of the current relationship.")
  targetId: string;

  @doc("Metadata about the relationship.")
  @visibility("read")
  relationshipMetadata: RelationshipMetadata;

  @doc("Information about the origin of the relationship.")
  @visibility("read")
  originInformation: RelationshipOriginInformation<TOrigin>;

  /** The status of the last operation. */
  @visibility("read")
  provisioningState?: ProvisioningState;
}

/*
 * componentOf relationship type definitions
 */

@doc("The possible origins of a componentOf relationship.")
union ComponentOfOrigins {
  @doc("The relationship was explicitly created by a system.")
  serviceExplicitlyCreated: ServiceExplicitlyCreated,
  @doc("The relationship was explicitly created by a user.")
  userExplicitlyCreated: UserExplicitlyCreated,
}

@doc("componentOf relationship properties.")
model ComponentOfRelationshipProperties
  is BaseRelationshipProperties<ComponentOfOrigins> {}

@doc("Defines a componentOf relationship resource.")
model ComponentOfRelationship
  is ExtensionResource<ComponentOfRelationshipProperties> {
  @doc("Name of componentOf relationship.")
  @pattern("^[a-zA-Z0-9]{3,24}$")
  @visibility("read")
  @key
  @path
  @segment("componentOf")
  name: string;
}

/*
 * dependencyOf relationship type definition
 */

@doc("The possible origins of a dependencyOf relationship.")
union DependencyOfOrigins {
  @doc("The relationship was explicitly created by a system.")
  serviceExplicitlyCreated: ServiceExplicitlyCreated,
  @doc("The relationship was explicitly created by a user.")
  userExplicitlyCreated: UserExplicitlyCreated,
}

@doc("dependencyOf relationship properties.")
model DependencyOfRelationshipProperties
  is BaseRelationshipProperties<DependencyOfOrigins> {}

@doc("Defines a dependencyOf relationship resource.")
model DependencyOfRelationship
  is ExtensionResource<DependencyOfRelationshipProperties> {
  @doc("Name of dependencyOf relationship.")
  @pattern("^[a-zA-Z0-9]{3,24}$")
  @visibility("read")
  @key
  @path
  @segment("dependencyOf")
  name: string;
}

/*
 * serviceGroupMemberOf relationship type definition
 */

@doc("The possible origins of a serviceGroupMemberOf relationship.")
union serviceGroupMemberOfOrigins {
  @doc("The relationship was explicitly created by a system.")
  serviceExplicitlyCreated: ServiceExplicitlyCreated,
  @doc("The relationship was explicitly created by a user.")
  userExplicitlyCreated: UserExplicitlyCreated,
}

@doc("serviceGroupMemberOf relationship properties.")
model ServiceGroupMemberOfRelationshipProperties
  is BaseRelationshipProperties<serviceGroupMemberOfOrigins> {}

@doc("Defines a serviceGroupMemberOf relationship resource.")
model ServiceGroupMemberOfRelationship 
    is ExtensionResource<ServiceGroupMemberOfRelationshipProperties> {
  @doc("Name of serviceGroupMemberOf relationship.")
  @visibility("read")
  @key
  @path
  @segment("serviceGroupMemberOf")
  name: "default";
}

/*
 * Microsoft.Relationships RP interface definitions
 */

interface Operations extends Azure.ResourceManager.Operations {}

interface Relationships<TRelationship extends ArmResource> {
  createOrUpdate is ArmResourceCreateOrReplaceAsync<TRelationship>;
  get is ArmResourceRead<TRelationship>;  
  delete is ArmResourceDeleteSync<TRelationship>;
}

@armResourceOperations
interface ComponentOfRelationships
  extends Relationships<ComponentOfRelationship> 
{}

@armResourceOperations
interface DependencyOfRelationships
  extends Relationships<DependencyOfRelationship> 
{}

@armResourceOperations
interface ServiceGroupMemberOfRelationships
  extends Relationships<ServiceGroupMemberOfRelationship> 
{}
