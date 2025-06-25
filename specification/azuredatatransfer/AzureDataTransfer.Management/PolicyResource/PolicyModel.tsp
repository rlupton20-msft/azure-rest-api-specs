import "@typespec/rest";
import "@typespec/http";
import "@azure-tools/typespec-azure-resource-manager";
import "@azure-tools/typespec-client-generator-core";
import "../models.tsp";

using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;

namespace Microsoft.AzureDataTransfer;

/**
 * The policy resource patch definition.
 */
model PolicyPatch {
  /**
   * Properties of pipelines patch body.
   */
  properties?: PolicyPatchProperties;

  ...ManagedServiceIdentityProperty;
  ...ArmTagsProperty;
}

/**
 * Properties of a Patch Policy
 */
model PolicyPatchProperties {
  /**
   * Provisioning state of the flow
   */
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningState;

  /**
   * The Policy DataFlowEnum Type
   */
  policyFlowType: FlowDataType;

  /**
   * The Policy description
   */
  @visibility(Lifecycle.Read)
  policyDescription: string;

  /**
   * The list of regions the Policy is allowed to live in
   */
  allowedRegionList: string[];

  /**
   * The Rulesets applied to this Policy
   */
  rulesets: PolicyRulesets;
}


/**
 * Properties of Policy
 */
model PolicyProperties {
  /**
   * Provisioning state of the flow
   */
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningState;

  /**
   * Pipeline the Policy is a child of
   */
  pipeline: string;

  /**
   * Name of the Policy
   */
  @visibility(Lifecycle.Read)
  policyName: string;

  /**
   * The Policy guid assigned by RP backend.
   */
  policyId?: string;

  /**
   * The Policy DataFlowEnum Type
   */
  policyFlowType: FlowDataType;

  /**
   * The Policy description
   */
  @visibility(Lifecycle.Read)
  policyDescription: string;

  /**
   * The list of regions the Policy is allowed to live in
   */
  allowedRegionList: string[];

  /**
   * The Rulesets applied to this Policy
   */
  rulesets: PolicyRulesets;
}


/**
 * Data type for Flows
 */
union FlowDataType {
  string,

  /**
   * Blob data type
   */
  Blobs: "Blob",

  /**
   * Tables data type
   */
  Tables: "Tables",

  /**
   * API data type
   */
  API: "API",

  /**
   * Messaging data type
   */
  Messaging: "Messaging",

  /**
   * Files data type
   */
  Files: "Files",

  /**
   * Video data type
   */
  Video: "Video",
}

/**
 * The Policy rulesets.
 */
model PolicyRulesets {
  /**
   * TODO.
   */
  antivirus?: AntivirusRuleset;

  /**
   * TODO.
   */
  archives?: ArchiveRuleset;

  /**
   * TODO.
   */
  size?: SizeRuleset;

  /**
   * TODO.
   */
  type?: TypeRuleset;

  /**
   * TODO.
   */
  xsd?: Xsd;

  /**
   * TODO.
   */
  watchword?: TextMatchingRuleset;
}

/**
 * The Antivirus ruleset.
 */
model AntivirusRuleset {
  /**
   * Clam ruleset
   */
  clam?: boolean;

  /**
   * Defender ruleset
   */
  defender?: boolean;
}

/**
 * The Archive ruleset.
 */
model ArchiveRuleset {
  /**
   * Minimum size for expansion (minimum is 0)
   */
  minimumSizeForExpansionBytes?: int64;

  /**
   * Maximum allowed expansion size (minimum is 0)
   */
  maximumExpansionSizeBytes?: int64;

  /**
   * Maximum allowed archive depth (minimum is 0)
   */
  maximumDepth?: int64;

    /**
   * Maximum allowed compression ratio (minimum is 0)
   */
  maximumCompressionRatio?: float64;
}

/**
 * The Size ruleset.
 */
model SizeRuleset {
  /**
   * Maximum size ruleset (minimum is 0)
   */
  maximum?: int64;

  /**
   * Minimum size ruleset (minimum is 0)
   */
  minimum?: int64;
}

/**
 * The File Type ruleset.
 */
model TypeRuleset {
  /**
   * Ruleset enablement flag
   */
  enabled?: boolean;

  /**
   * Filter type value
   */
  type?: FilterType;

  /**
   * Filtered values
   */
  filters?: FileTypeFilter;
}


/**
  * Allow list of words
  */
model FileTypeFilter {
  @pattern(
    "^[a-z]+/[a-zA-Z0-9+\\-\\+.]+$",
    "String must be a valid IANA Mime type."
  )

  /**
   * File mime type value
   */
  mime: string;

  /**
   * File type extension list
   */
  extensions?: string[];
}

/**
 * Defines the allow or deny filter type
 */
union FilterType {
  string,

  /**
   * Allow filter
   */
  Allow: "Allow",

  /**
   * Deny filter
   */
  Deny: "Deny",
}

/**
 * The xsd schema ruleset.
 */
model Xsd {
  /**
   * The XSD namespace
   */
  defaultNamespace?: string;

  /**
   * The base64 encoded xsd byte value
   */
  filter?: bytes;
}

/**
 * The Watchword ruleset.
 */
model TextMatchingRuleset {
  /**
   * Deny list of words 
   */
  @OpenAPI.extension("x-ms-identifiers", #["text", "matchType", "matchScope"])
  deny?: {
    ...TextMatch;
  }[];
}

/**
 * TODO
 */
model TextMatch {
  /**
 * TODO
 */
  text: string;

  /**
 * TODO
 */
  matchType: MatchType = MatchType.Partial;

  /**
 * TODO
 */
  matchScope: MatchScope = MatchScope.Insensitive;
}

/**
 * TODO
 */
union MatchType {
  string,

  /**
 * TODO
 */
  Partial: "Partial",

  /**
 * TODO
 */
  Complete: "Complete",
}

/**
 * TODO
 */
union MatchScope {
  string,

  /**
 * TODO
 */
  Insensitive: "Insensitive",

  /**
 * TODO
 */
  Sensitive: "Sensitive",
}
