import "@typespec/versioning";
import "@azure-tools/typespec-azure-resource-manager";
import "./devices.tsp";

using TypeSpec.Versioning;
using Azure.ResourceManager;

#suppress "@azure-tools/typespec-azure-resource-manager/missing-operations-endpoint"
@armProviderNamespace
@service({
  title: "Microsoft.DeviceRegistry management service",
  version: "2023-11-01-preview",
})
@doc("Microsoft.DeviceRegistry Resource Provider management API.")
@useDependency(Azure.ResourceManager.Versions.v1_0_Preview_1)
@armCommonTypesVersion(Azure.ResourceManager.CommonTypes.Versions.v5)
namespace Microsoft.DeviceRegistry;
