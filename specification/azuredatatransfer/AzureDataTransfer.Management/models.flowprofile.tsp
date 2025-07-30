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
   * A set of configurable rulesets applied to this FlowProfile.
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
  pipeline: string;

  /**
   * The name of the FlowProfile.
   */
  name: string;

  /**
   * The classification of data handled by this FlowProfile.
   */
  dataClassificationType: DataClassType;

  /**
   * A guid represented as a string for the FlowProfile resource, assigned by the system.
   */
  flowProfileId: string;

  /**
   * The operational status of the FlowProfile.
   */
  status: FlowProfileStatus;

  /**
   * A user-defined description of the FlowProfile.
   */
  description: string;
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
   * A guid represented as a string for the FlowProfile resource, assigned by the system.
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
   * A set of configurable rulesets applied to this FlowProfile.
   */
  rulesets?: FlowProfileRulesets;
}

/**
 * A set of configurable rulesets for a FlowProfile resource, used during data replication.
 */
@added(Versions.v2025_05_30_preview)
model FlowProfileRulesets {
  /**
   * Antivirus scanning rules for replicated data.
   */
  antivirus?: AntivirusRuleset;

  /**
   * Rules for handling archive files during replication.
   */
  archives?: ArchiveRuleset;

  /**
   * Rules that enforce minimum and maximum data size limits.
   */
  dataSize?: DataSizeRuleset;

  /**
   * Rules for filtering files based on MIME types.
   */
  mimeFilters?: MimeFilterRuleset;

  /**
   * Rules for filtering XML content using XSD schemas.
   */
  xmlFilters?: XmlFilterRuleset;

  /**
   * Rules for detecting and blocking specific text patterns.
   */
  textMatching?: TextMatchingRuleset;
}

/**
 * Antivirus scanning rules for replicating data. By default, all antivirus scanning solutions are disabled.
 */
@added(Versions.v2025_05_30_preview)
model AntivirusRuleset {
  /**
   * Optional. If enabled, uses Microsoft Defender antivirus scanning software as the scanning solution.
   */
  defender?: EnablementStatus;

  /**
   * Optional. If enabled, uses the external ClamAV open-source software as an antivirus scanning solution.
   */
  clamAv?: EnablementStatus;
}

/**
 * Rules for handling supported archive files (BZip2, Cpio, Deb, GZip, Iso9660, Rpm, Tar, Zip) during data replication.
 */
@added(Versions.v2025_05_30_preview)
model ArchiveRuleset {
  /**
   * The minimum archive file size (in bytes) required to trigger expansion during replication.
   */
  @minValue(0)
  minimumSizeForExpansion?: int64;

  /**
   * The combined maximum size (in bytes) of all extracted files that an expanded archive is allowed to reach. Archives exceeding the max limit will be denied for replication.
   */
  @minValue(0)
  maximumExpansionSizeLimit?: int64;

  /**
   * The maximum depth of nested archives that can be expanded. Limits how many layers of embedded archives will be processed. Archives exceeding the max limit will be denied for replication.
   */
  @minValue(0)
  maximumDepthLimit?: int64;

  /**
   * The highest acceptable compression ratio (root object size * compression ratio) for an archive. Used to detect and block archives with suspiciously high compression (e.g., zip bombs).
   */
  @minValue(0)
  maximumCompressionRatioLimit?: float64;
}

/**
 * Defines rules that enforce minimum and maximum file size limits for data replication.
 */
@added(Versions.v2025_05_30_preview)
model DataSizeRuleset {
  /**
   * Specifies the maximum allowed size (in bytes) for files to be replicated.
   */
  @minValue(0)
  maximum?: int64;

  /**
   * Specifies the minimum required size (in bytes) for a file to be eligible for replication.
   */
  @minValue(0)
  minimum?: int64;
}

/**
 * Rules for filtering files based on MIME types.
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
 * Specifies whether the filter applies an allow or deny policy.
 */
@added(Versions.v2025_05_30_preview)
union FilterType {
  string,

  /**
   * Defines an allow filter used for whitelisting.
   */
  Allow: "Allow",

  /**
   * Defines a denying filter used for blacklisting.
   */
  Deny: "Deny",
}

/**
 * Rules for filtering XML content using XSD schemas.
 */
@added(Versions.v2025_05_30_preview)
model XmlFilterRuleset {
  /**
   * The default XML namespace used for schema validation.
   */
  defaultNamespace: string;

  /**
   * Defines the method for referencing the xml schema.
   */
  reference: XmlReferenceType = XmlReferenceType.Inline;

  /**
   * The Base64 string representation of the XSD schema(s) used for validation.
   */
  schema: bytes;
}

/**
 * Specifies how to reference the XML for processing.
 */
@added(Versions.v2025_05_30_preview)
union XmlReferenceType {
  string,

  /**
   * Defines a referencing procedure where the xml schema will be provided inline.
   */
  Inline: "Inline",
}

/**
 * Rules for detecting and blocking specific text patterns.
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
 * Configuration options for the text matching ruleset.
 */
model TextMatch {
  /**
   * The word or phrase to match against replicated content. A phrase with spaces will be considered a single substring.
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
   * Matches the entire string.
   */
  Complete: "Complete",
}

/**
 * Text casing comparison options - diacritics casing is also supported (e.g., "résumé" will match "rÉsumÉ" for case-insensitive comparison).
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
