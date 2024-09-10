# awsconnector

> see https://aka.ms/autorest

This is the AutoRest configuration file for awsconnector.

## Getting Started

To build the SDKs for My API, simply install AutoRest via `npm` (`npm install -g autorest`) and then run:

> `autorest readme.md`

To see additional help and options, run:

> `autorest --help`

For other options on installation see [Installing AutoRest](https://aka.ms/autorest/install) on the AutoRest github page.

---

## Configuration

### Basic Information

These are the global settings for the awsconnector.

```yaml
openapi-type: arm
openapi-subtype: rpaas
tag: package-2024-12-01
```

### Tag: package-2023-12-01-preview

These settings apply only when `--tag=package-2023-12-01-preview` is specified on the command line.

``` yaml $(tag) == 'package-2023-12-01-preview'
input-file:
  - Microsoft.AwsConnector/preview/2023-12-01-preview/ec2Instance.json
  - Microsoft.AwsConnector/preview/2023-12-01-preview/lambdaFunctionConfiguration.json
  - Microsoft.AwsConnector/preview/2023-12-01-preview/operations.json
  - Microsoft.AwsConnector/preview/2023-12-01-preview/s3Bucket.json
```

### Tag: package-2024-08-01-preview

These settings apply only when `--tag=package-2024-08-01-preview` is specified on the command line.

``` yaml $(tag) == 'package-2024-08-01-preview'
input-file:
  - Microsoft.AwsConnector/preview/2024-08-01-preview/apiGatewayRestApi.json
  - Microsoft.AwsConnector/preview/2024-08-01-preview/apiGatewayStage.json
  - Microsoft.AwsConnector/preview/2024-08-01-preview/applicationAutoScalingScalableTarget.json
  - Microsoft.AwsConnector/preview/2024-08-01-preview/cloudFormationStack.json
  - Microsoft.AwsConnector/preview/2024-08-01-preview/cloudFormationStackSet.json
  - Microsoft.AwsConnector/preview/2024-08-01-preview/cloudTrailTrail.json
  - Microsoft.AwsConnector/preview/2024-08-01-preview/cloudWatchAlarm.json
  - Microsoft.AwsConnector/preview/2024-08-01-preview/dynamoDBTable.json
  - Microsoft.AwsConnector/preview/2024-08-01-preview/ec2Instance.json
  - Microsoft.AwsConnector/preview/2024-08-01-preview/ec2InstanceStatus.json
  - Microsoft.AwsConnector/preview/2024-08-01-preview/ec2KeyPair.json
  - Microsoft.AwsConnector/preview/2024-08-01-preview/ec2NetworkAcl.json
  - Microsoft.AwsConnector/preview/2024-08-01-preview/ec2NetworkInterface.json
  - Microsoft.AwsConnector/preview/2024-08-01-preview/ec2RouteTable.json
  - Microsoft.AwsConnector/preview/2024-08-01-preview/ec2SecurityGroup.json
  - Microsoft.AwsConnector/preview/2024-08-01-preview/ec2Subnet.json
  - Microsoft.AwsConnector/preview/2024-08-01-preview/ec2Volume.json
  - Microsoft.AwsConnector/preview/2024-08-01-preview/ec2Vpc.json
  - Microsoft.AwsConnector/preview/2024-08-01-preview/ec2VPCEndpoint.json
  - Microsoft.AwsConnector/preview/2024-08-01-preview/ec2VPCPeeringConnection.json
  - Microsoft.AwsConnector/preview/2024-08-01-preview/ecrRepository.json
  - Microsoft.AwsConnector/preview/2024-08-01-preview/ecsCluster.json
  - Microsoft.AwsConnector/preview/2024-08-01-preview/ecsService.json
  - Microsoft.AwsConnector/preview/2024-08-01-preview/ecsTaskDefinition.json
  - Microsoft.AwsConnector/preview/2024-08-01-preview/efsFileSystem.json
  - Microsoft.AwsConnector/preview/2024-08-01-preview/efsMountTarget.json
  - Microsoft.AwsConnector/preview/2024-08-01-preview/eksCluster.json
  - Microsoft.AwsConnector/preview/2024-08-01-preview/eksNodegroup.json
  - Microsoft.AwsConnector/preview/2024-08-01-preview/elasticBeanstalkEnvironment.json
  - Microsoft.AwsConnector/preview/2024-08-01-preview/elasticLoadBalancingV2Listener.json
  - Microsoft.AwsConnector/preview/2024-08-01-preview/elasticLoadBalancingV2LoadBalancer.json
  - Microsoft.AwsConnector/preview/2024-08-01-preview/elasticLoadBalancingV2TargetGroup.json
  - Microsoft.AwsConnector/preview/2024-08-01-preview/elasticsearchDomain.json
  - Microsoft.AwsConnector/preview/2024-08-01-preview/guardDutyDetector.json
  - Microsoft.AwsConnector/preview/2024-08-01-preview/iamGroup.json
  - Microsoft.AwsConnector/preview/2024-08-01-preview/iamInstanceProfile.json
  - Microsoft.AwsConnector/preview/2024-08-01-preview/iamManagedPolicy.json
  - Microsoft.AwsConnector/preview/2024-08-01-preview/iamServerCertificate.json
  - Microsoft.AwsConnector/preview/2024-08-01-preview/iamUserPolicy.json
  - Microsoft.AwsConnector/preview/2024-08-01-preview/iamVirtualMFADevice.json
  - Microsoft.AwsConnector/preview/2024-08-01-preview/kmsKey.json
  - Microsoft.AwsConnector/preview/2024-08-01-preview/lambdaFunction.json
  - Microsoft.AwsConnector/preview/2024-08-01-preview/licenseManagerLicense.json
  - Microsoft.AwsConnector/preview/2024-08-01-preview/lightsailBucket.json
  - Microsoft.AwsConnector/preview/2024-08-01-preview/lightsailInstance.json
  - Microsoft.AwsConnector/preview/2024-08-01-preview/logsLogGroup.json
  - Microsoft.AwsConnector/preview/2024-08-01-preview/logsLogStream.json
  - Microsoft.AwsConnector/preview/2024-08-01-preview/logsMetricFilter.json
  - Microsoft.AwsConnector/preview/2024-08-01-preview/logsSubscriptionFilter.json
  - Microsoft.AwsConnector/preview/2024-08-01-preview/macieAllowList.json
  - Microsoft.AwsConnector/preview/2024-08-01-preview/networkFirewallFirewall.json
  - Microsoft.AwsConnector/preview/2024-08-01-preview/networkFirewallFirewallPolicy.json
  - Microsoft.AwsConnector/preview/2024-08-01-preview/networkFirewallRuleGroup.json
  - Microsoft.AwsConnector/preview/2024-08-01-preview/openSearchServiceDomain.json
  - Microsoft.AwsConnector/preview/2024-08-01-preview/operations.json
  - Microsoft.AwsConnector/preview/2024-08-01-preview/organizationsAccount.json
  - Microsoft.AwsConnector/preview/2024-08-01-preview/organizationsOrganization.json
  - Microsoft.AwsConnector/preview/2024-08-01-preview/rdsDBCluster.json
  - Microsoft.AwsConnector/preview/2024-08-01-preview/rdsDBInstance.json
  - Microsoft.AwsConnector/preview/2024-08-01-preview/rdsEventSubscription.json
  - Microsoft.AwsConnector/preview/2024-08-01-preview/redshiftCluster.json
  - Microsoft.AwsConnector/preview/2024-08-01-preview/redshiftClusterParameterGroup.json
  - Microsoft.AwsConnector/preview/2024-08-01-preview/route53HostedZone.json
  - Microsoft.AwsConnector/preview/2024-08-01-preview/s3AccessPoint.json
  - Microsoft.AwsConnector/preview/2024-08-01-preview/s3Bucket.json
  - Microsoft.AwsConnector/preview/2024-08-01-preview/s3BucketPolicy.json
  - Microsoft.AwsConnector/preview/2024-08-01-preview/sageMakerApp.json
  - Microsoft.AwsConnector/preview/2024-08-01-preview/sageMakerDevice.json
  - Microsoft.AwsConnector/preview/2024-08-01-preview/sageMakerImage.json
  - Microsoft.AwsConnector/preview/2024-08-01-preview/snsTopic.json
  - Microsoft.AwsConnector/preview/2024-08-01-preview/sqsQueue.json
  - Microsoft.AwsConnector/preview/2024-08-01-preview/wafv2IPSet.json
  - Microsoft.AwsConnector/preview/2024-08-01-preview/wafv2WebACLAssociation.json
```

### Tag: package-2024-12-01

These settings apply only when `--tag=package-2024-12-01` is specified on the command line.

``` yaml $(tag) == 'package-2024-12-01'
input-file:
  - Microsoft.AwsConnector/stable/2024-12-01/accessAnalyzerAnalyzer.json
  - Microsoft.AwsConnector/stable/2024-12-01/acmCertificateSummary.json
  - Microsoft.AwsConnector/stable/2024-12-01/apiGatewayRestApi.json
  - Microsoft.AwsConnector/stable/2024-12-01/apiGatewayStage.json
  - Microsoft.AwsConnector/stable/2024-12-01/applicationAutoScalingScalableTarget.json
  - Microsoft.AwsConnector/stable/2024-12-01/autoScalingAutoScalingGroup.json
  - Microsoft.AwsConnector/stable/2024-12-01/certificateManagerCertificate.json
  - Microsoft.AwsConnector/stable/2024-12-01/cloudFormationStack.json
  - Microsoft.AwsConnector/stable/2024-12-01/cloudFormationStackSet.json
  - Microsoft.AwsConnector/stable/2024-12-01/cloudTrailTrail.json
  - Microsoft.AwsConnector/stable/2024-12-01/cloudWatchAlarm.json
  - Microsoft.AwsConnector/stable/2024-12-01/codeBuildProject.json
  - Microsoft.AwsConnector/stable/2024-12-01/codeBuildSourceCredential.json
  - Microsoft.AwsConnector/stable/2024-12-01/codeBuildSourceCredentialsInfo.json
  - Microsoft.AwsConnector/stable/2024-12-01/databaseMigrationServiceReplicationInstance.json
  - Microsoft.AwsConnector/stable/2024-12-01/daxCluster.json
  - Microsoft.AwsConnector/stable/2024-12-01/dmsReplicationInstance.json
  - Microsoft.AwsConnector/stable/2024-12-01/dynamoDBContinuousBackupsDescription.json
  - Microsoft.AwsConnector/stable/2024-12-01/dynamoDBTable.json
  - Microsoft.AwsConnector/stable/2024-12-01/ec2AccountAttribute.json
  - Microsoft.AwsConnector/stable/2024-12-01/ec2Address.json
  - Microsoft.AwsConnector/stable/2024-12-01/ec2CreateVolumePermission.json
  - Microsoft.AwsConnector/stable/2024-12-01/ec2FlowLog.json
  - Microsoft.AwsConnector/stable/2024-12-01/ec2Image.json
  - Microsoft.AwsConnector/stable/2024-12-01/ec2Instance.json
  - Microsoft.AwsConnector/stable/2024-12-01/ec2InstanceStatus.json
  - Microsoft.AwsConnector/stable/2024-12-01/ec2InstanceTypeInfo.json
  - Microsoft.AwsConnector/stable/2024-12-01/ec2Ipam.json
  - Microsoft.AwsConnector/stable/2024-12-01/ec2KeyPair.json
  - Microsoft.AwsConnector/stable/2024-12-01/ec2NetworkAcl.json
  - Microsoft.AwsConnector/stable/2024-12-01/ec2NetworkInterface.json
  - Microsoft.AwsConnector/stable/2024-12-01/ec2RouteTable.json
  - Microsoft.AwsConnector/stable/2024-12-01/ec2SecurityGroup.json
  - Microsoft.AwsConnector/stable/2024-12-01/ec2Snapshot.json
  - Microsoft.AwsConnector/stable/2024-12-01/ec2Subnet.json
  - Microsoft.AwsConnector/stable/2024-12-01/ec2Volume.json
  - Microsoft.AwsConnector/stable/2024-12-01/ec2Vpc.json
  - Microsoft.AwsConnector/stable/2024-12-01/ec2VPCEndpoint.json
  - Microsoft.AwsConnector/stable/2024-12-01/ec2VPCPeeringConnection.json
  - Microsoft.AwsConnector/stable/2024-12-01/ecrRepository.json
  - Microsoft.AwsConnector/stable/2024-12-01/ecsCluster.json
  - Microsoft.AwsConnector/stable/2024-12-01/ecsService.json
  - Microsoft.AwsConnector/stable/2024-12-01/ecsTaskDefinition.json
  - Microsoft.AwsConnector/stable/2024-12-01/efsFileSystem.json
  - Microsoft.AwsConnector/stable/2024-12-01/efsMountTarget.json
  - Microsoft.AwsConnector/stable/2024-12-01/eksCluster.json
  - Microsoft.AwsConnector/stable/2024-12-01/eksNodegroup.json
  - Microsoft.AwsConnector/stable/2024-12-01/elasticBeanstalkApplication.json
  - Microsoft.AwsConnector/stable/2024-12-01/elasticBeanstalkConfigurationTemplate.json
  - Microsoft.AwsConnector/stable/2024-12-01/elasticBeanstalkEnvironment.json
  - Microsoft.AwsConnector/stable/2024-12-01/elasticLoadBalancingLoadBalancer.json
  - Microsoft.AwsConnector/stable/2024-12-01/elasticLoadBalancingV2Listener.json
  - Microsoft.AwsConnector/stable/2024-12-01/elasticLoadBalancingV2ListenerRule.json
  - Microsoft.AwsConnector/stable/2024-12-01/elasticLoadBalancingV2LoadBalancer.json
  - Microsoft.AwsConnector/stable/2024-12-01/elasticLoadBalancingV2TargetGroup.json
  - Microsoft.AwsConnector/stable/2024-12-01/elasticsearchDomain.json
  - Microsoft.AwsConnector/stable/2024-12-01/emrCluster.json
  - Microsoft.AwsConnector/stable/2024-12-01/emrClusterSummary.json
  - Microsoft.AwsConnector/stable/2024-12-01/guardDutyDetector.json
  - Microsoft.AwsConnector/stable/2024-12-01/iamAccessKey.json
  - Microsoft.AwsConnector/stable/2024-12-01/iamAccessKeyLastUsed.json
  - Microsoft.AwsConnector/stable/2024-12-01/iamGroup.json
  - Microsoft.AwsConnector/stable/2024-12-01/iamGroupPolicy.json
  - Microsoft.AwsConnector/stable/2024-12-01/iamInstanceProfile.json
  - Microsoft.AwsConnector/stable/2024-12-01/iamManagedPolicy.json
  - Microsoft.AwsConnector/stable/2024-12-01/iamPasswordPolicy.json
  - Microsoft.AwsConnector/stable/2024-12-01/iamPolicyGroup.json
  - Microsoft.AwsConnector/stable/2024-12-01/iamPolicyRole.json
  - Microsoft.AwsConnector/stable/2024-12-01/iamPolicyUser.json
  - Microsoft.AwsConnector/stable/2024-12-01/iamPolicyVersion.json
  - Microsoft.AwsConnector/stable/2024-12-01/iamRole.json
  - Microsoft.AwsConnector/stable/2024-12-01/iamRolePolicy.json
  - Microsoft.AwsConnector/stable/2024-12-01/iamServerCertificate.json
  - Microsoft.AwsConnector/stable/2024-12-01/iamUser.json
  - Microsoft.AwsConnector/stable/2024-12-01/iamUserPolicy.json
  - Microsoft.AwsConnector/stable/2024-12-01/iamVirtualMFADevice.json
  - Microsoft.AwsConnector/stable/2024-12-01/kmsAlias.json
  - Microsoft.AwsConnector/stable/2024-12-01/kmsKey.json
  - Microsoft.AwsConnector/stable/2024-12-01/lambdaFunction.json
  - Microsoft.AwsConnector/stable/2024-12-01/licenseManagerLicense.json
  - Microsoft.AwsConnector/stable/2024-12-01/lightsailBucket.json
  - Microsoft.AwsConnector/stable/2024-12-01/lightsailInstance.json
  - Microsoft.AwsConnector/stable/2024-12-01/logsLogGroup.json
  - Microsoft.AwsConnector/stable/2024-12-01/logsLogStream.json
  - Microsoft.AwsConnector/stable/2024-12-01/logsMetricFilter.json
  - Microsoft.AwsConnector/stable/2024-12-01/logsSubscriptionFilter.json
  - Microsoft.AwsConnector/stable/2024-12-01/macie2JobSummary.json
  - Microsoft.AwsConnector/stable/2024-12-01/macieAllowList.json
  - Microsoft.AwsConnector/stable/2024-12-01/networkFirewallFirewall.json
  - Microsoft.AwsConnector/stable/2024-12-01/networkFirewallFirewallPolicy.json
  - Microsoft.AwsConnector/stable/2024-12-01/networkFirewallRuleGroup.json
  - Microsoft.AwsConnector/stable/2024-12-01/openSearchServiceDomain.json
  - Microsoft.AwsConnector/stable/2024-12-01/operations.json
  - Microsoft.AwsConnector/stable/2024-12-01/organizationsAccount.json
  - Microsoft.AwsConnector/stable/2024-12-01/organizationsOrganization.json
  - Microsoft.AwsConnector/stable/2024-12-01/rdsDBCluster.json
  - Microsoft.AwsConnector/stable/2024-12-01/rdsDBInstance.json
  - Microsoft.AwsConnector/stable/2024-12-01/rdsDBSnapshotAttributesResult.json
  - Microsoft.AwsConnector/stable/2024-12-01/rdsEventSubscription.json
  - Microsoft.AwsConnector/stable/2024-12-01/rdsExportTask.json
  - Microsoft.AwsConnector/stable/2024-12-01/redshiftCluster.json
  - Microsoft.AwsConnector/stable/2024-12-01/redshiftClusterParameterGroup.json
  - Microsoft.AwsConnector/stable/2024-12-01/route53DomainsDomainSummary.json
  - Microsoft.AwsConnector/stable/2024-12-01/route53HostedZone.json
  - Microsoft.AwsConnector/stable/2024-12-01/route53RecordSet.json
  - Microsoft.AwsConnector/stable/2024-12-01/s3AccessPoint.json
  - Microsoft.AwsConnector/stable/2024-12-01/s3Bucket.json
  - Microsoft.AwsConnector/stable/2024-12-01/s3BucketPolicy.json
  - Microsoft.AwsConnector/stable/2024-12-01/s3MultiRegionAccessPointPolicy.json
  - Microsoft.AwsConnector/stable/2024-12-01/sageMakerApp.json
  - Microsoft.AwsConnector/stable/2024-12-01/sageMakerDevice.json
  - Microsoft.AwsConnector/stable/2024-12-01/sageMakerImage.json
  - Microsoft.AwsConnector/stable/2024-12-01/sageMakerNotebookInstance.json
  - Microsoft.AwsConnector/stable/2024-12-01/sageMakerNotebookInstanceSummary.json
  - Microsoft.AwsConnector/stable/2024-12-01/secretsManagerResourcePolicy.json
  - Microsoft.AwsConnector/stable/2024-12-01/secretsManagerSecret.json
  - Microsoft.AwsConnector/stable/2024-12-01/snsSubscription.json
  - Microsoft.AwsConnector/stable/2024-12-01/snsTopic.json
  - Microsoft.AwsConnector/stable/2024-12-01/sqsQueue.json
  - Microsoft.AwsConnector/stable/2024-12-01/ssmInstanceInformation.json
  - Microsoft.AwsConnector/stable/2024-12-01/ssmParameter.json
  - Microsoft.AwsConnector/stable/2024-12-01/ssmResourceComplianceSummaryItem.json
  - Microsoft.AwsConnector/stable/2024-12-01/wafv2IPSet.json
  - Microsoft.AwsConnector/stable/2024-12-01/wafv2LoggingConfiguration.json
  - Microsoft.AwsConnector/stable/2024-12-01/wafv2WebACLAssociation.json
  - Microsoft.AwsConnector/stable/2024-12-01/wafWebACL.json
  - Microsoft.AwsConnector/stable/2024-12-01/wafWebACLSummary.json
```

## Suppression

``` yaml
directive:
  - suppress: EnumInsteadOfBoolean
    reason: booleans are only used in aws
  - suppress: DefinitionsPropertiesNamesCamelCase
    reason: Property is CamelCase in aws
  - suppress: AvoidAdditionalProperties
    reason: 1. Property represents user defined awsTags. 2. All swagger has awsTags.So, we cannot add from clause.
  - suppress: PatchPropertiesCorrespondToPutProperties
    reason: 1. Issue in LintDiff tool. 2. In patch we allow tags update only and in our TypeSpec we use ArmCustomPatchAsync{Azure.ResourceManager.Foundations.TagsUpdateModel<Resource>}. So, tags property in patch body and the same is not present in the corresponding put body and causing the issue. In case of the put we are using TrackedResource type and same has tags. 3. All typespec has TagsUpdateModel.So, we cannot add from clause.
  - suppress: EvenSegmentedPathForPutOperation
    reason: 1. Issue in LintDiff tool. 2. In TypeSpec we use @singleton (OpenAPI path ends with /default), we believe this is a false positive.  Related issue:https://github.com/Azure/azure-openapi-validator/issues/646
    from:
      - ec2Instance.json
      - eksCluster.json
  - suppress: XmsPageableForListCalls
    reason: 1. Issue in LintDiff tool. 2. In TypeSpec we use @singleton (OpenAPI path ends with /default), we believe this is a false positive.  Related issue:https://github.com/Azure/azure-openapi-validator/issues/646
    from:
      - ec2Instance.json
      - eksCluster.json
  - suppress: TagsAreNotAllowedForProxyResources
    reason: Issue in LintDiff tool incorrectly flagging tracked resources. Related issue :https://github.com/Azure/azure-openapi-validator/issues/741
    from:
      - codeBuildSourceCredentialsInfo.json
      - daxCluster.json
      - iamAccessKeyLastUsed.json
      - iamPolicyGroup.json
      - iamPolicyRole.json
      - iamPolicyUser.json
      - sageMakerNotebookInstanceSummary.json
      - snsSubscription.json
  - suppress: BodyTopLevelProperties
    reason: Workaround for Known Issue BodyTopLevelProperties check is failing https://github.com/Azure/azure-openapi-validator/issues/722 
    from:
      - accessAnalyzerAnalyzer.json
      - acmCertificateSummary.json
      - apiGatewayRestApi.json
      - apiGatewayStage.json
      - applicationAutoScalingScalableTarget.json
      - autoScalingAutoScalingGroup.json
      - certificateManagerCertificate.json
      - cloudFormationStack.json
      - cloudFormationStackSet.json
      - cloudTrailTrail.json
      - cloudWatchAlarm.json
      - codeBuildProject.json
      - codeBuildSourceCredential.json
      - codeBuildSourceCredentialsInfo.json
      - databaseMigrationServiceReplicationInstance.json
      - daxCluster.json
      - dmsReplicationInstance.json
      - dynamoDBContinuousBackupsDescription.json
      - dynamoDBTable.json
      - ec2AccountAttribute.json
      - ec2Address.json
      - ec2CreateVolumePermission.json
      - ec2FlowLog.json
      - ec2Image.json
      - ec2Instance.json
      - ec2InstanceStatus.json
      - ec2InstanceTypeInfo.json
      - ec2Ipam.json
      - ec2KeyPair.json
      - ec2NetworkAcl.json
      - ec2NetworkInterface.json
      - ec2RouteTable.json
      - ec2SecurityGroup.json
      - ec2Snapshot.json
      - ec2Subnet.json
      - ec2Volume.json
      - ec2Vpc.json
      - ec2VPCEndpoint.json
      - ec2VPCPeeringConnection.json
      - ecrRepository.json
      - ecsCluster.json
      - ecsService.json
      - ecsTaskDefinition.json
      - efsFileSystem.json
      - efsMountTarget.json
      - eksCluster.json
      - eksNodegroup.json
      - elasticBeanstalkApplication.json
      - elasticBeanstalkConfigurationTemplate.json
      - elasticBeanstalkEnvironment.json
      - elasticLoadBalancingLoadBalancer.json
      - elasticLoadBalancingV2Listener.json
      - elasticLoadBalancingV2ListenerRule.json
      - elasticLoadBalancingV2LoadBalancer.json
      - elasticLoadBalancingV2TargetGroup.json
      - elasticsearchDomain.json
      - emrCluster.json
      - emrClusterSummary.json
      - guardDutyDetector.json
      - iamAccessKey.json
      - iamAccessKeyLastUsed.json
      - iamGroup.json
      - iamGroupPolicy.json
      - iamInstanceProfile.json
      - iamManagedPolicy.json
      - iamPasswordPolicy.json
      - iamPolicyGroup.json
      - iamPolicyRole.json
      - iamPolicyUser.json
      - iamPolicyVersion.json
      - iamRole.json
      - iamRolePolicy.json
      - iamServerCertificate.json
      - iamUser.json
      - iamUserPolicy.json
      - iamVirtualMFADevice.json
      - kmsAlias.json
      - kmsKey.json
      - lambdaFunction.json
      - licenseManagerLicense.json
      - lightsailBucket.json
      - lightsailInstance.json
      - logsLogGroup.json
      - logsLogStream.json
      - logsMetricFilter.json
      - logsSubscriptionFilter.json
      - macie2JobSummary.json
      - macieAllowList.json
      - networkFirewallFirewall.json
      - networkFirewallFirewallPolicy.json
      - networkFirewallRuleGroup.json
      - openSearchServiceDomain.json
      - operations.json
      - organizationsAccount.json
      - organizationsOrganization.json
      - rdsDBCluster.json
      - rdsDBInstance.json
      - rdsDBSnapshotAttributesResult.json
      - rdsEventSubscription.json
      - rdsExportTask.json
      - redshiftCluster.json
      - redshiftClusterParameterGroup.json
      - route53DomainsDomainSummary.json
      - route53HostedZone.json
      - route53RecordSet.json
      - s3AccessPoint.json
      - s3Bucket.json
      - s3BucketPolicy.json
      - s3MultiRegionAccessPointPolicy.json
      - sageMakerApp.json
      - sageMakerDevice.json
      - sageMakerImage.json
      - sageMakerNotebookInstance.json
      - sageMakerNotebookInstanceSummary.json
      - secretsManagerResourcePolicy.json
      - secretsManagerSecret.json
      - snsSubscription.json
      - snsTopic.json
      - sqsQueue.json
      - ssmInstanceInformation.json
      - ssmParameter.json
      - ssmResourceComplianceSummaryItem.json
      - wafv2IPSet.json
      - wafv2LoggingConfiguration.json
      - wafv2WebACLAssociation.json
      - wafWebACL.json
      - wafWebACLSummary.json
```

---
# Code Generation

## Swagger to SDK

This section describes what SDK should be generated by the automatic system.
This is not used by Autorest itself.

```yaml $(swagger-to-sdk)
swagger-to-sdk:
  - repo: azure-sdk-for-java
  - repo: azure-sdk-for-go-track2
  - repo: azure-sdk-for-js
  - repo: azure-resource-manager-schemas
  - repo: azure-cli-extensions
  - repo: azure-powershell
```
## Az

See configuration in [readme.az.md](./readme.az.md)

## Go

See configuration in [readme.go.md](./readme.go.md)

## TypeScript

See configuration in [readme.typescript.md](./readme.typescript.md)

## CSharp

See configuration in [readme.csharp.md](./readme.csharp.md)
