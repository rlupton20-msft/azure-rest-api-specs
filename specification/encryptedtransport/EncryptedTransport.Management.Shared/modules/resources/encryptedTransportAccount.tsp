// -----------------------------------------------------------------------
// <copyright file="encryptedTransportAccount.tsp" company="Microsoft Corporation">
// Copyright (c) Microsoft Corporation. All rights reserved.
// </copyright>
// -----------------------------------------------------------------------
import "@typespec/http";
import "@typespec/rest";
import "@azure-tools/typespec-autorest";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.ResourceManager;
using Azure.Core;

namespace Microsoft.EncryptedTransport;

@doc("Encrypted Transport Account Resource Type")
model EncryptedTransportAccount
  is TrackedResource<EncryptedTransportAccountProperties> {
  @doc("The encrypted transport account name")
  @key("encryptedTransportAccountName")
  @visibility("read")
  @segment("encryptedTransportAccounts")
  @pattern("^[a-zA-Z0-9]{3,24}$")
  @path
  name: string;
}

@doc("Encrypted Transport Account Properties")
model EncryptedTransportAccountProperties {
  @doc("The number of devices that can be associated to the account")
  @minValue(1)
  @maxValue(100)
  @visibility("create", "read")
  deviceCount: int32;

  @doc("Wi-Fi Pre-Shared Key as printable ASCII string")
  @pattern("^[ -~ ]{8,63}$")
  @visibility("create", "read")
  wifiPsk: string;

  @doc("Reference to an existing azure virtual network")
  @visibility("create", "read")
  vnet: VirtualNetworkId;

  @doc("Bandwidth can only be 500, 1000, 2000, 5000, or 10000 Mbps")
  @visibility("create", "read", "update")
  bandwidth: EncryptedTransportAccountBandwidthOptions;

  @doc("Private IP address of the account, genearted by the service")
  @visibility("read")
  privateIpAddress: Azure.Core.ipV4Address[];

  @doc("The status of the last operation.")
  @visibility("read")
  provisioningState?: ProvisioningState;
}

@doc("Encrypted Transport Account bandwidth options in Mbps")
union EncryptedTransportAccountBandwidthOptions {
  @doc("500 Mbps")
  Mbps500: 500,

  @doc("1000 Mbps")
  Mbps1000: 1000,

  @doc("2000 Mbps")
  Mbps2000: 2000,

  @doc("5000 Mbps")
  Mbps5000: 5000,

  @doc("10000 Mbps")
  Mbps10000: 10000,

  int32,
}

/* https://azure.github.io/typespec-azure/docs/howtos/ARM/resource-type#using-resource-identifiers */
@doc("Virtual Network Resource Identifier of customer vnet")
scalar VirtualNetworkId
  extends Azure.Core.armResourceIdentifier<[
    {
      type: "Microsoft.Network/virtualNetworks",
    }
  ]>;

@armResourceOperations
interface EncryptedTransportAccountOperations {
  get is ArmResourceRead<EncryptedTransportAccount>;
  createOrUpdate is ArmResourceCreateOrReplaceAsync<EncryptedTransportAccount>;
  update is ArmResourcePatchSync<
    EncryptedTransportAccount,
    EncryptedTransportAccountProperties
  >;
  delete is ArmResourceDeleteWithoutOkAsync<EncryptedTransportAccount>;
  listByResourceGroup is ArmResourceListByParent<EncryptedTransportAccount>;
  listBySubscription is ArmListBySubscription<EncryptedTransportAccount>;
}
