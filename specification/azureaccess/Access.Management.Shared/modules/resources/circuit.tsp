// -----------------------------------------------------------------------
// <copyright file="circuit.tsp" company="Microsoft Corporation">
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

@doc("The Encrypted Transport Circuit")
@added(Versions.v2024_02_24_preview)
model Circuit is TrackedResource<CircuitResourceProperties> {
  @doc("The name of the circuit")
  @key("circuitName")
  @segment("circuits")
  @pattern("^[a-zA-Z0-9][a-zA-Z0-9-]{1,62}[a-zA-Z0-9]$")
  @path
  name: string;

  ...ResourceSkuProperty;
}

@doc("Encrypted Transport Circuit Properties.")
@added(Versions.v2024_02_24_preview)
model CircuitResourceProperties is BaseResourceProperties {
  @doc("Circuit Site Location")
  @pattern("^((25[0-5]|2[0-4][0-9]|1[0-9][0-9]|[1-9]?[0-9])\\.){3}(25[0-5]|2[0-4][0-9]|1[0-9][0-9]|[1-9]?[0-9])$")
  @visibility("create", "read", "update")
  siteLocation?: string;
}

@added(Versions.v2024_02_24_preview)
@armResourceOperations
interface CircuitOperations {
  get is ArmResourceRead<Circuit>;
  createOrUpdate is ArmResourceCreateOrUpdateAsync<Circuit>;
  delete is ArmResourceDeleteWithoutOkAsync<Circuit>;
  listByResourceGroup is ArmResourceListByParent<Circuit>;
  listBySubscription is ArmListBySubscription<Circuit>;
  update is ArmResourcePatchSync<Circuit, CircuitResourceProperties>;
}
