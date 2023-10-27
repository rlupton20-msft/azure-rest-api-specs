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

@doc("Protocol for the traffic rule")
enum IpProtocol {
  @doc("Transmission Control Protocol")
  TCP,

  @doc("User Datagram Protocol")
  UDP,

  @doc("Internet Control Message Protocol")
  ICMP,

  @doc("Any protocol")
  Any,
}

@doc("Global Entry Profile Policy Rule Properties.")
model EntryProfilePolicyRule {
  @doc("The name of the rule.")
  name: ResourceName;

  @doc("The source addresses.")
  sourceAddresses: IpRule[];

  @doc("The port that the traffic enters on at the edge of the Global Entry Manager.")
  destinationPort: Port;

  @doc("The protocol of the source.")
  ipProtocols: IpProtocol[];

  @doc("The address in the exit virtual network that the Global Entry Manager is forwarding traffic to.")
  translatedAddress: IpAddress;

  @doc("The port of the translated address that the Global Entry Manager is forwarding traffic to.")
  translatedPort: Port;
}

@doc("Entry Profile Policy properties.")
model EntryProfilePolicyProperties extends BaseResourceProperties {
  @doc("The rules of the Global Entry Profile Policy.")
  @OpenAPI.extension("x-ms-identifiers", ["name"])
  rules: EntryProfilePolicyRule[];
}
