import "@typespec/http";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-client-generator-core";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.Core;
using Azure.Core.Traits;
using Azure.ClientGenerator.Core;

@versioned(Microsoft.Science.Shared.Versions)
namespace Microsoft.Science.Shared;

@doc("The Microsoft.Science.Shared versions.")
enum Versions {
  @useDependency(Azure.Core.Versions.v1_0_Preview_2)
  @doc("The 2024-11-01-preview version of the Microsoft.Science.Shared.")
  `2024-11-01-preview`,

  @useDependency(Azure.Core.Versions.v1_0_Preview_2)
  @doc("The 2025-07-01-preview version of the Microsoft.Science.Shared.")
  `2025-07-01-preview`,
}

alias ServiceTraits = SupportsRepeatableRequests &
  SupportsConditionalRequests &
  SupportsClientRequestId;

alias Operations = Azure.Core.ResourceOperations<ServiceTraits>;

@access(Access.internal)
@doc("For adding ID.")
model WithId {
  @doc("The ID")
  @visibility(Lifecycle.Read)
  id?: string;
}

@access(Access.internal)
@doc("Definition of Tag")
model Tag {
  @doc("Property key")
  key?: string;

  @doc("Property value")
  value?: string;
}

@access(Access.internal)
@doc("For adding tags.")
model WithTags {
  @doc("The tags")
  @visibility(Lifecycle.Read, Lifecycle.Create, Lifecycle.Update)
  tags?: Tag[];
}

@access(Access.internal)
@doc("For adding status.")
model WithStatus<T> {
  @doc("The status")
  @visibility(Lifecycle.Read)
  status?: T;
}

@access(Access.internal)
@doc("For adding status reason")
model WithStatusReason {
  @doc("The reason for the current status")
  @visibility(Lifecycle.Read)
  statusReason?: string;
}

alias ByType = string;
// TODO: Figure out why readonly properties using union below appear able to be set in PUT
// @access(Access.internal)
// @doc("Enum for entity")
// union ByType {
//   /** A human user. */
//   User: "User",
//
//   //  /** Application */
//   //  Application: "Application",
//   //
//   //  /** ManagedIdentity */
//   //  ManagedIdentity: "ManagedIdentity",
//   //
//   //  /** Key */
//   //  Key: "Key",
//
//   /** The backend system. */
//   System: "System",
//
//   string,
// }

@access(Access.internal)
@doc("For adding creation timestamp.")
model WithCreatedAt {
  @doc("The timestamp when the resource was created")
  @visibility(Lifecycle.Read)
  createdAt?: utcDateTime;
}

// @access(Access.internal)
@doc("For tracking who created a resource.")
model WithCreatedBy {
  @doc("The ID of the user who created this resource.")
  @visibility(Lifecycle.Read)
  createdBy?: string;
}

// @access(Access.internal)
@doc("For tracking type of who created a resource.")
model WithCreatedByType {
  @doc("The type of user who created this resource.")
  @visibility(Lifecycle.Read)
  createdByType?: ByType;
}

@access(Access.internal)
@doc("For tracking resource creation data.")
model WithCreated {
  ...WithCreatedAt;
  ...WithCreatedBy;
  ...WithCreatedByType;
}

@access(Access.internal)
@doc("For adding last update timestamp.")
model WithLastModifiedAt {
  @doc("The timestamp when the resource was last updated")
  @visibility(Lifecycle.Read)
  lastModifiedAt?: utcDateTime;
}

@access(Access.internal)
@doc("For tracking who Updated a resource.")
model WithLastModifiedBy {
  @doc("The ID of the user who Updated this resource.")
  @visibility(Lifecycle.Read)
  lastModifiedBy?: string;
}

@access(Access.internal)
@doc("For tracking type of who Updated a resource.")
model WithLastModifiedByType {
  @doc("The type of user who Updated this resource.")
  @visibility(Lifecycle.Read)
  lastModifiedByType?: ByType;
}

@access(Access.internal)
@doc("For tracking resource modification data.")
model WithLastModified {
  ...WithLastModifiedAt;
  ...WithLastModifiedBy;
  ...WithLastModifiedByType;
}

@access(Access.internal)
@doc("For searching items created after specified timestamp.")
model WithQueryCreatedSince {
  @doc("The oldest creation timestamp to keep")
  @TypeSpec.Http.query
  createdSince?: utcDateTime;
}

@access(Access.internal)
@doc("For searching items created after specified timestamp.")
model DataPlaneResource {
  ...WithId;
  ...WithCreated;
  ...WithLastModified;
}

/** Paged list resources */
// API reviewer said we need "is" or inheritance to avoid losing annotations
model Paged<T extends {name: string}> is Foundations.CustomPage<T>;
