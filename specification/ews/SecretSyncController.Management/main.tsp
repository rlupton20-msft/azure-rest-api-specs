import "@typespec/http";
import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "./azurekeyvaultsecretproviderclass.tsp";
import "./secretsync.tsp";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.Core;
using Azure.ResourceManager;

@armProviderNamespace("Private.SecretSyncController")
@service(#{ title: "Private.SecretSyncController" })
@doc("Private.SecretSyncController resource provider.")
@versioned(Versions)
namespace Private.SecretSyncController;

interface Operations extends Azure.ResourceManager.Operations {}

@doc("Supported API versions for the Private.SecretSyncController resource provider.")
enum Versions {
  // Private preview - 2024-08-21
  @useDependency(Azure.Core.Versions.v1_0_Preview_1)
  @useDependency(Azure.ResourceManager.Versions.v1_0_Preview_1)
  @armCommonTypesVersion(Azure.ResourceManager.CommonTypes.Versions.v5)
  @doc("The 2021-10-01-privatepreview API.")
  v2021_10_01_privatepreview: "2021-10-01-privatepreview",
}
