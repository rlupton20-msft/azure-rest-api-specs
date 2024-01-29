import "@typespec/http";
import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-autorest";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-providerhub";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "./edgeactionsbasemodels.tsp";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.ResourceManager;

@armProviderNamespace("Microsoft.EdgeAction")
@service({
  title: "Microsoft.EdgeAction",
  version: "2021-08-01-preview",
})
@useDependency(Azure.ResourceManager.Versions.v1_0_Preview_1)
namespace Microsoft.EdgeAction;

interface Operations extends Azure.ResourceManager.Operations {}

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-path-segment-invalid-chars" "Existing Template"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-key-invalid-chars" "Existing template"

model EdgeAction is TrackedResource<EdgeActionProperties> {
  @doc("The name of the Edge Action")
  @segment("edgeactions")
  @key("edgeactionName")
  @visibility("read")
  name: smallString;
}

@parentResource(EdgeAction)
model EdgeActionVersion is TrackedResource<EdgeActionVersionProperties> {
  @doc("The name of the User Edge Action version")
  @segment("versions")
  @key("version")
  @visibility("read")
  name: smallString;
}

@parentResource(EdgeAction)
model EdgeActionAttachment is TrackedResource<EdgeActionAttachmentProperties> {
  @doc("The name of attachment")
  @segment("attachments")
  @key("attachment")
  @visibility("read")
  name: smallString;
}

@parentResource(EdgeAction)
model EdgeActionDeploymentSlot is TrackedResource<EdgeActionDeploymentSlotProperties> {
  @doc("The name of the deployment slot")
  @segment("slots")
  @key("slot")
  @visibility("read")
  name: smallString;
}

@armResourceOperations
interface EdgeActions {
    get is ArmResourceRead<EdgeAction>;
    create is ArmResourceCreateOrUpdateAsync<EdgeAction>;
    update is ArmResourcePatchAsync<EdgeAction, EdgeActionProperties>;
    delete is ArmResourceDeleteAsync<EdgeAction>;
    listByResourceGroup is ArmResourceListByParent<EdgeAction>;
    listBySubscription is ArmListBySubscription<EdgeAction>;
}

@armResourceOperations
interface EdgeActionVersions {
    get is ArmResourceRead<EdgeActionVersion>;
    create is ArmResourceCreateOrUpdateAsync<EdgeActionVersion>;
    update is ArmResourcePatchAsync<EdgeActionVersion, EdgeActionVersionProperties>;
    delete is ArmResourceDeleteAsync<EdgeActionVersion>;
}

@armResourceOperations
interface EdgeActionAttachments {
    get is ArmResourceRead<EdgeActionAttachment>;
    create is ArmResourceCreateOrUpdateAsync<EdgeActionAttachment>;
    update is ArmResourcePatchAsync<EdgeActionAttachment, EdgeActionAttachmentProperties>;
    delete is ArmResourceDeleteAsync<EdgeActionAttachment>; 
}

@armResourceOperations
interface EdgeActionDeploymentSlots {
    get is ArmResourceRead<EdgeActionDeploymentSlot>;
    create is ArmResourceCreateOrUpdateAsync<EdgeActionDeploymentSlot>;
    update is ArmResourcePatchAsync<EdgeActionDeploymentSlot, EdgeActionDeploymentSlotProperties>;
    delete is ArmResourceDeleteAsync<EdgeActionDeploymentSlot>;
}