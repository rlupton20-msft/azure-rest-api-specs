// -----------------------------------------------------------------------
// <copyright file="device.tsp" company="Microsoft Corporation">
// Copyright (c) Microsoft Corporation. All rights reserved.
// </copyright>
// -----------------------------------------------------------------------

import "@typespec/http";
import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-autorest";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.ResourceManager;
using Azure.Core;

namespace Microsoft.Access;

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "Suppress error until we transition to using ResourceSkuProperty."
@doc("An Encrypted Transport Device Resource")
@parentResource(Circuit)
@added(Versions.v2024_02_24_preview)
model Device is TrackedResource<DeviceProperties> {
  @doc("The name of the Access Point")
  @key("deviceName")
  @segment("devices")
  @pattern("^[a-zA-Z0-9][a-zA-Z0-9-]{1,62}[a-zA-Z0-9]$")
  @path
  name: string;

  @doc("The billing sku type.")
  @visibility("read")
  sku?: ResourceSkuType;
}

@doc("Encrypted Transport Device Properties.")
@added(Versions.v2024_02_24_preview)
model DeviceProperties is BaseResourceProperties {
  // Standard MAC address format
  // 00:00:00:00:00:00
  // lowercase, uppercase letters, 6 groups of 2 hex digits, separated by colons
  @doc("The MAC address")
  @pattern("^[a-fA-F0-9]{2}(:[a-fA-F0-9]{2}){5}$")
  @visibility("create", "read")
  macAddress: string;

  @doc("The device asset tag.")
  @visibility("create", "read", "update")
  assetTag?: string;

  @doc("The device serial number.")
  @visibility("create", "read", "update")
  serialNumber?: string;
}

@added(Versions.v2024_02_24_preview)
@armResourceOperations
interface DeviceOperations {
  get is ArmResourceRead<Device>;
  createOrUpdate is ArmResourceCreateOrUpdateAsync<Device>;
  delete is ArmResourceDeleteWithoutOkAsync<Device>;
  listByCircuit is ArmResourceListByParent<Device>;
  update is ArmResourcePatchSync<Device, DeviceProperties>;
}
