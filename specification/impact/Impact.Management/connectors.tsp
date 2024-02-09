import "@typespec/http";
import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-providerhub";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.ResourceManager;

@armProviderNamespace("Microsoft.Impact")
@service({
  title: "Microsoft.Impact",
  version: "2021-08-01-preview",
})
@useDependency(Azure.ResourceManager.Versions.v1_0_Preview_1)
@armCommonTypesVersion(Azure.ResourceManager.CommonTypes.Versions.v5)
namespace Microsoft.Impact;

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-path-segment-invalid-chars" "Existing Template"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-key-invalid-chars" "Existing template"
@doc("A ImpactProviderHub resource")
model Connector is ProxyResource<ConnectorProperties> {
  @doc("The name of the connector")
  @pattern("^[a-zA-Z0-9-]{3,24}$")
  @key("ConnectorName")
  @segment("Connectors")
  @path
  name: string;
}

@doc("Details of the Impact Connector.")
model ConnectorProperties {

  @visibility("read")
  @doc("unique id of the connector.")
  connectorId: string;

  @visibility("read")
  @doc("tenant id of this connector")
  tenantId: string;

  @doc("connector type")
  type: ConnectorType;

  @doc("filters associated with this connector")
  filters: string;

  @visibility("read")
  @doc("last run time stamp of this connector in UTC time zone")
  lastRunTimeStamp: utcDateTime;
}

@doc("Enum for connector types")
enum ConnectorType {
  @doc("Azure Monitor Connector")
  AzureMonitorConnector: "Azure Monitor Connector"
}

@armResourceOperations(Connector)
interface Connectors {
  get is ArmResourceRead<Connector>;
  createOrUpdate is ArmResourceCreateOrReplaceAsync<Connector>;
  update is ArmResourcePatchSync<Connector, ConnectorProperties>;
  delete is ArmResourceDeleteSync<Connector>;
  listByResourceGroup is ArmResourceListByParent<Connector>;
  listBySubscription is ArmListBySubscription<Connector>;
}
