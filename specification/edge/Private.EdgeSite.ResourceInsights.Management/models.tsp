import "@typespec/rest";
import "@typespec/http";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;

namespace Private.EdgeSite;

/**
 * The Connectivity Status
 */
union ConnectivityStatusEnum {
  string,

  /**
   * The device is in Connected state
   */
  Connected: "Connected",

  /**
   * The device was NotRecentlyConnected
   */
  NotRecentlyConnected: "NotRecentlyConnected",

  /**
   * The device NeedsAttention
   */
  NeedsAttention: "NeedsAttention",
}

/**
 * The update Status
 */
union UpdateStatus {
  string,

  /**
   * The device is in Unknown state
   */
  Unknown: "Unknown",

  /**
   * The device is in Update state
   */
  UpdateAvailable: "UpdateAvailable",

  /**
   * The device is in UptoDate state
   */
  UptoDate: "UptoDate",

  /**
   * The device is in UpdateInProgress state
   */
  UpdateInProgress: "UpdateInProgress",

  /**
   * The device is in NeedsAttention state
   */
  NeedsAttention: "NeedsAttention",
}

/**
 * ResourceInsight properties
 */
model ResourceInsightProperties {
  /**
   * The Connectivity Status
   */
  connectivityStatus?: ConnectivityStatusEnum;

  /**
   * The update Status
   */
  updateStatus?: UpdateStatus;

  /**
   * The status of the last operation.
   */
  @visibility("read")
  provisioningState?: ResourceProvisioningState;
}
