import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "./models.tsp";
import "./Firmware.tsp";
import "./BinaryHardeningResource.tsp";
import "./CryptoCertificateResource.tsp";
import "./CryptoKeyResource.tsp";
import "./CveResource.tsp";
import "./PasswordHashResource.tsp";
import "./SbomComponentResource.tsp";
import "./SummaryResource.tsp";
import "./Workspace.tsp";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.ResourceManager.Foundations;
using Azure.Core;
using Azure.ResourceManager;
using TypeSpec.Versioning;
/**
 * Firmware & IoT Security REST API
 */
@armProviderNamespace
@useAuth(AadOauth2Auth<["user_impersonation"]>)
@service({
  title: "Iot Firmware Defense",
})
@versioned(Versions)
@armCommonTypesVersion(Azure.ResourceManager.CommonTypes.Versions.v5)
namespace Microsoft.IotFirmwareDefense;

/**
 * The available API versions.
 */
enum Versions {
  /**
   * The 2024-04-26-preview API version.
   */
  @useDependency(Azure.ResourceManager.Versions.v1_0_Preview_1)
  @useDependency(Azure.Core.Versions.v1_0_Preview_1)
  v2024_04_26: "2024-04-26-preview",
}
