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

@doc("Device Resource Type")
model Device is TrackedResource<DeviceProperties> {
  @doc("The device name")
  @key("deviceName")
  @visibility("read")
  @segment("devices")
  @pattern("^[a-zA-Z0-9]{3,24}$")
  @path
  name: string;
}

@doc("Device Properties")
model DeviceProperties {
  @doc("The serial number of the device, which is the same as the resource name.")
  @pattern("^[a-zA-Z0-9]{3,24}$")
  @visibility("read")
  serialNumber: string;

  @doc("Reference to an existing device profile.")
  @visibility("create", "read")
  deviceProfileId: DeviceProfileId;

  @doc("The MAC address for the end user device.")
  @pattern("^([0-9A-Fa-f]{2}[:-]){5}([0-9A-Fa-f]{2})$")
  @visibility("create", "read", "update")
  macAddress: string;

  @doc("The status of the last operation.")
  @visibility("read")
  provisioningState?: ProvisioningState;
}

/* https://azure.github.io/typespec-azure/docs/howtos/ARM/resource-type#using-resource-identifiers */
@doc("Device Profile Resource Identifier of the Selected Device Profile")
scalar DeviceProfileId
  extends Azure.Core.armResourceIdentifier<[
    {
      type: "Microsoft.EncryptedTransport/encryptedTransportAccounts/deviceProfiles",
    }
  ]>;

@armResourceOperations
interface DeviceOperations {
  get is ArmResourceRead<Device>;
  createOrUpdate is ArmResourceCreateOrReplaceAsync<Device>;
  update is ArmResourcePatchSync<Device, DeviceProperties>;
  delete is ArmResourceDeleteWithoutOkAsync<Device>;
  listByEncryptedTransportAccount is ArmResourceListByParent<Device>;
  listBySubscription is ArmListBySubscription<Device>;
}
