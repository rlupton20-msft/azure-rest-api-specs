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

@pattern("[a-z0-9]+")
@maxLength(50)
scalar smallString extends string;

enum SkuType {
  Basic,
  Standard
}

enum WasmRuntimeVersion {
  v1,
  v2
}

enum EdgeActionVersionDeploymentType {
  zip,
  others
}

enum EdgeActionVersionValidationStatus {
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
      type: "Microsoft.EdgeAction/Profiles/rulesets",
    }
  ]>;

scalar EdgeActionVersionId
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

@doc("Represents an edge action properties")
model EdgeActionProperties {
  @doc("The sku type of the edge action")
  sku: SkuType;

  @doc("The provisioning state of the edge action")
  @visibility("read")
  provisioningState?: ProvisioningState;
}

@doc("Represents an edge action version")
model EdgeActionVersionProperties {
  @doc("The wasm runtime version")
  wasmRuntimeVersion: WasmRuntimeVersion;

  @doc("The deployment type")
  @visibility("read", "create", "update")
  deploymentType: EdgeActionVersionDeploymentType;

  @doc("The package url")
  @visibility("read", "create", "update")
  packageUrl: url;

  @doc("The validation status")
  @visibility("read")
  validationStatus: EdgeActionVersionValidationStatus;

  @doc("The provisioning state")
  @visibility("read")
  provisioningState?: ProvisioningState;

  @doc("The active state")
  @visibility("read", "create", "update")
  isActive: boolean;

  @doc("The last update time in UTC for package update")
  @visibility("read")
  lastPackageUpdateTime: utcDateTime;
}

model EdgeActionAttachmentProperties {
  @doc("The hook location")
  hookType: HookType;

  @doc("The attached resource Id")
  attachedResourceId: AttachedResourceId;

  @doc("The attachment status")
  attachmentStatus: AttachmentStatus;

  @doc("The provisioning state")
  @visibility("read")
  provisioningState?: ProvisioningState;
}

model EdgeActionDeploymentSlotProperties {
  @doc("The referenced versionId of the slot")
  versionId: EdgeActionVersionId;

  @doc("The last update time in UTC for the deployment slot")
  lastUpdateTime: utcDateTime;

  @doc("Whether the deployment slot belongs to prod")
  isProdSlot: boolean;

  @doc("Custom Header Value associated with the deployment slot")  
  customHeaderValue: smallString;

  @doc("The provisioning state")
  @visibility("read")
  provisioningState?: ProvisioningState;
}
