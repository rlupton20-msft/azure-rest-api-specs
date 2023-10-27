import "@typespec/http";
import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-providerhub";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "./common.tsp";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.Core;
using Azure.ResourceManager;

@doc("Exit Virtual Network Properties.")
model ExitVirtualNetworkProperties {
  @doc("The ID of the virtual network where traffic from the Global Entry Manager will land.")
  @visibility("create", "read")
  virtualNetworkId: VirtualNetworkId;

  @doc("The flag of whether to use the Transport Gateway in the Exit Virtual Network.")
  @visibility("create", "read", "update")
  useRemoteGateways: boolean;
}

@doc("Global Entry Profile Properties.")
model EntryProfileProperties extends BaseResourceProperties {
  @doc("The DNS Name for the Global Entry Profile.")
  @visibility("create", "read")
  @pattern("^[a-zA-Z0-9][a-zA-Z0-9-\\.]{1,62}[a-zA-Z0-9]$")
  dnsName: string;

  @doc("The Exit Virtual Network the Global Entry Profile is providing access to.")
  exitVirtualNetwork: ExitVirtualNetworkProperties;

  ...LinkableResourceProperties;
}
