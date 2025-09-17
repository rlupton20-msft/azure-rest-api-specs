import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@azure-tools/typespec-autorest";

import "./workspace.tsp";
import "./project.tsp";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.Core;
using Azure.ResourceManager;

@armProviderNamespace("Microsoft.Science")
@versioned(Microsoft.Science.Versions)
namespace Microsoft.Science;

@doc("ScienceModel tracked resource")
@parentResource(Workspace)
model ScienceModel is TrackedResource<ScienceModelProperties> {
  ...ResourceNameParameter<ScienceModel>;
}

@doc("ScienceModel properties")
model ScienceModelProperties {
  ...WithTitle;

  @doc("The description of the model.")
  @visibility("read", "create", "update")
  description: string;

  @doc("The unique identifier for the model.")
  @visibility("read", "create")
  catalogModelReference: Artifact;

  @doc("The ARM resource ID of the subnet.")
  @visibility("read", "create", "update")
  subnetId: string; // TODO Make resource identifier

  @doc("The provisioning status of the model.")
  @visibility("read")
  provisioningState?: ProvisioningState;
}

@armResourceOperations
interface ScienceModels {
  get is ArmResourceRead<ScienceModel>;
  createOrUpdate is ArmResourceCreateOrReplaceAsync<ScienceModel>;
  update is ArmResourcePatchSync<ScienceModel, ScienceModelProperties>;
  delete is ArmResourceDeleteWithoutOkAsync<ScienceModel>;
  listByWorkspace is ArmResourceListByParent<ScienceModel>;
}
