import "@typespec/http";
import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-providerhub";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.Core;
using Azure.ResourceManager;
using OpenAPI;

@armProviderNamespace
@service({
  title: "Edge Devices",
  version: "2023-08-01-preview",
})
@doc("Azure Arc-enabled Edge Device.")
@useDependency(Azure.ResourceManager.Versions.v1_0_Preview_1)
namespace Microsoft.AzureStackHCI;

@doc("Edge device resource")
model EdgeDevice is ExtensionResource<EdgeDeviceProperties> {
  @doc("Name of Device")
  @pattern("^[a-zA-Z0-9-]{3,24}$")
  @key("edgeDeviceName")
  @path
  @segment("edgeDevices")
  name: string = "default"
}

@doc("Edge Device properties")
model EdgeDeviceProperties {
  @doc("Device Configuration")
  deviceConfiguration: DeviceConfiguration;
  // @doc("Device metadata")
  // deviceMetadata?: string;
  @doc("Provisioning state of edgeDevice resource")
  @visibility("read")
  provisioningState?: ProvisioningState
}

@doc("The device Configuration of a device.")
model DeviceConfiguration {
  @doc("NIC Details of device")
  @extension("x-ms-identifiers", [])
  nicDetails: NicDetail[],
}

@doc("The NIC Detail of a device.")
model NicDetail {
  @doc("Adapter Name of NIC")
  adapterName: string;

  @doc("Interface Description of NIC")
  interfaceDescription?: string;

  @doc("Component Id of NIC")
  componentId?: string;
  
  @doc("Driver Version of NIC")
  driverVersion?: string;
  
  @doc("Subnet Mask of NIC")
  ip4Address?: string;

  @doc("Subnet Mask of NIC")
  subnetMask?: string;

  @doc("Default Gateway of NIC")
  defaultGateway?: string;

  @doc("DNS Servers for NIC")
  @extension("x-ms-identifiers", [])
  dnsServers?: string[];

  @doc("Default Isolation of Management NIC")
  defaultIsolationId?: string;
}

@doc("The provisioning state of a resource.")
@lroStatus
enum ProvisioningState {
  ...ResourceProvisioningState,

  @doc("The resource provision state is not specified")
  NotSpecified,

  @doc("The resource is being provisioned")
  Provisioning,

  @doc("The resource is updating")
  Updating,

  @doc("The resource is being deleted")
  Deleting,

  @doc("The resource create request has been accepted")
  Accepted,
}


@doc("The validate request for Edge Device.")
model ValidateRequest{
  @doc("Node Ids against which, current node has to be validated.")
  edgeDeviceIds : string[],
  @doc("additional Info required for validation")
  additionalInfo?: string
}

@doc("An Accepted response with an Operation-Location header.")
model ValidateResponse{
  @doc("edge device validation status")
  @visibility("read")
  status?: string, 

  @doc("The status code.")
  @statusCode
  @visibility("read")
  statusCode: 202;
}

// interface Operations extends Azure.ResourceManager.Operations {}

@armResourceOperations
interface EdgeDevices {
  get is ArmResourceRead<EdgeDevice>;
  createOrUpdate is ArmResourceCreateOrUpdateAsync<EdgeDevice>;
  delete is ArmResourceDeleteAsync<EdgeDevice>;
  listByParent is ArmResourceListByParent<EdgeDevice>;
  validate is ArmResourceActionAsync<EdgeDevice, ValidateRequest, ValidateResponse>;
}
