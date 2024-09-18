import "@typespec/http";
import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@azure-tools/typespec-client-generator-core";
import "@typespec/openapi";
import "@azure-tools/typespec-azure-portal-core";
import "../shared/main.tsp";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using OpenAPI;
using Azure.Core;
using Azure.ClientGenerator.Core;
using Azure.ResourceManager;
using Azure.Portal;

#suppress "@azure-tools/typespec-azure-resource-manager/missing-operations-endpoint" "Supress missing operations endpoint as the same is defined ../operations/main.tsp."
@armProviderNamespace
@service({
  title: "Microsoft.AwsConnector",
})
@doc("Microsoft.AwsConnector Resource Provider management API.")
@versioned(Versions)
@armCommonTypesVersion(Azure.ResourceManager.CommonTypes.Versions.v5)
namespace Microsoft.AwsConnector;

/** Api versions */
enum Versions {
  /** 2024-12-01 api version */
  @useDependency(Azure.ResourceManager.Versions.v1_0_Preview_1)
  `2024-12-01`,
}

//---------------------------------------------- ConfigConfigurationRecorders ----------------------------------------------
#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the name is defined in aws."
@about({
  displayNames: {
    singular: "Config Configuration Recorder",
    plural: "Config Configuration Recorders",
  },
  keywords: ["Microsoft.AwsConnector", "Config", "Configuration", "Recorder"],
})
@doc("A Microsoft.AwsConnector resource")
model ConfigConfigurationRecorder
  is TrackedResource<ConfigConfigurationRecorderProperties> {
  @doc("Name of ConfigConfigurationRecorder")
  @pattern("^(?=.{0,259}[^\\s.]$)(?!.*[<>%&\\?/#])")
  @key("name")
  @path
  @segment("configConfigurationRecorders")
  name: string;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of ConfigConfigurationRecorder")
model ConfigConfigurationRecorderProperties {
  @doc("AWS Properties")
  awsProperties?: AwsConfigConfigurationRecorderProperties;

  ...AwsCommonProperties;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of awsConfigConfigurationRecorder")
model AwsConfigConfigurationRecorderProperties {
  @doc("Property id")
  id?: string;

  @doc("Property name")
  name?: string;

  @doc("Property recordingGroup")
  recordingGroup?: RecordingGroup;

  @doc("Property recordingMode")
  recordingMode?: RecordingMode;

  @doc("Property roleARN")
  roleARN?: string;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of RecordingGroup")
model RecordingGroup {
  @doc("Property allSupported")
  allSupported?: boolean;

  @doc("Property exclusionByResourceTypes")
  exclusionByResourceTypes?: ExclusionByResourceTypes;

  @doc("Property includeGlobalResourceTypes")
  includeGlobalResourceTypes?: boolean;

  @doc("Property recordingStrategy")
  recordingStrategy?: RecordingStrategy;

  @doc("Property resourceTypes")
  @extension("x-ms-identifiers", [])
  resourceTypes?: string[];
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of RecordingMode")
model RecordingMode {
  @doc("Property recordingFrequency")
  recordingFrequency?: string;

  @doc("Property recordingModeOverrides")
  @extension("x-ms-identifiers", [])
  recordingModeOverrides?: RecordingModeOverride[];
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of ExclusionByResourceTypes")
model ExclusionByResourceTypes {
  @doc("Property resourceTypes")
  @extension("x-ms-identifiers", [])
  resourceTypes?: string[];
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of RecordingStrategy")
model RecordingStrategy {
  @doc("Property useOnly")
  useOnly?: string;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of RecordingModeOverride")
model RecordingModeOverride {
  @doc("Property description")
  description?: string;

  @doc("Property recordingFrequency")
  recordingFrequency?: string;

  @doc("Property resourceTypes")
  @extension("x-ms-identifiers", [])
  resourceTypes?: string[];
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the name is defined in aws."
@armResourceOperations
interface ConfigConfigurationRecorders {
  get is ArmResourceRead<ConfigConfigurationRecorder>;
  @doc("Create a ConfigConfigurationRecorder. Please note that end user resource creation is currently restricted, but it will be enabled in the future.")
  createOrUpdate is ArmResourceCreateOrUpdateAsync<ConfigConfigurationRecorder>;
  update is ArmCustomPatchAsync<
    ConfigConfigurationRecorder,
    Azure.ResourceManager.Foundations.TagsUpdateModel<ConfigConfigurationRecorder>
  >;
  delete is ArmResourceDeleteWithoutOkAsync<ConfigConfigurationRecorder>;
  listByResourceGroup is ArmResourceListByParent<ConfigConfigurationRecorder>;
  listBySubscription is ArmListBySubscription<ConfigConfigurationRecorder>;
}

//--------------------------------------------------------------------------------------------
// This TypeSpec was auto genrated by aws2SwaggerMain.js tool
//
// Input used to generate TypeSpec:
// Cloud Control API Type: AWS::Config::ConfigurationRecorder
//--------------------------------------------------------------------------------------------
