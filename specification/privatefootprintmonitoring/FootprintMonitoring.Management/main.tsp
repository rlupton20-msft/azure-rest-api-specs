import "@typespec/http";
import "@typespec/rest";
import "@typespec/versioning";
// import "@azure-tools/typespec-providerhub";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.Core;
using Azure.ResourceManager;

@armProviderNamespace("Private.FootprintMonitoring")
@service({
  title: "Private.FootprintMonitoring",
})
@doc("Microsoft Footprint active monitoring system REST API version 2024-09-16-preview.")
@versioned(Versions)
@armCommonTypesVersion(CommonTypes.Versions.v5)
namespace Private.FootprintMonitoring;

enum Versions {
  @doc("2024-09-16-preview api version")
  @useDependency(Azure.ResourceManager.Versions.v1_0_Preview_1)
  `2024-09-16-preview`,
}

@doc("The Footprint profile resource.")
model Profile is TrackedResource<ProfileProperties> {
  @doc("Name of the Footprint profile resource.")
  @minLength(3)
  @maxLength(64)
  @pattern("^[a-zA-Z0-9]")
  @key("profileName")
  @path
  @segment("profiles")
  name: string;
}

@doc("A model representing the Footprint profile resource.")
model ProfileProperties {
  @doc("The status of the last operation.")
  @visibility("read")
  provisioningState?: ResourceProvisioningState;

  @doc("The id of the Footprint profile.")
  @visibility("read")
  profileId?: string;

  @doc("The description of the Footprint profile.")
  description?: string;

  @doc("The delay in milliseconds that the clients should wait for until they start performing measurements.")
  @minValue(0)
  @maxValue(3600000)
  startDelayMilliseconds: int32;

  @doc("The URL where the script for the Footprint profile.")
  @visibility("read")
  scriptUri?: string;

  @doc("The number of measurements to perform.")
  measurementCount: int32;

  @doc("The default sampling percentage for cold path measurement storage.")
  @minValue(0)
  @maxValue(100)
  coldPathSamplingPercentageRate?: float32;

  @doc("The endpoints which to perform measurements to.")
  @visibility("read")
  measurementEndpoints?: Array<MeasurementEndpoint>;

  @doc("The endpoints which to upload measurements to.")
  reportingEndpoints?: Array<string>;

  @doc("The experiments currently associated to this Footprint profile.")
  @visibility("read")
  experiments?: Array<Experiment>;
}

@doc("Name of the Footprint measurement endpoint resource.")
@parentResource(Profile)
model MeasurementEndpoint is ProxyResource<ProfileProperties> {
  @doc("Name of the Footprint profile resource.")
  @minLength(5)
  @maxLength(64)
  @pattern("^[a-zA-Z0-9]")
  @key("measurementEndpointName")
  @path
  @segment("measurementEndpoints")
  name: string;
}

@doc("A model representing the Footprint Measurement Endpoint resource.")
model MeasurementEndpointProperties {
  @doc("The id of a measurement endpoint.")
  @visibility("read")
  @minLength(32)
  @maxLength(32)
  @pattern("[a-f0-9]{32}")
  endpointId?: string;

  @doc("The description of a measurement endpoint.")
  description?: string;

  @doc("The value of a measurement endpoint.")
  @minLength(0)
  @maxLength(1024)
  // TODO: this is an issue
  @pattern("^[a-z0-9\\*]+([\\-\\.]{1}[a-z0-9]+)*\\.[a-z]{2,}(:[0-9]{1,5})?$")
  endpoint: string;

  @doc("The type of a measurement endpoint.")
  measurementType: int32;

  @doc("The weight of a measurement endpoint, higher weight means higher priority.")
  @minValue(0)
  @maxValue(2147483647)
  weight: int32;

  @doc("The id of an experiment that a measurement endpoint is part of.")
  @minLength(32)
  @maxLength(32)
  @pattern("[a-f0-9]{32}")
  experimentId?: string;

  @doc("The path of the object that a measurement endpoint points to.")
  @minLength(0)
  @maxLength(1024)
  @pattern("^/[a-zA-Z0-9-._~%!$&()*+,;=@/]*$")
  objectPath?: string;

  @doc("The conditions of a measurement endpoint.")
  @visibility("read")
  conditions?: Array<MeasurementEndpointCondition>;

  @doc("The start time that a measurement endpoint should be served.")
  startTimeUtc?: utcDateTime;

  @doc("The end time that a measurement endpoint should be served.")
  endTimeUtc?: utcDateTime;

  @doc("The sampling rate, in percent, for the hot path logging of a measurement endpoint.")
  @minValue(0)
  @maxValue(100)
  hotPathSamplingPercentageRate?: float32;

  @doc("The sampling rate, in percent, for the warm path logging of a measurement endpoint.")
  @minValue(0)
  @maxValue(100)
  warmPathSamplingPercentageRate?: float32;

  @doc("The sampling rate, in percent, for the cold path logging of a measurement endpoint.")
  @minValue(0)
  @maxValue(100)
  coldPathSamplingPercentageRateOverride?: float32;

  @doc("The metadata of a measurement endpoint.")
  metadata: string;
}

@doc("A model representing the Footprint Measurement Endpoint Condition resource.")
@parentResource(MeasurementEndpoint)
model MeasurementEndpointCondition
  is ProxyResource<MeasurementEndpointConditionProperties> {
  @doc("Name of the Footprint measurement endpoint condition resource.")
  @minLength(5)
  @maxLength(64)
  @pattern("^[a-zA-Z0-9]")
  @key("conditionName")
  @path
  @segment("conditions")
  name: string;
}

@doc("A model representing the Footprint Measurement Endpoint Condition resource.")
model MeasurementEndpointConditionProperties {
  @doc("The status of the last operation.")
  @visibility("read")
  provisioningState?: ResourceProvisioningState;

  @doc("The id of a Footprint measurement endpoint condition.")
  @visibility("read")
  @minLength(32)
  @maxLength(32)
  @pattern("[a-f0-9]{32}")
  conditionId?: string;

  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-duplicate-property"
  @doc("The type of a Footprint measurement endpoint condition.")
  type: Type;

  @doc("The variable of a Footprint measurement endpoint condition.")
  variable: string;

  @doc("The operator of a Footprint measurement endpoint condition.")
  operator: Operator;

  @doc("The constant of a Footprint measurement endpoint condition.")
  constant: string;
}

@doc("A model representing the Footprint experiment.")
@parentResource(Profile)
model Experiment is ProxyResource<ExperimentProperties> {
  @doc("Name of the Footprint experiment resource.")
  @minLength(3)
  @maxLength(64)
  @pattern("^[a-zA-Z0-9]")
  @key("experimentName")
  @path
  @segment("experiments")
  name: string;
}

@doc("A model representing the Footprint Experiment resource.")
model ExperimentProperties {
  @doc("The status of the last operation.")
  @visibility("read")
  provisioningState?: ResourceProvisioningState;

  @doc("The id of a Footprint experiment.")
  @visibility("read")
  @minLength(32)
  @maxLength(32)
  @pattern("[a-f0-9]{32}")
  experimentId?: string;

  @doc("The description of a Footprint experiment.")
  description?: string;

  @doc("The status of a Footprint experiment.")
  @visibility("read")
  status?: string;
}

@doc("The type of a Footprint measurement endpoint condition.")
union Type {
  @doc("The condition is a RequestHeader.")
  RequestHeader: string,
}

@doc("The operator of a Footprint measurement endpoint condition.")
union Operator {
  @doc("The condition is an exact value.")
  IsExactValue: "IsExactValue",

  @doc("The condition is a match value ignore casing.")
  MatchValueIgnoreCasing: "MatchValueIgnoreCasing",

  @doc("The condition is a contains value.")
  ContainsValue: "ContainsValue",

  @doc("The condition is a contains value ignore casing.")
  ContainsValueIgnoreCasing: "ContainsValueIgnoreCasing",

  @doc("The condition is a does not contain value.")
  DoesNotContainValue: "DoesNotContainValue",

  @doc("The condition is a does not contain value ignore casing.")
  DoesNotContainValueIgnoreCasing: "DoesNotContainValueIgnoreCasing",

  string,
}

interface Operations extends Azure.ResourceManager.Operations {}

@armResourceOperations
interface Profiles {
  get is ArmResourceRead<Profile>;
  createOrUpdate is ArmResourceCreateOrReplaceSync<Profile>;
  update is ArmResourcePatchSync<Profile, ProfileProperties>;
  delete is ArmResourceDeleteSync<Profile>;
  listByResourceGroup is ArmResourceListByParent<Profile>;
  listBySubscription is ArmListBySubscription<Profile>;
}

@armResourceOperations
interface MeasurementEndpoints {
  get is ArmResourceRead<MeasurementEndpoint>;
  createOrUpdate is ArmResourceCreateOrReplaceSync<MeasurementEndpoint>;
  delete is ArmResourceDeleteSync<MeasurementEndpoint>;
  listByResourceGroup is ArmResourceListByParent<MeasurementEndpoint>;
}

@armResourceOperations
interface MeasurementEndpointConditions {
  get is ArmResourceRead<MeasurementEndpointCondition>;
  createOrUpdate is ArmResourceCreateOrReplaceSync<MeasurementEndpointCondition>;
  delete is ArmResourceDeleteSync<MeasurementEndpointCondition>;
  listByResourceGroup is ArmResourceListByParent<MeasurementEndpointCondition>;
}

@armResourceOperations
interface Experiments {
  get is ArmResourceRead<Experiment>;
  createOrUpdate is ArmResourceCreateOrReplaceSync<Experiment>;
  delete is ArmResourceDeleteSync<Experiment>;
  listByResourceGroup is ArmResourceListByParent<Experiment>;
}
