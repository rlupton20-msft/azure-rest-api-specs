// -----------------------------------------------------------------------
// <copyright file="base.tsp" company="Microsoft Corporation">
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

namespace Microsoft.AccessPoint;

@doc("Properties for a base resource.")
model BaseResourceProperties {
  @doc("The status of the last operation.")
  @visibility("read")
  provisioningState?: ProvisioningState;
}

@Azure.Core.lroStatus
@doc("The provisioning status of the resource")
union ProvisioningState {
  @doc("Provisioning the resource is in progress")
  Provisioning: "Provisioning",

  @doc("Resource is being updated")
  Updating: "Updating",

  @doc("Resource is being deleted")
  Deleting: "Deleting",

  @doc("The change request has been accepted")
  Accepted: "Accepted",

  @doc("The change request has been canceled")
  Canceled: "Canceled",

  @doc("The change request has succeeded")
  Succeeded: "Succeeded",

  @doc("The change request has failed")
  Failed: "Failed",

  string,
}

@doc("The classification of the Access Point Account")
union Classification {

  /**
   * SAP Classification
   */
  SAP: "sap",

  /**
   * SCI_SAP Classification
   */
  SCI_SAP: "sci_sar",

  string,
}

/**
 * Model object to be used to store additional properties
 */
@doc("Container for additional properties")
model PropertyContainer {
  ...Record<string>;
}

@armResourceOperations
interface Operations extends Azure.ResourceManager.Operations {}
