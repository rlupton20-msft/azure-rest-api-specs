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
  @Autorest.example(
    "./examples/virtualNetworkAddresses_listByParent.json",
    "List Virtual Network Addresses by VM Cluster"
  )
  listByParent is ArmResourceListByParent<VirtualNetworkAddress>;

  @Autorest.example(
    "./examples/virtualNetworkAddresses_attach.json",
    "Attach Virtual Network Addresses of VM Cluster"
  )
  @added(Versions.v20240701_preview)
  attach is ArmResourceActionAsync<VirtualNetworkAddress, VirtualNetworkAddressProperties, VirtualNetworkAddress>;

  @Autorest.example(
    "./examples/virtualNetworkAddresses_detach.json",
    "Detach Virtual Network Addresses of VM Cluster"
  )
  @added(Versions.v20240701_preview)
  detach is ArmResourceActionAsync<VirtualNetworkAddress, void, VirtualNetworkAddress>;
}

@@Autorest.example(VirtualNetworkAddresses.createOrUpdate,
  "./examples/virtualNetworkAddresses_create.json",
  "Create Virtual Network Address"
);
@@Autorest.example(VirtualNetworkAddresses.get,
  "./examples/virtualNetworkAddresses_get.json",
  "Get Virtual Network Address"
);
@@Autorest.example(VirtualNetworkAddresses.delete,
  "./examples/virtualNetworkAddresses_delete.json",
  "Delete Virtual Network Address"
);
