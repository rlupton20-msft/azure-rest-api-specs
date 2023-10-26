import "@typespec/http";
import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-providerhub";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "./common.tsp";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.Core;
using Azure.ResourceManager;

@doc("Managed Resource Group Properties.")
model ManagedResourceGroupProperties {
  @doc("The Name of the Managed Resource Group.")
  name?: string;

  @doc("The Managed Resource Group Region is associated to.")
  location?: string;
}

@doc("Global Entry Manager Properties.")
model GlobalEntryManagerProperties extends BaseResourceProperties {
  @doc("The Managed Resource Group for the Global Entry Manager.")
  @visibility("create", "read")
  managedResourceGroupConfiguration?: ManagedResourceGroupProperties;
}
