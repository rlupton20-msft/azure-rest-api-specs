import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./Firmware.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.IotFirmwareDefense;

/**
 * List of crypto certificates.
 */
model CryptoCertificateListResult is Azure.Core.Page<CryptoCertificateResource>;

/**
 * The object representing a firmware analysis crypto certificate resource
 */
@parentResource(Firmware)
model CryptoCertificateResource is ProxyResource<CryptoCertificate> {
  /**
   * The id of the crypto certificate result.
   */
  @path
  @key("cryptoCertificateId")
  @segment("cryptoCertificates")
  @visibility("read")
  @pattern("^[a-zA-Z0-9][a-zA-Z0-9_.-]*$")
  name: string;
}

@armResourceOperations
interface CryptoCertificates {
  /**
   * Lists crypto certificate analysis results of a firmware.
   */
  listByFirmware is ArmResourceListByParent<
    CryptoCertificateResource,
    {
      ...Azure.Core.TopQueryParameter;
      ...ApiVersionParameter;
    }
  >;
}
