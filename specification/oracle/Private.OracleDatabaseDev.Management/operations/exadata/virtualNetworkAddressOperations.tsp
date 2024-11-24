import "@azure-tools/typespec-azure-resource-manager";
import "../../models/exadata/virtualNetworkAddress.tsp";

using Azure.ResourceManager;
using Autorest;
using TypeSpec.Versioning;

namespace Private.OracleDatabaseDev;

@armResourceOperations
interface VirtualNetworkAddresses
  extends OracleChildResource<
      VirtualNetworkAddress,
      VirtualNetworkAddressProperties
    > {
  // TODO: Swagger generator bug, cannot be extracted to interface
  listByParent is ArmResourceListByParent<VirtualNetworkAddress>;

  @added(Versions.v20240701_preview)
  attach is ArmResourceActionAsync<
    VirtualNetworkAddress,
    VirtualNetworkAddressProperties,
    VirtualNetworkAddress
  >;

  @added(Versions.v20240701_preview)
  detach is ArmResourceActionAsync<
    VirtualNetworkAddress,
    void,
    VirtualNetworkAddress
  >;
}
