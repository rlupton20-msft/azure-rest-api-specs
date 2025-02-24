import "../Science.Shared/all.tsp";
import "@typespec/http";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-client-generator-core";

using Azure.Core;
using Azure.Core.Traits;
using Azure.ClientGenerator.Core;

// TODO: Can we call this definitionYaml?
@doc("For adding YAML to define the definition.")
model WithDefinitionContents {
  @doc("The definition")
  @visibility("create", "update")
  definitionContent: string;
}

@doc("Scope")
union Scope {
  /** The resource is Archived/discarded. */
  Archived: "Archived",

  /** The resource is visible by users. */
  Visible: "Visible",

  /** The resource is hidden from users. */
  Hidden: "Hidden",

  string,
}

@doc("For adding Scope.")
model WithScope {
  @doc("The Scope")
  @visibility("read")
  scope: Scope;
}

@doc("For adding category.")
model WithCategory {
  @doc("The category")
  @visibility("read")
  category: string;
}

@doc("For adding version.")
model WithVersion {
  @doc("The version")
  @visibility("read")
  version: string;
}
@doc("For adding author.")
model WithAuthor {
  @doc("The author")
  @visibility("read")
  author: string;
}

@doc("For adding license.")
model WithLicense {
  @doc("The license")
  @visibility("read")
  license: string;
}

@doc("For adding definition attributes.")
model WithAttributes<T> {
  @doc("The definition attributes extracted from definitionContents Yaml")
  @visibility("read")
  attributes: T;
}

@doc("BaseAttributes")
model BaseAttributes {
  ...WithCreatedAt;
  ...WithCreatedBy;
  ...WithCreatedByType;
  ...WithUpdatedAt;
  ...WithUpdatedBy;
  ...WithUpdatedByType;
}

@doc("BaseAttributes with Description")
model BaseAttributesWithDescription {
  ...BaseAttributes;

  @doc("The description")
  @visibility("read")
  description: string;
}

@doc("For adding copilot Instruction")
model WithCopilotInstruction {
  @doc("Copilot Instruction")
  @visibility("read")
  copilotInstruction: string;
}

@doc("For adding copilot Instruction")
model WithInfraType {
  @doc("Infrastructure type")
  @visibility("read")
  infraType: string;
}

@doc("For documentation link")
model WithDocs {
  @doc("A documentation URI.")
  @visibility("read")
  docs: string;
}

@doc("For repository link")
model WithRepo {
  @doc("A repository URI.")
  @visibility("read")
  repo: string;
}

@doc("")
model Artifact<T> {
  // ...WithTitle; // TODO: Discuss use of title for mutable display name
  ...WithId;

  ...WithAuthor;

  //  ...WithDescription;
  ...WithTags;

  //  ...WithCreatedAt;
  //  ...WithUpdatedAt;
  //  ...WithVersion;

  ...WithVertical;

  ...WithAttributes<T>;
}
