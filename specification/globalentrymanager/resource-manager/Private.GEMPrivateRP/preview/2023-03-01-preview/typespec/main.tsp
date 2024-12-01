import "@typespec/http";
import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-providerhub";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "./models";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.Core;
using Azure.ResourceManager;

@armProviderNamespace
@service({
  title: "Private.GEMPrivateRP",
  version: "2023-03-01-preview",
})
@doc("Global Entry Manager Management API")
@useDependency(Azure.ResourceManager.Versions.v1_0_Preview_1)
namespace Private.GEMPrivateRP;

interface Operations extends Azure.ResourceManager.Operations {}

@doc("A Global Entry Manager Resource")
model GlobalEntryManagerResource
  is TrackedResource<GlobalEntryManagerProperties> {
  @doc("The name of the Global Entry Manager")
  @key("globalEntryManagerName")
  @segment("globalEntryManagers")
  @path
  name: ResourceName;

  ...EntityTag;
}

@doc("A Global Entry Profile Resource")
@parentResource(GlobalEntryManagerResource)
model EntryProfileResource is TrackedResource<EntryProfileProperties> {
  @doc("The name of the Global Entry Profile")
  @key("entryProfileName")
  @segment("entryProfiles")
  @path
  name: ResourceName;

  ...EntityTag;
}

@doc("A Global Entry Profile Policy Resource")
@parentResource(EntryProfileResource)
model EntryProfilePolicyResource
  is TrackedResource<EntryProfilePolicyProperties> {
  @doc("The name of the Global Entry Profile Policy")
  @key("entryProfilePolicyName")
  @segment("entryProfilePolicies")
  @path
  name: ResourceName;

  ...EntityTag;
}

@doc("A Global Entry Region Resource")
@parentResource(GlobalEntryManagerResource)
model EntryRegionResource is TrackedResource<EntryRegionProperties> {
  @doc("The name of the Global Entry Region")
  @key("entryRegionName")
  @segment("entryRegions")
  @path
  name: ResourceName;

  ...EntityTag;
}

@doc("A Global Entry Link Resource")
@parentResource(GlobalEntryManagerResource)
model EntryLinkResource is TrackedResource<EntryLinkProperties> {
  @doc("The name of the Global Entry Link")
  @key("entryLinkName")
  @segment("entryLinks")
  @path
  name: ResourceName;

  ...EntityTag;
}

@armResourceOperations
interface GlobalEntryManager {
  get is ArmResourceRead<GlobalEntryManagerResource>;
  create is ArmResourceCreateOrUpdateAsync<GlobalEntryManagerResource>;
  update is ArmTagsPatchSync<GlobalEntryManagerResource>;
  delete is ArmResourceDeleteAsync<GlobalEntryManagerResource>;
  listByResourceGroup is ArmResourceListByParent<GlobalEntryManagerResource>;
  listBySubscription is ArmListBySubscription<GlobalEntryManagerResource>;
}

@armResourceOperations
interface EntryProfile {
  get is ArmResourceRead<EntryProfileResource>;
  create is ArmResourceCreateOrUpdateAsync<EntryProfileResource>;
  update is ArmResourcePatchAsync<EntryProfileResource, EntryProfileProperties>;
  delete is ArmResourceDeleteAsync<EntryProfileResource>;
  listByResourceGroup is ArmResourceListByParent<EntryProfileResource>;
  listBySubscription is ArmListBySubscription<EntryProfileResource>;
}

@armResourceOperations
interface EntryProfilePolicy {
  get is ArmResourceRead<EntryProfilePolicyResource>;
  create is ArmResourceCreateOrUpdateAsync<EntryProfilePolicyResource>;
  update is ArmResourcePatchAsync<
    EntryProfilePolicyResource,
    EntryProfilePolicyProperties
  >;
  delete is ArmResourceDeleteAsync<EntryProfilePolicyResource>;
  listByResourceGroup is ArmResourceListByParent<EntryProfilePolicyResource>;
  listBySubscription is ArmListBySubscription<EntryProfilePolicyResource>;
}

@armResourceOperations
interface EntryRegion {
  get is ArmResourceRead<EntryRegionResource>;
  create is ArmResourceCreateOrUpdateAsync<EntryRegionResource>;
  update is ArmTagsPatchSync<EntryRegionResource>;
  delete is ArmResourceDeleteAsync<EntryRegionResource>;
  listByResourceGroup is ArmResourceListByParent<EntryRegionResource>;
  listBySubscription is ArmListBySubscription<EntryRegionResource>;
}

@armResourceOperations
interface EntryLink {
  get is ArmResourceRead<EntryLinkResource>;
  create is ArmResourceCreateOrUpdateAsync<EntryLinkResource>;
  update is ArmResourcePatchAsync<EntryLinkResource, EntryLinkProperties>;
  delete is ArmResourceDeleteAsync<EntryLinkResource>;
  listByResourceGroup is ArmResourceListByParent<EntryLinkResource>;
  listBySubscription is ArmListBySubscription<EntryLinkResource>;
}
