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

model UserEdgeAction is TrackedResource<UserEdgeActionProperties> {
  @doc("The name of the Edge Action")
  @segment("edgeactions")
  @key("edgeactionName")
  name: smallString;
}

@parentResource(UserEdgeAction)
model UserEdgeActionVersion is ProxyResource<UserEdgeActionVersionProperties> {
  @doc("The name of the User Edge Action version")
  @segment("versions")
  @key("version")
  name: smallString;
}

@parentResource(UserEdgeAction)
model UserEdgeActionAttachment is ProxyResource<UserEdgeActionAttachmentProperties> {
  @doc("The name of attachment")
  @segment("attachments")
  @key("attachment")
  @path
  name: smallString;
}

@armResourceOperations(UserEdgeAction)
interface UserEdgeActions {
    get is ArmResourceRead<UserEdgeAction>;
    create is ArmResourceCreateOrUpdateAsync<UserEdgeAction>;
    update is ArmResourcePatchSync<UserEdgeAction, UserEdgeActionProperties>;
    delete is ArmResourceDeleteSync<UserEdgeAction>;
    listByResourceGroup is ArmResourceListByParent<UserEdgeAction>;
    listBySubscription is ArmListBySubscription<UserEdgeAction>;
}

@armResourceOperations
interface UserEdgeActionVersions
  extends ProxyResourceOperations<
    UserEdgeActionVersion> {
}

@armResourceOperations
interface UserEdgeActionAttachments 
    extends ProxyResourceOperations<
        UserEdgeActionAttachment> {
}