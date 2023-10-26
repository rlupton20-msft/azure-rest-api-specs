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
  version: "2023-09-01-preview",
})
@doc("Microsoft.Relationships Resource Provider management API.")
@useDependency(Azure.ResourceManager.Versions.v1_0_Preview_1)
namespace Microsoft.Relationships;

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

@doc("Base relationship properties.")
model BaseRelationshipProperties<TOrigin> {
  @doc("The source of the current relationship.")
  @visibility("read")
  sourceId: string;

  @doc("The target of the current relationship.")
  targetId: string;

  @doc("Information about the origin of the relationship.")
  @visibility("read")
  originInformation: RelationshipOriginInformation<TOrigin>;
}

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-operation-outside-interface" // We will use this in an interface
@doc("List {name} resources associated with the parent.")
@autoRoute
@armResourceAction(TResource)
@post
op ArmResourceListActionSync<
  TResource extends ArmResource,
  TRelationshipName extends valueof string,
  TBaseParameters = BaseParameters<TResource>
>(
  ...TBaseParameters,
  ...ProviderNamespace<TResource>,

  @doc("The name of the relationship to list resources for.")
  @path
  type: TRelationshipName,

  @doc("Default relationship resource name.")
  @path
  default: "default",
): ArmResponse<ResourceListResult<TResource>> | ErrorResponse;

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

// Relationships.RP is an unmanaged RP, so I think we can ignore provisioning state
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state"
@doc("componentOf relationship properties.")
model ComponentOfRelationshipProperties
  extends BaseRelationshipProperties<ComponentOfOrigins> {}

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

// Relationships.RP is an unmanaged RP, so I think we can ignore provisioning state
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state"
@doc("dependencyOf relationship properties.")
model DependencyOfRelationshipProperties
  extends BaseRelationshipProperties<DependencyOfOrigins> {}

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
 * Microsoft.Relationships RP interface definitions
 */

interface Operations extends Azure.ResourceManager.Operations {}

interface Relationships<
  TRelationship extends ArmResource,
  TProperties extends {},
  TName extends valueof string
> extends ExtensionResourceOperations<TRelationship, TProperties> {
  incoming is ArmResourceListActionSync<TRelationship, TName>;
  outgoing is ArmResourceListActionSync<TRelationship, TName>;
}

@armResourceOperations(ComponentOfRelationship)
interface ComponentOfRelationships
  extends Relationships<
      ComponentOfRelationship,
      ComponentOfRelationshipProperties,
      "componentOf"
    > {}

@armResourceOperations(DependencyOfRelationship)
interface DependencyOfRelationships
  extends Relationships<
      DependencyOfRelationship,
      DependencyOfRelationshipProperties,
      "dependencyOf"
    > {}
