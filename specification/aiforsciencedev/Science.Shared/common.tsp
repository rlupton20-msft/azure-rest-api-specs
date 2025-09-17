import "@typespec/http";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";

using Azure.Core;
using Azure.Core.Traits;

alias ServiceTraits = SupportsRepeatableRequests &
  SupportsConditionalRequests &
  SupportsClientRequestId;

alias Operations = Azure.Core.ResourceOperations<ServiceTraits>;

@doc("For adding ID.")
model WithId {
  @doc("The ID")
  @visibility("read")
  // Defaults to name."
  id: string;
}

@doc("Definition of Tag")
model Tag {
  @doc("Property key")
  key?: string;

  @doc("Property value")
  value?: string;
}

@doc("For adding tags.")
model WithTags {
  @doc("The tags")
  @visibility("read", "create", "update")
  tags?: Tag[];
}

@doc("For adding title to display instead of name.")
model WithTitle {
  @doc("The title")
  @visibility("read", "create", "update")
  // Defaults to name."
  displayName: string;
}

@doc("For adding status.")
model WithStatus<T> {
  @doc("The status")
  @visibility("read")
  status?: T;
}

@doc("For adding status reason")
model WithStatusReason {
  @doc("The reason for the current status")
  @visibility("read")
  statusReason?: string;
}

@doc("For adding description.")
model WithDescription {
  @doc("The description")
  @visibility("read", "create", "update")
  description: string;
}

@doc("Enum for entity")
union ByType {
  /** A human user. */
  User: "User",

  //  /** Application */
  //  Application: "Application",
  //
  //  /** ManagedIdentity */
  //  ManagedIdentity: "ManagedIdentity",
  //
  //  /** Key */
  //  Key: "Key",

  /** The backend system. */
  System: "System",

  string,
}

@doc("For adding creation timestamp.")
model WithCreatedAt {
  @doc("The timestamp when the resource was created")
  @visibility("read")
  createdAt: utcDateTime;
}

@doc("For tracking who created a resource.")
model WithCreatedBy {
  @doc("The ID of the user who created this resource.")
  @visibility("read")
  createdBy: string;
}

@doc("For tracking type of who created a resource.")
model WithCreatedByType {
  @doc("The type of user who created this resource.")
  @visibility("read")
  createdByType: ByType;
}

@doc("For adding last update timestamp.")
model WithUpdatedAt {
  @doc("The timestamp when the resource was last updated")
  @visibility("read")
  lastModifiedAt: utcDateTime;
}

@doc("For tracking who Updated a resource.")
model WithUpdatedBy {
  @doc("The ID of the user who Updated this resource.")
  lastModifiedBy: string;
}

@doc("For tracking type of who Updated a resource.")
model WithUpdatedByType {
  @doc("The type of user who Updated this resource.")
  @visibility("read")
  lastModifiedByType: ByType;
}

@doc("For searching items created after specified timestamp.")
model WithQueryCreatedSince {
  @doc("The oldest creation timestamp to keep")
  @TypeSpec.Http.query
  createdSince?: utcDateTime;
}

@doc("Enumeration for vertical.")
union Vertical {
  /** Chemistry vertical. */
  Chemistry: "Chemistry",

  /** Biology vertical. */
  Biology: "Biology",

  /** Physics vertical. */
  Physics: "Physics",

  /** Silicon vertical. */
  Silicon: "Silicon",

  string,
}

@doc("Settings for configuring associated Science Catalog artifact verticals.")
model WithVertical {
  @doc("Property for configuring associated verticals.")
  @visibility("read", "create", "update")
  vertical: Vertical;
}
