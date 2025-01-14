import "@typespec/http";
import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

import "./models.tsp";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.ResourceManager;

@armProviderNamespace("Private.StorageDataRp")
@service({
  title: "Storage Data Resource Provider",
})
@versioned(Versions)
@armCommonTypesVersion(Azure.ResourceManager.CommonTypes.Versions.v5)
namespace Private.StorageDataRp;

enum Versions {
  @useDependency(Azure.ResourceManager.Versions.v1_0_Preview_1)
  `2024-11-01-preview`,

  `2025-01-01-preview`,
}

interface Operations extends Azure.ResourceManager.Operations {}

@doc("A Connector is a tracked ARM resource modeled as a sub-resource of a Storage Account")
model Connector is TrackedResource<ConnectorProperties> {
  @doc("The name of the connector")
  @pattern("^[a-z0-9](?!.*--)[a-z0-9-]{1,61}[a-z0-9]$")
  @key("connectorName")
  @segment("connectors")
  @path
  name: string;
}

@armResourceOperations(Connector)
interface Connectors {
  @doc("Get the specified Storage Connector.")
  get is ArmResourceRead<Connector>;

  @doc("Create or update a Storage Connector.")
  createOrReplace is ArmResourceCreateOrReplaceAsync<Connector>;

  @doc("Update a Storage Connector.")
  update is ArmCustomPatchSync<Connector, ConnectorUpdateProperties>;

  @doc("Delete a Storage Connector.")
  delete is ArmResourceDeleteSync<Connector>;

  @doc("List all Storage Connectors in a Resource Group.")
  listByResourceGroup is ArmResourceListByParent<Connector>;

  @doc("List all Storage Connectors in a Subscription.")
  listBySubscription is ArmListBySubscription<Connector>;

  @doc("This method is used to verify that the connection to the backing data store works. This API is designed to be used for monitoring and debugging purposes. From the caller’s perspective, this method does the following: Calls List on the backing data store, attempting to list up to one blob/object/etc. If the above succeeds, and if a blob/object/etc is found, calls Get on that object, attempting to download one byte.")
  existingConnectionTest is ArmResourceActionSync<
    Connector,
    ExistingConnectionTestRequest,
    TestConnectionResponse
  >;

  @doc("This method is used to verify that a proposed connection to the backing data store will work, if Create Connector is called with the same Connector information provided in the body of this API request. This API is designed to be used in the initialization flow, where a new user would call Storage Connector Test Proposed Connection, and upon getting a successful response, then call Storage Connector Create with the same input.  See above API “Storage Connectors – Test Existing Connection” for an API designed to be called for monitoring and debugging, once a Connector is created.")
  proposedConnectionTest is ArmResourceActionSync<
    Connector,
    Connector,
    TestConnectionResponse
  >;
}
