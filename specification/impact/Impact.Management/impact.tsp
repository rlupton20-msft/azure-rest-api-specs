import "@typespec/rest";

import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/versioning";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.ResourceManager;

@armProviderNamespace
@service({
  title: "Private.Impact",
})
@versioned(Versions)
@armCommonTypesVersion(CommonTypes.Versions.v5)
namespace Private.Impact;

@doc("API Versions")
enum Versions {
  @useDependency(Azure.ResourceManager.Versions.v1_0_Preview_1)
  @useDependency(Azure.Core.Versions.v1_0_Preview_2)
  @doc("May 01, 2024 Preview API Version")
  v2024_05_01_preview: "2024-05-01-preview",

  @useDependency(Azure.ResourceManager.Versions.v1_0_Preview_1)
  @useDependency(Azure.Core.Versions.v1_0_Preview_2)
  @doc("January 01, 2025 Preview API Version")
  v2025_01_01_preview: "2025-01-01-preview",
}

/** A successful response from getUploadToken will contain an "uploadUrl" field. This uploadUrl field's value should follow the format: https://<storage-account-name>.blob.core.windows.net/<container-name>/<ENTER YOUR BLOB NAME HERE>?<SAS-token> */
model UploadTokenResult {
  @doc("The SAS token URL for uploading")
  uploadUrl: string;
}

@armResourceOperations
interface UploadService {
  /** Customer can use this POST endpoint to trigger an action, where the UserRP/AzImpactRP service creates and returns a user-delegate SAS token for the storage account/container unique to the customer (identified by subscription ID). */
  getUploadToken is ArmProviderActionSync<
    void,
    ArmResponse<UploadTokenResult>,
    SubscriptionActionScope
  >;
}
