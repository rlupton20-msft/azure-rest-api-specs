import "@typespec/http";
import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "./common/provisioningState.tsp";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.ResourceManager;
using OpenAPI;

namespace Private.DeviceRegistry;

@added(global.Private.DeviceRegistry.Versions.v2024_07_01_preview)
@doc("Schema registry definition.")
model SchemaRegistry is TrackedResource<SchemaRegistryProperties> {
  @doc("Schema registry name parameter.")
  @key("schemaRegistryName")
  @segment("schemaRegistries")
  @pattern("^[a-z0-9][a-z0-9-]*[a-z0-9]$")
  @path
  @minLength(3)
  @maxLength(63)
  name: string;
}

@added(global.Private.DeviceRegistry.Versions.v2024_07_01_preview)
@doc("Defines the schema registry properties.")
model SchemaRegistryProperties {
  @doc("Globally unique, immutable, non-reusable id.")
  @visibility("read")
  uuid?: string;

  @doc("Schema registry namespace. Uniquely identifies a schema registry withing a tenant.")
  @visibility("read", "create")
  // namespace is a reserved keyname. Wrap in ` quotes
  `namespace`: string;

  @doc("Human-readable display name.")
  displayName?: string;

  @doc("Human-readable description of the schema registry.")
  description?: string;

  // Not sure this field is neede for auth/permission purposes
  // @doc("The Storage Account resourceId where schemas will be stored.")
  // @visibility("read", "create")
  // storageAccountResourceId: string;

  @doc("The Storage Account's Container URL where schemas will be stored.")
  @visibility("read", "create")
  storageAccountContainerUrl: string;

  @doc("Provisioning state of the resource.")
  @visibility("read")
  provisioningState?: ProvisioningState;

  ...ManagedSystemAssignedIdentityProperty;
}

@added(global.Private.DeviceRegistry.Versions.v2024_07_01_preview)
@parentResource(SchemaRegistry)
@doc("Schema definition.")
model Schema is ProxyResource<SchemaProperties> {
  @doc("Schema name parameter.")
  @key("schemaName")
  @segment("schemas")
  @pattern("^[a-z0-9][a-z0-9-]*[a-z0-9]$")
  @path
  @minLength(3)
  @maxLength(63)
  name: string;
}

@added(global.Private.DeviceRegistry.Versions.v2024_07_01_preview)
@doc("Defines the schema properties.")
model SchemaProperties {
  @doc("Globally unique, immutable, non-reusable id.")
  @visibility("read")
  uuid?: string;

  @doc("Human-readable display name.")
  @visibility("read", "create")
  displayName?: string;

  @doc("Human-readable description of the schema.")
  description?: string;

  @doc("Schema's content type. (JSON Schema only available option at release)")
  @visibility("read", "create")
  contentType: ContentType;

  @doc("Type of the Schema (MessageSchema only available option at release).")
  @visibility("read", "create")
  schemaType: SchemaType;

  // Is this mandatory for pure proxy resources with sync create/update operations?
  @doc("Provisioning state of the resource.")
  @visibility("read")
  provisioningState?: ProvisioningState;

  @doc("Schema tags.")
  tags?: Array<string>;
}

@added(global.Private.DeviceRegistry.Versions.v2024_07_01_preview)
@doc("Defines the schema content type.")
union ContentType {
  @doc("JSON Schema content type")
  JsonSchema: "application/schema+json",

  string,
}

@added(global.Private.DeviceRegistry.Versions.v2024_07_01_preview)
@doc("Defines the schema type.")
union SchemaType {
  @doc("Message Schema schema type")
  MessageShema: "messageSchema",

  string,
}

@added(global.Private.DeviceRegistry.Versions.v2024_07_01_preview)
@parentResource(Schema)
@doc("Schema version's definition.")
model SchemaVersion is ProxyResource<SchemaVersionProperties> {
  @doc("Schema version name parameter.")
  @key("schemaVersionName")
  @segment("schemaVersions")
  @pattern("^[a-z0-9]*$")
  @path
  @minLength(1)
  @maxLength(63)
  name: string;
}

@added(global.Private.DeviceRegistry.Versions.v2024_07_01_preview)
@doc("Defines the schema version properties.")
model SchemaVersionProperties {
  @doc("Globally unique, immutable, non-reusable id.")
  @visibility("read")
  uuid?: string;

  @doc("Human-readable display name.")
  @visibility("read", "create")
  displayName?: string;

  @doc("Human-readable description of the schema.")
  description?: string;

  @doc("Schema Content (for example, the actual payload of a Schema Message).")
  @visibility("read", "create")
  schemaContent: string;

  @doc("Hash of the schema content.")
  @visibility("read")
  hash: string;

  // Is this mandatory for pure proxy resources with sync create/update operations?
  @doc("Provisioning state of the resource.")
  @visibility("read")
  provisioningState?: ProvisioningState;
}

@added(global.Private.DeviceRegistry.Versions.v2024_07_01_preview)
@armResourceOperations
interface SchemaRegistries {
  get is ArmResourceRead<SchemaRegistry>;

  createOrReplace is ArmResourceCreateOrReplaceAsync<SchemaRegistry>;

  delete is ArmResourceDeleteWithoutOkAsync<SchemaRegistry>;

  listByResourceGroup is ArmResourceListByParent<SchemaRegistry>;

  listBySubscription is ArmListBySubscription<SchemaRegistry>;
}

@added(global.Private.DeviceRegistry.Versions.v2024_07_01_preview)
@armResourceOperations
interface Schemas {
  get is ArmResourceRead<Schema>;

  createOrReplace is ArmResourceCreateOrReplaceSync<Schema>;

  delete is ArmResourceDeleteSync<Schema>;

  listByParent is ArmResourceListByParent<Schema>;
}

@added(global.Private.DeviceRegistry.Versions.v2024_07_01_preview)
@armResourceOperations
interface SchemaVersions {
  get is ArmResourceRead<SchemaVersion>;

  createOrReplace is ArmResourceCreateOrReplaceSync<SchemaVersion>;

  delete is ArmResourceDeleteSync<SchemaVersion>;

  listByParent is ArmResourceListByParent<SchemaVersion>;
}
