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
 * Defines the patchable properties for a FlowProfile resource.
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
 * Represents the updatable properties of a FlowProfile.
 */
@added(Versions.v2025_05_30_preview)
model FlowProfilePatchProperties {
  /**
   * The current provisioning state of the FlowProfile resource.
   */
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningState;

  /**
   * A description of the FlowProfile that defines the replication scenario.
   */
  description: string;

  /**
   * The unique guid identifier represented as a string for the FlowProfile resource, assigned by the system.
   */
  @visibility(Lifecycle.Read)
  flowProfileId?: string;

  /**
   * The set of policy rules applied to this FlowProfile.
   */
  rulesets: FlowProfileRulesets;

  /**
   * The operational status of the FlowProfile.
   */
  status: FlowProfileStatus;
}

/**
 * The FlowProfile Metadata used to concisely provide all publicly viewable information.
 */
@added(Versions.v2025_05_30_preview)
model FlowProfileMetadata {
  /**
   * The name of the parent Pipeline Azure resource associated with this FlowProfile.
   */
  @visibility(Lifecycle.Read)
  pipeline: string;

  /**
   * The name of the FlowProfile.
   */
  @visibility(Lifecycle.Read)
  name: string;

  /**
   * The classification of data handled by this FlowProfile.
   */
  @visibility(Lifecycle.Read)
  dataClassType: DataClassType;

  /**
   * The unique guid identifier represented as a string for the FlowProfile resource, assigned by the system.
   */
  @visibility(Lifecycle.Read)
  flowProfileId: string;
}

/**
 * Defines the full set of properties for a FlowProfile resource.
 */
@added(Versions.v2025_05_30_preview)
model FlowProfileProperties {
  /**
   * The current provisioning state of the FlowProfile.
   */
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningState;

  /**
   * The unique guid identifier represented as a string for the FlowProfile resource, assigned by the system.
   */
  @visibility(Lifecycle.Read)
  flowProfileId?: string;

  /**
   * The classification of data replicated by this FlowProfile.
   */
  dataClassType: DataClassType;

  /**
   * The operational status of the FlowProfile.
   */
  status: FlowProfileStatus;

  /**
   * A user-defined description of the FlowProfile.
   */
  description: string;

  /**
   * The set of policy rules applied to this FlowProfile.
   */
  rulesets?: FlowProfileRulesets;
}

/**
 * A collection of configurable policy rules applied to data replication.
 */
@added(Versions.v2025_05_30_preview)
model FlowProfileRulesets {
  /**
   * Antivirus scanning policies for replicated data.
   */
  antivirus?: AntivirusRuleset;

  /**
   * Policies for handling archive files during replication.
   */
  archives?: ArchiveRuleset;

  /**
   * Policies that enforce minimum and maximum data size limits.
   */
  dataSize?: DataSizeRuleset;

  /**
   * Policies for filtering files based on MIME types.
   */
  mimeFilters?: MimeFilterRuleset;

  /**
   * Policies for filtering XML content using XSD schemas.
   */
  xmlFilters?: XmlFilterRuleset;

  /**
   * Policies for detecting and blocking specific text patterns.
   */
  textMatching?: TextMatchingRuleset;
}

/**
 * Antivirus scanning policies for replicating data.
 */
@added(Versions.v2025_05_30_preview)
model AntivirusRuleset {
  /**
   * ClamAV scanning policy.
   */
  clamAv?: EnablementStatus;

  /**
   * Microsoft Defender scanning policy.
   */
  defender?: EnablementStatus;
}

/**
 * Policies for handling archive files during replication.
 */
@added(Versions.v2025_05_30_preview)
model ArchiveRuleset {
  /**
   * Minimum size for expanding archives in bytes.
   */
  @minValue(0)
  minimumSizeForExpansion?: int64;

  /**
   * Maximum allowed expansion size for archives in bytes.
   */
  @minValue(0)
  maximumExpansionSizeLimit?: int64;

  /**
   * Maximum depth allowed for archives.
   */
  @minValue(0)
  maximumDepthLimit?: int64;

  /**
   * Maximum allowed compression ratio for archives.
   */
  @minValue(0)
  maximumCompressionRatioLimit?: float64;
}

/**
 * Policies that enforce minimum and maximum data size limits.
 */
@added(Versions.v2025_05_30_preview)
model DataSizeRuleset {
  /**
   * Maximum size allowed for replicating data.
   */
  @minValue(0)
  maximum?: int64;

  /**
   * Minimum size allowed for replicating data.
   */
  @minValue(0)
  minimum?: int64;
}

/**
 * Policies for filtering files based on MIME types.
 */
@added(Versions.v2025_05_30_preview)
model MimeFilterRuleset {
  /**
   * Specifies whether the MIME filter is an allow list or deny list.
   */
  type: FilterType;

  /**
   * Defines the MIME types and associated file extensions to be filtered.
   */
  filters: MimeTypeFilter;
}

/**
 * Defines allowed or blocked MIME types and associated file extensions.
 */
@added(Versions.v2025_05_30_preview)
model MimeTypeFilter {
  /**
   * The MIME type string, following IANA standards (e.g., application/json, image/png).
   */
  @pattern(
    "^[a-z]+/[a-zA-Z0-9+\\-\\+.]+$",
    "String must be a valid IANA Mime type."
  )
  mime: string;

  /**
   * A list of file extensions associated with the specified MIME type (e.g., .json, .png).
   */
  extensions: string[];
}

/**
 * Specifies whether the filter is an allow or deny policy.
 */
@added(Versions.v2025_05_30_preview)
union FilterType {
  string,

  /**
   * Defines an allow policy.
   */
  Allow: "Allow",

  /**
   * Defines a blocking policy.
   */
  Deny: "Deny",
}

/**
 * Policies for filtering XML content using XSD schemas.
 */
@added(Versions.v2025_05_30_preview)
model XmlFilterRuleset {
  /**
   * The default XML namespace used for schema validation.
   */
  defaultNamespace: string;

  /**
   * The XSD schema used for validation, encoded as a base64 byte array.
   */
  schema: bytes;
}

/**
 * Policies for detecting and blocking specific text patterns.
 */
@added(Versions.v2025_05_30_preview)
model TextMatchingRuleset {
  /**
   * A list of text patterns to block, each with matching rules and case sensitivity options.
   */
  @OpenAPI.extension(
    "x-ms-identifiers",
    #["text", "matchType", "caseSensitivity"]
  )
  deny: {
    ...TextMatch;
  }[];
}

/**
 * Text matching ruleset configuration options.
 */
model TextMatch {
  /**
   * The word or phrase to match against replicated content.
   */
  text: string;

  /**
   * Specifies the text matching condition for text comparison.
   */
  @added(Versions.v2025_05_30_preview)
  matchType: MatchType = MatchType.Partial;

  /**
   * Specifies the text matching conditions based on casing.
   */
  @added(Versions.v2025_05_30_preview)
  caseSensitivity: Casing = Casing.Insensitive;
}

/**
 * The text matching conditions for text comparison.
 */
@added(Versions.v2025_05_30_preview)
union MatchType {
  string,

  /**
   * Matches substrings within the content.
   */
  Partial: "Partial",

  /**
   * Matches the entire string exactly.
   */
  Complete: "Complete",
}

/**
 * Text casing comparison options.
 */
@added(Versions.v2025_05_30_preview)
union Casing {
  string,

  /**
   * Ignores casing when performing the match.
   */
  Insensitive: "Insensitive",

  /**
   * Requires exact casing for the match.
   */
  Sensitive: "Sensitive",
}
