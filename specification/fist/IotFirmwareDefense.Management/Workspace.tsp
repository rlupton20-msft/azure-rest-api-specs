import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.IotFirmwareDefense;
/**
 * Firmware analysis workspace.
 */
model Workspace is TrackedResource<WorkspaceProperties> {
  /**
   * The name of the firmware analysis workspace.
   */
  @pattern("^[a-zA-Z0-9][a-zA-Z0-9_.-]*$")
  @path
  @key("workspaceName")
  @segment("workspaces")
  @visibility("read")
  name: string;
}

/**
 * Firmware analysis workspace.
 */
model WorkspaceUpdateDefinition {
  /**
   * Resource tags
   */
  tags?: Record<string>;

  /**
   * The editable workspace properties.
   */
  properties?: WorkspaceProperties;
}

@armResourceOperations
interface Workspaces {
  /**
   * Get firmware analysis workspace.
   */
  get is ArmResourceRead<Workspace>;

  /**
   * The operation to create or update a firmware analysis workspace.
   */
  create is ArmResourceCreateOrReplaceSync<Workspace>;

  /**
   * The operation to update a firmware analysis workspaces.
   */
  @parameterVisibility
  update is ArmCustomPatchSync<Workspace, WorkspaceUpdateDefinition>;

  /**
   * The operation to delete a firmware analysis workspace.
   */
  delete is ArmResourceDeleteSync<Workspace>;

  /**
   * Lists all of the firmware analysis workspaces in the specified resource group.
   */
  listByResourceGroup is ArmResourceListByParent<Workspace>;

  /**
   * Lists all of the firmware analysis workspaces in the specified subscription.
   */
  listBySubscription is ArmListBySubscription<Workspace>;

  /**
   * The operation to get a url for file upload.
   */
  generateUploadUrl is ArmResourceActionSync<
    Workspace,
    GenerateUploadUrlRequest,
    UrlToken
  >;
}

@@doc(Workspaces.create::parameters.resource,
  "Parameters when creating a firmware analysis workspace."
);
@@doc(Workspaces.update::parameters.properties,
  "Parameters when updating a firmware analysis workspace."
);
@@doc(Workspaces.generateUploadUrl::parameters.body,
  "Parameters when requesting a URL to upload firmware."
);
