import "@typespec/rest";
import "@typespec/http";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.Core;
using Azure.ResourceManager;

namespace Private.AzsDeviceCom;

/** Disk resource */
model Disk is TrackedResource<DiskProperties> {
  /** Name of the disk */
  @pattern("^[a-zA-Z0-9-]{3,24}$")
  @key("diskName")
  @path
  @segment("disks")
  name: string;
}

/** Disk properties */
model DiskProperties {
  /** Size of the disk */
  diskSize?: int32;

  /** The status of the last operation. */
  @visibility("read")
  provisioningState?: ProvisioningState;
}

/** The resource provisioning state. */
@lroStatus
enum ProvisioningState {
  ...ResourceProvisioningState,

  /** The resource is being provisioned. */
  Provisioning,

  /** The resource is being updated. */
  Updating,

  /** The resource is being deleted. */
  Deleting,

  /** The resource provisioning request has been accepted. */
  Accepted,
}

interface Operations extends Azure.ResourceManager.Operations {}

@armResourceOperations
interface Disks {
  @Autorest.example("./examples/Disks_Get.json", "Get a Disk")
  get is ArmResourceRead<Disk>;

  @Autorest.example("./examples/Disks_CreateOrUpdate.json", "Create/Update a disk resource")
  createOrUpdate is ArmResourceCreateOrReplaceAsync<Disk>;
  
  @Autorest.example("./examples/Disks_UpdateTags.json", "Update disk resource tags")
  updateTags is ArmResourcePatchSync<Disk, DiskProperties>;

  @Autorest.example("./examples/Disks_Delete.json", "Delete a disk resource")
  delete is ArmResourceDeleteWithoutOkAsync<Disk>;

  @Autorest.example("./examples/Disks_ListByResourceGroup.json", "List disks by resource group")
  listByResourceGroup is ArmResourceListByParent<Disk>;

  @Autorest.example("./examples/Disks_ListBySubscription.json", "List disks by subscription")
  listBySubscription is ArmListBySubscription<Disk>;
}
