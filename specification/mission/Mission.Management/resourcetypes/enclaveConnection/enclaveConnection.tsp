import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

import "../shared/provisioningstate.tsp";
import "../shared/resourceid.tsp";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.Core;
using Azure.ResourceManager;

@doc("Microsoft Mission Resource Provider management API.")
namespace Microsoft.Mission;

@doc("Specifies the state of the enclave connection.")
union EnclaveConnectionState {
  @doc("EnclaveConnectionState Type Pending Approval")
  PendingApproval: "PendingApproval",

  @doc("EnclaveConnectionState Type Pending Update")
  PendingUpdate: "PendingUpdate",

  @doc("EnclaveConnectionState Type Approved")
  Approved: "Approved",

  @doc("EnclaveConnectionState Type Active")
  Active: "Active",

  @doc("EnclaveConnectionState Type Failed")
  Failed: "Failed",

  @doc("EnclaveConnectionState Type Connected")
  Connected: "Connected",

  @doc("EnclaveConnectionState Type Disconnected")
  Disconnected: "Disconnected",

  string,
}

@doc("Enclave Connection Resource properties")
model EnclaveConnectionProperties {
  @doc("The state of the enclaveConnection.")
  @visibility("read")
  state?: EnclaveConnectionState;

  @doc("Community Resource Id.")
  @visibility("read", "create")
  communityResourceId: CommunityResourceId;

  @doc("Source Resource Id.")
  @visibility("read", "create")
  sourceResourceId: EnclaveConnectionSourceResourceId;

  @doc("Source CIDR.")
  sourceCidr?: string;

  @doc("Source IP group Resource Id.")
  @visibility("read", "create")
  ipGroup?: IPGroupResourceId;

  @doc("Destination Endpoint Resource Id.")
  @visibility("read", "create")
  destinationEndpointId: DestinationEndpointResourceId;

  @doc("Provisioning State.")
  @visibility("read")
  provisioningState?: ProvisioningState;

  @doc("List of resource ids modified by enclave Connections.")
  @visibility("read")
  resourceCollection?: string[];
}
