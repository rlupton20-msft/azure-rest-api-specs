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

//---------------------------------------------- EmrClusters ----------------------------------------------
#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the name is defined in aws."
@about({
  displayNames: {
    singular: "EMR Cluster",
    plural: "EMR Clusters",
  },
  keywords: ["Microsoft.AwsConnector", "EMR", "Cluster"],
})
@doc("A Microsoft.AwsConnector resource")
model EmrCluster is TrackedResource<EmrClusterProperties> {
  @doc("Name of EmrCluster")
  @pattern("^(?=.{0,259}[^\\s.]$)(?!.*[<>%&\\?/#])")
  @key("name")
  @path
  @segment("emrClusters")
  name: string;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of EmrCluster")
model EmrClusterProperties {
  @doc("AWS Properties")
  awsProperties?: AwsEmrClusterProperties;

  ...AwsCommonProperties;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of awsEmrCluster")
model AwsEmrClusterProperties {
  @doc("Property additionalInfo")
  additionalInfo?: unknown;

  @doc("Property applications")
  @extension("x-ms-identifiers", [])
  applications?: Application[];

  @doc("Property autoScalingRole")
  autoScalingRole?: string;

  @doc("Property autoTerminationPolicy")
  autoTerminationPolicy?: AutoTerminationPolicy;

  @doc("Property bootstrapActions")
  @extension("x-ms-identifiers", [])
  bootstrapActions?: BootstrapActionConfig[];

  @doc("Property configurations")
  @extension("x-ms-identifiers", [])
  configurations?: Configuration[];

  @doc("Property customAmiId")
  customAmiId?: string;

  @doc("Property ebsRootVolumeIops")
  ebsRootVolumeIops?: int32;

  @doc("Property ebsRootVolumeSize")
  ebsRootVolumeSize?: int32;

  @doc("Property ebsRootVolumeThroughput")
  ebsRootVolumeThroughput?: int32;

  @doc("Property id")
  id?: string;

  @doc("Property instances")
  instances?: JobFlowInstancesConfig;

  @doc("Property jobFlowRole")
  jobFlowRole?: string;

  @doc("Property kerberosAttributes")
  kerberosAttributes?: KerberosAttributes;

  @doc("Property logEncryptionKmsKeyId")
  logEncryptionKmsKeyId?: string;

  @doc("Property logUri")
  logUri?: string;

  @doc("Property managedScalingPolicy")
  managedScalingPolicy?: ManagedScalingPolicy;

  @doc("Property masterPublicDNS")
  masterPublicDNS?: string;

  @doc("Property name")
  name?: string;

  @doc("Property osReleaseLabel")
  osReleaseLabel?: string;

  @doc("Property placementGroupConfigs")
  @extension("x-ms-identifiers", [])
  placementGroupConfigs?: PlacementGroupConfig[];

  @doc("Property releaseLabel")
  releaseLabel?: string;

  @doc("Property scaleDownBehavior")
  scaleDownBehavior?: string;

  @doc("Property securityConfiguration")
  securityConfiguration?: string;

  @doc("Property serviceRole")
  serviceRole?: string;

  @doc("Property stepConcurrencyLevel")
  stepConcurrencyLevel?: int32;

  @doc("Property steps")
  @extension("x-ms-identifiers", [])
  steps?: StepConfig[];

  @doc("Property tags")
  @extension("x-ms-identifiers", [])
  tags?: Tag[];

  @doc("Property visibleToAllUsers")
  visibleToAllUsers?: boolean;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of Application")
model Application {
  @doc("Property additionalInfo")
  additionalInfo?: Record<string>;

  @doc("Property args")
  @extension("x-ms-identifiers", [])
  args?: string[];

  @doc("Property name")
  name?: string;

  @doc("Property version")
  version?: string;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of AutoTerminationPolicy")
model AutoTerminationPolicy {
  @doc("Property idleTimeout")
  idleTimeout?: int32;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of BootstrapActionConfig")
model BootstrapActionConfig {
  @doc("Property name")
  name?: string;

  @doc("Property scriptBootstrapAction")
  scriptBootstrapAction?: ScriptBootstrapActionConfig;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of Configuration")
model Configuration {
  @doc("Property classification")
  classification?: string;

  @doc("Property configurationProperties")
  configurationProperties?: Record<string>;

  @doc("Property configurations")
  @extension("x-ms-identifiers", [])
  configurations?: Configuration[];
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of JobFlowInstancesConfig")
model JobFlowInstancesConfig {
  @doc("Property additionalMasterSecurityGroups")
  @extension("x-ms-identifiers", [])
  additionalMasterSecurityGroups?: string[];

  @doc("Property additionalSlaveSecurityGroups")
  @extension("x-ms-identifiers", [])
  additionalSlaveSecurityGroups?: string[];

  @doc("Property coreInstanceFleet")
  coreInstanceFleet?: InstanceFleetConfig;

  @doc("Property coreInstanceGroup")
  coreInstanceGroup?: InstanceGroupConfig;

  @doc("Property ec2KeyName")
  ec2KeyName?: string;

  @doc("Property ec2SubnetId")
  ec2SubnetId?: string;

  @doc("Property ec2SubnetIds")
  @extension("x-ms-identifiers", [])
  ec2SubnetIds?: string[];

  @doc("Property emrManagedMasterSecurityGroup")
  emrManagedMasterSecurityGroup?: string;

  @doc("Property emrManagedSlaveSecurityGroup")
  emrManagedSlaveSecurityGroup?: string;

  @doc("Property hadoopVersion")
  hadoopVersion?: string;

  @doc("Property keepJobFlowAliveWhenNoSteps")
  keepJobFlowAliveWhenNoSteps?: boolean;

  @doc("Property masterInstanceFleet")
  masterInstanceFleet?: InstanceFleetConfig;

  @doc("Property masterInstanceGroup")
  masterInstanceGroup?: InstanceGroupConfig;

  @doc("Property placement")
  placement?: PlacementType;

  @doc("Property serviceAccessSecurityGroup")
  serviceAccessSecurityGroup?: string;

  @doc("Property taskInstanceFleets")
  @extension("x-ms-identifiers", [])
  taskInstanceFleets?: InstanceFleetConfig[];

  @doc("Property taskInstanceGroups")
  @extension("x-ms-identifiers", [])
  taskInstanceGroups?: InstanceGroupConfig[];

  @doc("Property terminationProtected")
  terminationProtected?: boolean;

  @doc("Property unhealthyNodeReplacement")
  unhealthyNodeReplacement?: boolean;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of KerberosAttributes")
model KerberosAttributes {
  @doc("Property adDomainJoinPassword")
  adDomainJoinPassword?: string;

  @doc("Property adDomainJoinUser")
  adDomainJoinUser?: string;

  @doc("Property crossRealmTrustPrincipalPassword")
  crossRealmTrustPrincipalPassword?: string;

  @doc("Property kdcAdminPassword")
  kdcAdminPassword?: string;

  @doc("Property realm")
  realm?: string;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of ManagedScalingPolicy")
model ManagedScalingPolicy {
  @doc("Property computeLimits")
  computeLimits?: ComputeLimits;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of PlacementGroupConfig")
model PlacementGroupConfig {
  @doc("Property instanceRole")
  instanceRole?: string;

  @doc("Property placementStrategy")
  placementStrategy?: string;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of StepConfig")
model StepConfig {
  @doc("Property actionOnFailure")
  actionOnFailure?: string;

  @doc("Property hadoopJarStep")
  hadoopJarStep?: HadoopJarStepConfig;

  @doc("Property name")
  name?: string;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of Tag")
model Tag {
  @doc("Property key")
  key?: string;

  @doc("Property value")
  value?: string;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of ScriptBootstrapActionConfig")
model ScriptBootstrapActionConfig {
  @doc("Property args")
  @extension("x-ms-identifiers", [])
  args?: string[];

  @doc("Property path")
  path?: string;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of InstanceFleetConfig")
model InstanceFleetConfig {
  @doc("Property instanceTypeConfigs")
  @extension("x-ms-identifiers", [])
  instanceTypeConfigs?: InstanceTypeConfig[];

  @doc("Property launchSpecifications")
  launchSpecifications?: InstanceFleetProvisioningSpecifications;

  @doc("Property name")
  name?: string;

  @doc("Property targetOnDemandCapacity")
  targetOnDemandCapacity?: int32;

  @doc("Property targetSpotCapacity")
  targetSpotCapacity?: int32;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of InstanceGroupConfig")
model InstanceGroupConfig {
  @doc("Property autoScalingPolicy")
  autoScalingPolicy?: AutoScalingPolicy;

  @doc("Property bidPrice")
  bidPrice?: string;

  @doc("Property configurations")
  @extension("x-ms-identifiers", [])
  configurations?: Configuration[];

  @doc("Property customAmiId")
  customAmiId?: string;

  @doc("Property ebsConfiguration")
  ebsConfiguration?: EbsConfiguration;

  @doc("Property instanceCount")
  instanceCount?: int32;

  @doc("Property instanceType")
  instanceType?: string;

  @doc("Property market")
  market?: string;

  @doc("Property name")
  name?: string;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of PlacementType")
model PlacementType {
  @doc("Property availabilityZone")
  availabilityZone?: string;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of ComputeLimits")
model ComputeLimits {
  @doc("Property maximumCapacityUnits")
  maximumCapacityUnits?: int32;

  @doc("Property maximumCoreCapacityUnits")
  maximumCoreCapacityUnits?: int32;

  @doc("Property maximumOnDemandCapacityUnits")
  maximumOnDemandCapacityUnits?: int32;

  @doc("Property minimumCapacityUnits")
  minimumCapacityUnits?: int32;

  @doc("Property unitType")
  unitType?: string;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of HadoopJarStepConfig")
model HadoopJarStepConfig {
  @doc("Property args")
  @extension("x-ms-identifiers", [])
  args?: string[];

  @doc("Property jar")
  jar?: string;

  @doc("Property mainClass")
  mainClass?: string;

  @doc("Property stepProperties")
  @extension("x-ms-identifiers", [])
  stepProperties?: KeyValue[];
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of InstanceTypeConfig")
model InstanceTypeConfig {
  @doc("Property bidPrice")
  bidPrice?: string;

  @doc("Property bidPriceAsPercentageOfOnDemandPrice")
  bidPriceAsPercentageOfOnDemandPrice?: int32;

  @doc("Property configurations")
  @extension("x-ms-identifiers", [])
  configurations?: Configuration[];

  @doc("Property customAmiId")
  customAmiId?: string;

  @doc("Property ebsConfiguration")
  ebsConfiguration?: EbsConfiguration;

  @doc("Property instanceType")
  instanceType?: string;

  @doc("Property weightedCapacity")
  weightedCapacity?: int32;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of InstanceFleetProvisioningSpecifications")
model InstanceFleetProvisioningSpecifications {
  @doc("Property onDemandSpecification")
  onDemandSpecification?: OnDemandProvisioningSpecification;

  @doc("Property spotSpecification")
  spotSpecification?: SpotProvisioningSpecification;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of AutoScalingPolicy")
model AutoScalingPolicy {
  @doc("Property constraints")
  constraints?: ScalingConstraints;

  @doc("Property rules")
  @extension("x-ms-identifiers", [])
  rules?: ScalingRule[];
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of EbsConfiguration")
model EbsConfiguration {
  @doc("Property ebsBlockDeviceConfigs")
  @extension("x-ms-identifiers", [])
  ebsBlockDeviceConfigs?: EbsBlockDeviceConfig[];

  @doc("Property ebsOptimized")
  ebsOptimized?: boolean;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of KeyValue")
model KeyValue {
  @doc("Property key")
  key?: string;

  @doc("Property value")
  value?: string;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of OnDemandProvisioningSpecification")
model OnDemandProvisioningSpecification {
  @doc("Property allocationStrategy")
  allocationStrategy?: string;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of SpotProvisioningSpecification")
model SpotProvisioningSpecification {
  @doc("Property allocationStrategy")
  allocationStrategy?: string;

  @doc("Property blockDurationMinutes")
  blockDurationMinutes?: int32;

  @doc("Property timeoutAction")
  timeoutAction?: string;

  @doc("Property timeoutDurationMinutes")
  timeoutDurationMinutes?: int32;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of ScalingConstraints")
model ScalingConstraints {
  @doc("Property maxCapacity")
  maxCapacity?: int32;

  @doc("Property minCapacity")
  minCapacity?: int32;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of ScalingRule")
model ScalingRule {
  @doc("Property action")
  action?: ScalingAction;

  @doc("Property description")
  description?: string;

  @doc("Property name")
  name?: string;

  @doc("Property trigger")
  trigger?: ScalingTrigger;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of EbsBlockDeviceConfig")
model EbsBlockDeviceConfig {
  @doc("Property volumeSpecification")
  volumeSpecification?: VolumeSpecification;

  @doc("Property volumesPerInstance")
  volumesPerInstance?: int32;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of ScalingAction")
model ScalingAction {
  @doc("Property market")
  market?: string;

  @doc("Property simpleScalingPolicyConfiguration")
  simpleScalingPolicyConfiguration?: SimpleScalingPolicyConfiguration;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of ScalingTrigger")
model ScalingTrigger {
  @doc("Property cloudWatchAlarmDefinition")
  cloudWatchAlarmDefinition?: CloudWatchAlarmDefinition;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of VolumeSpecification")
model VolumeSpecification {
  @doc("Property iops")
  iops?: int32;

  @doc("Property sizeInGB")
  sizeInGB?: int32;

  @doc("Property throughput")
  throughput?: int32;

  @doc("Property volumeType")
  volumeType?: string;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of SimpleScalingPolicyConfiguration")
model SimpleScalingPolicyConfiguration {
  @doc("Property adjustmentType")
  adjustmentType?: string;

  @doc("Property coolDown")
  coolDown?: int32;

  @doc("Property scalingAdjustment")
  scalingAdjustment?: int32;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of CloudWatchAlarmDefinition")
model CloudWatchAlarmDefinition {
  @doc("Property comparisonOperator")
  comparisonOperator?: string;

  @doc("Property dimensions")
  @extension("x-ms-identifiers", [])
  dimensions?: MetricDimension[];

  @doc("Property evaluationPeriods")
  evaluationPeriods?: int32;

  @doc("Property metricName")
  metricName?: string;

  @doc("Property `namespace`")
  `namespace`?: string;

  @doc("Property period")
  period?: int32;

  @doc("Property statistic")
  statistic?: string;

  @doc("Property threshold")
  threshold?: int32;

  @doc("Property unit")
  unit?: string;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of MetricDimension")
model MetricDimension {
  @doc("Property key")
  key?: string;

  @doc("Property value")
  value?: string;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the name is defined in aws."
@armResourceOperations
interface EmrClusters {
  get is ArmResourceRead<EmrCluster>;
  @doc("Create a EmrCluster. Please note that end user resource creation is currently restricted, but it will be enabled in the future.")
  createOrUpdate is ArmResourceCreateOrUpdateAsync<EmrCluster>;
  update is ArmCustomPatchAsync<
    EmrCluster,
    Azure.ResourceManager.Foundations.TagsUpdateModel<EmrCluster>
  >;
  delete is ArmResourceDeleteWithoutOkAsync<EmrCluster>;
  listByResourceGroup is ArmResourceListByParent<EmrCluster>;
  listBySubscription is ArmListBySubscription<EmrCluster>;
}

//--------------------------------------------------------------------------------------------
// This TypeSpec was auto genrated by aws2SwaggerMain.js tool
//
// Input used to generate TypeSpec:
// Cloud Control API Type: AWS::EMR::Cluster
//--------------------------------------------------------------------------------------------
