// -----------------------------------------------------------------------
// <copyright file="accesspointservice.tsp" company="Microsoft Corporation">
// Copyright (c) Microsoft Corporation. All rights reserved.
// </copyright>
// -----------------------------------------------------------------------

import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Versioning;
using Azure.Core;
using Azure.ResourceManager;

@armProviderNamespace("Private.Access")
@service({
  title: "Private.Access",
})
@versioned(Microsoft.Access.Versions)
@doc("Azure Private RP Access Management API")
namespace Microsoft.Access;

@doc("Azure Access Service versioning")
enum Versions {
  @doc("Access Service 2023-05-24-preview version")
  @armCommonTypesVersion(CommonTypes.Versions.v5)
  @useDependency(Azure.ResourceManager.Versions.v1_0_Preview_1)
  v2023_05_24_preview: "2023-05-24-preview",

  @doc("Access Service 2024-02-24-preview version")
  @armCommonTypesVersion(CommonTypes.Versions.v5)
  v2024_02_24_preview: "2024-02-24-preview",
}
