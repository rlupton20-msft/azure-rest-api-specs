import "../Discovery.Shared/data-plane.tsp";
import "../Discovery.Shared/shared.tsp";
import "@typespec/versioning";
import "@typespec/http";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-client-generator-core";

using TypeSpec.Versioning;
using Azure.ClientGenerator.Core;
using Microsoft.Discovery.Shared;

@versioned(Microsoft.Discovery.Catalog.Versions)
namespace Microsoft.Discovery.Catalog;

@doc("For adding YAML to define the definition.")
model WithDefinitionContents {
  @doc("The definition")
  @visibility(Lifecycle.Read, Lifecycle.Create, Lifecycle.Update)
  definitionContent: string;
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

@doc("Base artifact properties")
model Artifact {
  /** Name of the catalog containing this resource. */
  @visibility(Lifecycle.Read)
  @pattern(resourceNamePattern)
  catalogName: string;

  ...DataPlaneResource;

  @doc("The description")
  @visibility(Lifecycle.Read)
  description: string;

  ...WithScope;
  ...WithAuthor;
  ...WithTags;
}

@access(Access.internal)
@doc("For Catalog data plane list/get of control plane resource proxy.")
model CatalogControlPlaneProxyResource {
  ...ControlPlaneProxyResource;
  ...WithAuthor;
  ...WithScope;

  /** Indicates whether or not resource is public. */
  @visibility(Lifecycle.Read)
  isPublic: boolean;
}
