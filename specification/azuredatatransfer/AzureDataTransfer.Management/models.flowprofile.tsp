import "@typespec/rest";
import "@typespec/http";
import "@azure-tools/typespec-azure-resource-manager";
import "@azure-tools/typespec-client-generator-core";
import "./models.tsp";

using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Versioning;

namespace Private.AzureDataTransfer;

/**
 * The FlowProfile resource patch definition.
 */
@added(Versions.v2025_05_30_preview)
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
@added(Versions.v2025_05_30_preview)
model FlowProfilePatchProperties {
  /**
   * Provisioning state of the flow.
   */
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningState;

  /**
   * The FlowProfile description.
   */
  description: string;

  /**
   * The FlowProfile guid assigned by the backend.
   */
  @visibility(Lifecycle.Read)
  flowProfileId?: string;

  /**
   * The Rulesets applied to this FlowProfile
   */
  rulesets: FlowProfileRulesets;

  /**
   * The status of this FlowProfile.
   */
  status: FlowProfileStatus;
}

/**
 * Properties for listing FlowProfiles.
 */
@added(Versions.v2025_05_30_preview)
model FlowProfileMetadata {
  /**
   * The pipeline that the FlowProfile is created under.
   */
  @visibility(Lifecycle.Read)
  pipeline: string;

  /**
   * The FlowProfile's name.
   */
  @visibility(Lifecycle.Read)
  name: string;

  /**
   * The data class type for the FlowProfile.
   */
  @visibility(Lifecycle.Read)
  dataClassType: DataClassType;

  /**
   * The FlowProfile guid assigned by the backend.
   */
  @visibility(Lifecycle.Read)
  flowProfileId: string;
}

/**
 * Properties of a FlowProfile.
 */
@added(Versions.v2025_05_30_preview)
model FlowProfileProperties {
  /**
   * Provisioning state of the flow.
   */
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningState;

  /**
   * The FlowProfile guid assigned by the backend.
   */
  @visibility(Lifecycle.Read)
  flowProfileId?: string;

  /**
   * The data class type applied to this FlowProfile.
   */
  @visibility(Lifecycle.Read)
  dataClassType: DataClassType;

  /**
   * The status of this FlowProfile.
   */
  status: FlowProfileStatus;

  /**
   * The description for this FlowProfile.
   */
  description: string;

  /**
   * The Rulesets applied to this FlowProfile.
   */
  rulesets?: FlowProfileRulesets;
}

/**
 * The FlowProfile rulesets.
 */
@added(Versions.v2025_05_30_preview)
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
@added(Versions.v2025_05_30_preview)
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
@added(Versions.v2025_05_30_preview)
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
@added(Versions.v2025_05_30_preview)
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
@added(Versions.v2025_05_30_preview)
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
@added(Versions.v2025_05_30_preview)
model MimeTypeFilter {
  /**
   * File mime type value.
   */
  @pattern(
    "^[a-z]+/[a-zA-Z0-9+\\-\\+.]+$",
    "String must be a valid IANA Mime type."
  )
  mime: string;

  /**
   * File type extension list.
   */
  extensions?: string[];
}

/**
 * Defines the allow or deny filter type.
 */
@added(Versions.v2025_05_30_preview)
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
@added(Versions.v2025_05_30_preview)
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
@added(Versions.v2025_05_30_preview)
model TextMatchingRuleset {
  /**
   * Deny list of words.
   */
  @OpenAPI.extension(
    "x-ms-identifiers",
    #["text", "matchType", "caseSensitivity"]
  )
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
  @added(Versions.v2025_05_30_preview)
  matchType: MatchType = MatchType.Partial;

  /**
   * The text's cases sensitivity matching type.
   */
  @added(Versions.v2025_05_30_preview)
  caseSensitivity: Casing = Casing.Insensitive;
}

/**
 * The matching types for texts.
 */
@added(Versions.v2025_05_30_preview)
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
@added(Versions.v2025_05_30_preview)
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
