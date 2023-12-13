import "@typespec/http";
import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-autorest";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-providerhub";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.ResourceManager;

namespace Microsoft.EdgeAction;

@maxLength(50)
scalar smallString extends string;

enum ValidationStatus {
  Success,
  Failed,
}

enum AttachmentStatus {
  Success,
  Failed,
  Updating,
}

enum HookType {
  ViewerRequest,
  OriginRequest,
  OriginResponse,
  ViewerResponse,
}

scalar AttachedResourceId
  extends ResourceIdentifier<[
    {
      type: "Microsoft.Cdn/Profiles/afdEndpoints/routes",
    }
  ]>;

scalar UserEdgeActionVersionId
  extends ResourceIdentifier<[
    {
      type: "Microsoft.EdgeAction/edgeactions/versions",
    }
  ]>;

@doc("The status of the current operation")
@Azure.Core.lroStatus
enum ProvisioningState {
  ...ResourceProvisioningState,

  @doc("Initial provisioning in progress")
  Provisioning,

  @doc("Update in progress")
  Updating,

  @doc("Deletion in progress")
  Deleting,

  @doc("Change accepted for processing")
  Accepted,
}

@doc("Represents a user create edge action")
model UserEdgeActionProperties {
  @doc("The current default edgeaction version to execute")
  prodSlotVersion: UserEdgeActionVersionId;

  @doc("The staging version array to execute")
  @minItems(0)
  @maxItems(2)
  stagingSlotsVersions: Array<UserEdgeActionVersionId>;

  @doc("The sku type")
  skuType: string;

  @doc("The provisioning state")
  provisioningState?: ProvisioningState;
}

model UserEdgeActionVersionProperties {
  @doc("The wasm runtime version")
  wasmRuntimeVersion: smallString;

  @doc("The package url")
  packageUrl: url;

  @doc("The validation status")
  validationStatus: ValidationStatus;

  @doc("The provisioning state")
  provisioningState?: ProvisioningState;

  @doc("The active state")
  isActive: boolean;
}

model UserEdgeActionAttachmentProperties {
  @doc("The hook location")
  hookType: HookType;

  @doc("The attached resource Id")
  attachedResourceId: AttachedResourceId;

  @doc("The attachment status")
  attachmentStatus: AttachmentStatus;

  @doc("The provisioning state")
  provisioningState?: ProvisioningState;
}
