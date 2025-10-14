import "@typespec/http";
import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "./common.tsp";
import "./cloudValidation.tsp";
import "./validationTestCategory.tsp";
import "./validationTest.tsp";
import "./validationExecutionPlan.tsp";
import "./validationExecutionPlanRun.tsp";

using TypeSpec.Versioning;
using Azure.ResourceManager;

/** Microsoft.Validate Resource Provider management API. */
#suppress "@azure-tools/typespec-azure-resource-manager/missing-operations-endpoint" "Operations Swagger is common for all RTs and is created as a separate file having it's own folder."
@armProviderNamespace("Microsoft.Validate")
@service(#{ title: "Microsoft.Validate management service" })
@versioned(global.Microsoft.Validate.Versions)
namespace Microsoft.Validate;

/** The available API versions. */
enum Versions {
  /** 2025-02-01-preview version */
  @armCommonTypesVersion(Azure.ResourceManager.CommonTypes.Versions.v5)
  v2025_02_01_preview: "2025-02-01-preview",
}
