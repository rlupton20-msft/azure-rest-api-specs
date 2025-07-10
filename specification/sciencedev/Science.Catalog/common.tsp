import "../Science.Shared/all.tsp";
import "@typespec/http";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-client-generator-core";

using Azure.Core;
using Azure.Core.Traits;
using Azure.ClientGenerator.Core;
using Microsoft.Science.Shared;

@doc("For adding YAML to define the definition.")
model WithDefinitionContents {
  @doc("The definition")
  @visibility(Lifecycle.Create, Lifecycle.Update)
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

@doc("For adding category.")
model WithCategory {
  @doc("The category")
  @visibility(Lifecycle.Read)
  category: string;
}

@doc("For adding version.")
model WithVersion {
  @doc("The version")
  @visibility(Lifecycle.Read)
  version: string;
}
@doc("For adding author.")
model WithAuthor {
  @doc("The author")
  @visibility(Lifecycle.Read)
  author?: string;
}

@doc("For adding license.")
model WithLicense {
  @doc("The license")
  @visibility(Lifecycle.Read)
  license: string;
}

@doc("For adding definition attributes.")
model WithAttributes<T> {
  @doc("The definition attributes extracted from definitionContents Yaml")
  @visibility(Lifecycle.Read)
  attributes?: T;
}

@access(Access.internal)
@doc("BaseAttributes")
model BaseAttributes {
  ...DataPlaneResource;
}

@doc("BaseAttributes with Description")
model BaseAttributesWithDescription {
  ...BaseAttributes;

  @doc("The description")
  @visibility(Lifecycle.Read)
  description: string;
}

@doc("For adding copilot Instruction")
model WithCopilotInstruction {
  @doc("Copilot Instruction")
  @visibility(Lifecycle.Read)
  copilotInstruction?: string;
}

@doc("For adding copilot Instruction")
model WithInfraType {
  @doc("Infrastructure type")
  @visibility(Lifecycle.Read)
  infraType?: string;
}

@doc("For documentation link")
model WithDocs {
  @doc("A documentation URI.")
  @visibility(Lifecycle.Read)
  docs: string;
}

@doc("For repository link")
model WithRepo {
  @doc("A repository URI.")
  @visibility(Lifecycle.Read)
  repo: string;
}

@doc("Basis artifact properties")
model Artifact<T> {
  ...WithId;
  ...WithAuthor;

  //  ...WithDescription;
  ...WithTags;

  ...WithAttributes<T>;
}
