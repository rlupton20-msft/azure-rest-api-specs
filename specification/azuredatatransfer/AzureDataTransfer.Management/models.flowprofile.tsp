import "@typespec/rest";
import "@typespec/http";
import "@azure-tools/typespec-azure-resource-manager";
import "@azure-tools/typespec-client-generator-core";
import "./models.tsp";

using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;

namespace Private.AzureDataTransfer;

/**
 * The FlowProfile resource patch definition.
 */
model FlowProfilePatch {
  /**
   * Properties of FlowProfile patch body.
   */
  properties?: FlowProfilePatchProperties;

  ...ManagedServiceIdentityProperty;
  ...ArmTagsProperty;
}

/**
 * Properties of a Patch FlowProfile.
 */
model FlowProfilePatchProperties {
  /**
   * Provisioning state of the flow.
   */
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningState;

  /**
   * The FlowProfile description.
   */
  @visibility(Lifecycle.Read)
  description: string;

  /**
   * The Rulesets applied to this FlowProfile
   */
  rulesets: FlowProfileRulesets;
}

/**
 * Properties for listing FlowProfiles.
 */
model FlowProfileMetadata {
  /**
   * The pipeline that the FlowProfile is created under.
   */
  pipeline: string;

  /**
   * The FlowProfile's name.
   */
  name: string;

  /**
   * The data class type for the FlowProfile.
   */
  dataClass: DataClassType;

  /**
   * The FlowProfile guid assigned by the backend.
   */
  flowProfileId?: string;
}

/**
 * Properties of a FlowProfile.
 */
model FlowProfileProperties {
  /**
   * Provisioning state of the flow.
   */
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningState;

  /**
   * The FlowProfile guid assigned by the backend.
   */
  flowProfileId?: string;

  /**
   * The data class applied to this FlowProfile.
   */
  dataClass: DataClassType;

  /**
   * The status of this FlowProfile.
   */
  status: FlowProfileStatus;

  /**
   * The direction of replication for the FlowProfile.
   */
  direction?: Direction;

  /**
   * The description for this FlowProfile.
   */
  @visibility(Lifecycle.Read)
  description: string;

  /**
   * The Rulesets applied to this FlowProfile.
   */
  rulesets?: FlowProfileRulesets;
}

/**
 * The FlowProfile rulesets.
 */
model FlowProfileRulesets {
  /**
   * Options for enabling antivirus policies.
   */
  antivirus?: AntivirusRuleset;

  /**
   * Options for configuring archive related policies.
   */
  archives?: ArchiveRuleset;

  /**
   * Options for configuring data size related policies.
   */
  dataSize?: DataSizeRuleset;

  /**
   * Options for configuring mime type based filter policies.
   */
  mimeFilters?: MimeFilterRuleset;

  /**
   * Options for uploading xml schema filtering policies.
   */
  xmlFilters?: XmlFilterRuleset;

  /**
   * Options for configuring text matching policies.
   */
  textMatching?: TextMatchingRuleset;
}

/**
 * The Antivirus ruleset.
 */
model AntivirusRuleset {
  /**
   * Clam ruleset.
   */
  clamAv?: EnablementStatus;

  /**
   * Defender ruleset.
   */
  defender?: EnablementStatus;
}

/**
 * The Archive ruleset.
 */
model ArchiveRuleset {
  /**
   * Minimum size for expansion in bytes (minimum is 0).
   */
  @minValue(0)
  minimumSizeForExpansion?: int64;

  /**
   * Maximum allowed expansion size in bytes (minimum is 0).
   */
  @minValue(0)
  maximumExpansionSizeLimit?: int64;

  /**
   * Maximum allowed archive depth (minimum is 0).
   */
  @minValue(0)
  maximumDepthLimit?: int64;

  /**
   * Maximum allowed compression ratio (minimum is 0).
   */
  @minValue(0)
  maximumCompressionRatioLimit?: float64;
}

/**
 * The Data Size ruleset.
 */
model DataSizeRuleset {
  /**
   * Maximum size ruleset (minimum is 0).
   */
  @minValue(0)
  maximum?: int64;

  /**
   * Minimum size ruleset (minimum is 0).
   */
  @minValue(0)
  minimum?: int64;
}

/**
 * The File Type ruleset.
 */
model MimeFilterRuleset {
  /**
   * Filter type value.
   */
  type?: FilterType;

  /**
   * Filtered values.
   */
  filters?: MimeTypeFilter;
}


/**
  * Allow list of mime types.
  */
model MimeTypeFilter {
  @pattern(
    "^[a-z]+/[a-zA-Z0-9+\\-\\+.]+$",
    "String must be a valid IANA Mime type."
  )

  /**
   * File mime type value.
   */
  mime: string;

  /**
   * File type extension list.
   */
  extensions?: string[];
}

/**
 * Defines the allow or deny filter type.
 */
union FilterType {
  string,

  /**
   * Allow filter.
   */
  Allow: "Allow",

  /**
   * Deny filter.
   */
  Deny: "Deny",
}

/**
 * The xsd schema ruleset.
 */
model XmlFilterRuleset {
  /**
   * The XSD namespace.
   */
  defaultNamespace?: string;

  /**
   * The base64 encoded xsd byte value.
   */
  schema?: bytes;
}

/**
 * The Watchword ruleset.
 */
model TextMatchingRuleset {
  /**
   * Deny list of words.
   */
  @OpenAPI.extension("x-ms-identifiers", #["text", "matchType", "caseSensitivity"])
  deny?: {
    ...TextMatch;
  }[];
}

/**
 * Text matching ruleset configuration options.
 */
model TextMatch {
/**
 * The text to match and deny.
 */
  text: string;

/**
 * The text matching type.
 */
  matchType: MatchType = MatchType.Partial;

/**
 * The text's cases sensitivity matching type.
 */
  caseSensitivity: Casing = Casing.Insensitive;
}

/**
 * The matching types for texts.
 */
union MatchType {
  string,

/**
 * Partial text comparison.
 */
  Partial: "Partial",

/**
 * Complete text comparison.
 */
  Complete: "Complete",
}

/**
 * Text casing comparision options.
 */
union Casing {
  string,

/**
 * Casing insensitive comparison option.
 */
  Insensitive: "Insensitive",

/**
 * Casing sensitive comparison option.
 */
  Sensitive: "Sensitive",
}
