import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "./common.tsp";
import "./_investigation.tsp";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.Core;
using Azure.Core.Traits;

@versioned(Microsoft.AiForScienceWorkspace.Versions)
namespace Microsoft.AiForScienceWorkspace;

@doc("Status")
union InvestigationVersionStatus {
  InvestigationStatus,
}

@doc("A version.")
@resource("versions")
@parentResource(Investigation)
model InvestigationVersion {
  ...WithTags;
  ...WithCreatedBy;
  ...WithCreatedAt;
  ...WithUpdatedAt;

  @doc("The version name.")
  @visibility("read", "create")
  @key("versionName")
  name: string;

  //  @doc("The ID of the version this was cloned from, if any.")
  //  @visibility("read")
  //  clonedFrom?: string;
}

@doc("A version with YAML.")
@resource("versions")
@parentResource(Investigation)
@parentResource(Investigation)
model InvestigationVersionDetailed {
  ...InvestigationVersion;

  /** Readonly snapshot of the investigation */
  snapshot: InvestigationWithYaml;
}

interface InvestigationVersions {
  @doc("Fetch a InvestigationVersion by name.")
  getInvestigationVersion is ResourceRead<InvestigationVersionDetailed>;

  @doc("List InvestigationVersion resources")
  listInvestigationVersions is ResourceList<
    InvestigationVersion,
    QueryParametersTrait<WithQueryCreatedSince>
  >;

  //  @doc("Gets status of a InvestigationVersion operation.")
  //  getInvestigationVersionOperationStatus is GetResourceOperationStatus<InvestigationVersion>;

  @doc("Clone a InvestigationVersion to new Investigation.")
  clone is Operations.ResourceAction<InvestigationVersion, {}, Investigation>;

  @doc("Update the Investigation to use this version as the current one.")
  useAsCurrentVersion is Operations.ResourceAction<
    InvestigationVersion,
    {},
    {}
  >;
}
