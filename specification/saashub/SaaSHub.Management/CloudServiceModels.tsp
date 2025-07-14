import "@typespec/rest";
import "@typespec/http";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "./SharedModels.tsp";
import "./versions.tsp";

using TypeSpec.Rest;
using TypeSpec.Http;
using TypeSpec.Versioning;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using Azure.Core;

namespace Microsoft.SaaSHub;

/**
 * The properties of a SaaSHub cloud service.
 */
@added(Microsoft.SaaSHub.SaaSHubVersions.v2025_07_01_preview)
@removed(Microsoft.SaaSHub.SaaSHubVersions.v2024_09_30_preview)
model CloudServiceProperties {
  // Include all the base properties from SeatBasedResourceProperties
  ...SeatBasedResourceProperties;

  /**
   * The original resource uri, if the new resource will be created by splitting part of the licenses from an existing resource
   */
  originalResourceUri?: Azure.Core.armResourceIdentifier<[
    {
      type: "Microsoft.SaaSHub/cloudServices";
    }
  ]>;
}

/**
 * Request to check if the cloud service can be created
 */
@added(Microsoft.SaaSHub.SaaSHubVersions.v2025_07_01_preview)
@removed(Microsoft.SaaSHub.SaaSHubVersions.v2024_09_30_preview)
model CanCreateCloudServiceRequest {
  /**
   * Resource name of the saas hub resource to be created.
   */
  name: string;

  /**
   * Resource type to be created, currently only supports CloudService resource type.
   */
  type: string;

  /**
   * The properties of the saas hub resource to be created.
   */
  properties: CloudServiceProperties;
}

/**
 * Cloud service to be used in merge operation as source.
 */
@added(Microsoft.SaaSHub.SaaSHubVersions.v2025_07_01_preview)
@removed(Microsoft.SaaSHub.SaaSHubVersions.v2024_09_30_preview)
model MergeSourceCloudService {
  // Include all the base properties from MergeSourceSeatBasedResource
  ...MergeSourceSeatBasedResource;

  /**
   * Id of the cloud service
   */
  id?: Azure.Core.armResourceIdentifier<[
    {
      type: "Microsoft.SaaSHub/cloudServices";
    }
  ]>;
}

/**
 * Request to merge multiple cloud service resources into one target cloud service resource
 */
@added(Microsoft.SaaSHub.SaaSHubVersions.v2025_07_01_preview)
@removed(Microsoft.SaaSHub.SaaSHubVersions.v2024_09_30_preview)
model MergeCloudServiceRequest {
  /**
   * List of source resources to be merged into target resource.
   */
  sourceResources: MergeSourceCloudService[];

  /**
   * Resource tokens for various authorization and context purposes (for merge target).
   */
  @OpenAPI.extension("x-ms-identifiers", #["type"])
  resourceTokens?: ResourceToken[];
}

/**
 * Validation result for canMerge operation on cloud service.
 */
@added(Microsoft.SaaSHub.SaaSHubVersions.v2025_07_01_preview)
@removed(Microsoft.SaaSHub.SaaSHubVersions.v2024_09_30_preview)
model CloudServiceCanMergeResult {
  /**
   * Whether the validation passed/failed.
   */
  @visibility(Lifecycle.Read)
  evaluateResult: EvaluateResult;

  /**
   * ReasonCode for why the request payload failed validation. Null when validation passed.
   */
  @visibility(Lifecycle.Read)
  reasonCode?: string;

  /**
   * Detailed reason for why the request payload failed validation. Null when validation passed.
   */
  @visibility(Lifecycle.Read)
  reason?: string;

  /**
   * Additional information for failed validation.
   */
  @visibility(Lifecycle.Read)
  additionalInfo?: MergeSourceCloudService[];
}
