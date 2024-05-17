import "@azure-tools/typespec-azure-resource-manager";
import "../../common/models/virtualNetworkAddress.tsp";

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
  @example(
    "./examples/virtualNetworkAddresses_listByParent.json",
    "List Virtual Network Addresses by VM Cluster"
  )
  listByParent is ArmResourceListByParent<VirtualNetworkAddress>;
}

@@example(VirtualNetworkAddresses.createOrUpdate,
  "./examples/virtualNetworkAddresses_create.json",
  "Create Virtual Network Address"
);
@@example(VirtualNetworkAddresses.get,
  "./examples/virtualNetworkAddresses_get.json",
  "Get Virtual Network Address"
);
@@example(VirtualNetworkAddresses.delete,
  "./examples/virtualNetworkAddresses_delete.json",
  "Delete Virtual Network Address"
);
