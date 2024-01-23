import "@typespec/http";
import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-providerhub";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@azure-tools/typespec-autorest";

import "./CommonResources.tsp";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.Core;
using Azure.ResourceManager;

@doc("Exposure Control Resource Provider Service API.")
namespace Microsoft.Edge;


@doc("Rollout definition Properties")
model ExposureWorkflowManifestProperties {

  @doc("Feature Name.")
  exposureFeatureId: string;
  
  @doc("Ring description.")
  discriminator: string;

  @doc("default ring.")
  defaultRing?: string;

  @doc("ring configuration properties.")
  ringConfigurations: Array<RingConfigurationProperties>;

  @visibility("read")
  @doc("The status of the last operation.")
  provisioningState?: ProvisioningState;
}

@doc("A exposure control rollout definition resource")
model ExposureWorkflowManifest is ProxyResource<ExposureWorkflowManifestProperties> {
  @doc("Name of Rollout Definition")
  @pattern("^[a-zA-Z0-9-]{3,24}$")
  @key("exposureWorkflowManifestName")
  @path
  @segment("exposureWorkflowManifests")
  name: string;
}

@doc("Progression settings.")
model ProgressionSetting {
  @doc("Progression methods.")
  method: ProgressionMethod;

  @doc("Gate Status.")
  gateStatus: GateStatus;

  @doc("Onsuccess ring settings.")
  onSuccessRing: string;

  @doc("OnFailure ring settings.")
  onFailureRing: string;
}

@doc("Ring progression method.")
model ProgressionMethod {
  @doc("Operation type.")
  operationType: ProgressionType;

  @doc("Gate delay.")
  gateDelay: duration;

  @doc("Defines interval for status polling.")
  statusPollingInterval: duration;
}

@doc("Progression type enum.")
enum ProgressionType {
  @doc("Periodic.")
  Periodic,
  @doc("Manual.")
  Manual,
}

@doc("GateStatus enum.")
enum GateStatus {
  @doc("Open.")
  Open,
  @doc("Closed.")
  Closed,
}

@doc("Ring configuration Properties")
model RingConfigurationProperties {

  @doc("Ring name.")
  name: string;

  @doc("Group names.")
  exposureGroupIds: Array<string>;

  @doc("Ring status.")
  status: RingStatus;

  @doc("Progression settings.")
  progressionSetting: ProgressionSetting;

  @visibility("read")
  @doc("The status of the last operation.")
  provisioningState?: ProvisioningState;
}









