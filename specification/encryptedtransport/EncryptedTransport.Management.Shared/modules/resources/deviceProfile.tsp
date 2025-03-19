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

@doc("Device Profile Resource Type")
model DeviceProfile is TrackedResource<DeviceProfileProperties> {
  @doc("The device profile name")
  @key("deviceProfileName")
  @visibility("read")
  @segment("deviceProfiles")
  @pattern("^[a-zA-Z0-9]{3,24}$")
  @path
  name: string;
}

@doc("Device Profile Properties")
model DeviceProfileProperties {
  @doc("File name such as eud-rhel94-image-0_1_0.vhd corresponding to the device profile image.")
  @pattern("^[A-Za-z0-9-]+\\.[A-Za-z]$")
  @visibility("create", "read")
  imageId: string;

  @doc("User-friendly name describing the device profile, for example 'Dell Image with Audio and Camera'.")
  @pattern("^[a-zA-Z0-9 ]{3,60}$")
  @visibility("create", "read")
  profileName: string;

  @doc("The status of the last operation.")
  @visibility("read")
  provisioningState?: ProvisioningState;
}

@armResourceOperations
interface DeviceProfileOperations {
  get is ArmResourceRead<DeviceProfile>;
  createOrUpdate is ArmResourceCreateOrReplaceAsync<DeviceProfile>;
  update is ArmResourcePatchSync<DeviceProfile, DeviceProfileProperties>;
  delete is ArmResourceDeleteWithoutOkAsync<DeviceProfile>;
  listByEncryptedTransportAccount is ArmResourceListByParent<DeviceProfile>;
  listBySubscription is ArmListBySubscription<DeviceProfile>;
}
