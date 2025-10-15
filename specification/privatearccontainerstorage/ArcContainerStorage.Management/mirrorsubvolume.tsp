import "@typespec/http";
import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "./edgevolume.tsp";
import "./backendconnectionstate.tsp";
import "./subvolumecommon.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;

namespace Private.ArcContainerStorage;

/**
 * MirrorSubvolume is a custom resource that defines configuration
 * for an mirror subvolume in the Arc Container Storage system.
 */
@doc("MirrorSubvolume is a custom resource that defines the configuration for a subvolume.")
@parentResource(EdgeVolume)
model MirrorSubvolume is ProxyResource<MirrorSubvolumeProperties> {
  ...ResourceNameParameter<
    MirrorSubvolume,
    NamePattern = "^[a-zA-Z0-9]([a-zA-Z0-9-_.]*[a-zA-Z0-9])?$"
  >;
}

/**
 * Defines the properties for the MirrorSubvolume resource.
 */
@doc("Defines the properties of the MirrorSubvolume resource.")
model MirrorSubvolumeProperties {
  @doc("Top-level path for this subvolume (e.g., /mysubvol).")
  @minLength(1)
  @maxLength(255)
  @pattern("^/?[a-zA-Z0-9-\\._]*$")
  path?: string;

  @doc("Authentication config for certain subvolumes.")
  authentication?: AuthConfig;

  @doc("Account used for mirror source")
  account?: AccountConfig;

  @doc("Optional blob filtering configuration.")
  blobFiltering?: BlobFilteringConfig;

  @doc("Optional Unix-like ownership info (UID/GID) for the subvolume.")
  authSys?: AuthSysConfig;

  @doc("Schedule configuration")
  schedule?: ScheduleConfig;

  @doc("The provisioning state of the resource.")
  @visibility(Lifecycle.Read)
  provisioningState?: ResourceProvisioningState;

  @doc("Read only object to reflect changes that have occurred on the Edge. Similar to Kubernetes status property for custom resources.")
  @visibility(Lifecycle.Read)
  status?: MirrorSubvolumeStatus;
}

@doc("schedule configuration")
model ScheduleConfig {
  @doc("cron syntax (e.g., '0 12 * * *') for schedule or special modes like 'never'.")
  //@pattern("^(never|@(annually|yearly|monthly|weekly|daily|hourly)|((?:(?:\*|(?:[1-5]?[0-9])(?:\-(?:[1-5]?[0-9]))?)(?:\/(?:[1-5]?[0-9]))?)) ((?:(?:\*|(?:1?[0-9]|2[0-3])(?:\-(?:1?[0-9]|2[0-3]))?)(?:\/(?:1?[0-9]|2[0-3]))?)) ((?:(?:\*|(?:[1-2]?[0-9]|3[0-1])(?:\-(?:[1-2]?[0-9]|3[0-1]))?)(?:\/(?:[1-2][0-9]|3[0-1]))?)) ((?:\*|(?:(?i:1[0-2]|[0-9]|jan|january|feb|february|mar|march|apr|april|may|jun|june|aug|august|sep|sept|september|oct|october|nov|november|dec|december)(?:\-(?i:1[0-2]|[0-9]|jan|january|feb|february|mar|march|apr|april|may|jun|june|aug|august|sep|sept|september|oct|october|nov|november|dec|december))?))(?:\/(?i:1[0-2]|[0-9]|jan|january|feb|february|mar|march|apr|april|may|jun|june|aug|august|sep|sept|september|oct|october|nov|november|dec|december))??) ((?:\*|(?i:[0-6]|mon|monday|tue|tues|tuesday|wed|weds|wednesday|thu|thur|thurs|thursday|fri|friday|sat|saturday|sun|sunday)(?i:\-[0-6]|mon|monday|tue|tues|tuesday|wed|weds|wednesday|thu|thur|thurs|thursday|fri|friday|sat|saturday|sun|sunday)?)(?:\/(?i:[0-6]|mon|monday|tue|tues|tuesday|wed|weds|wednesday|thu|thur|thurs|thursday|fri|friday|sat|saturday|sun|sunday))??))$')
  frequency?: string;

  @doc("If set to true, the scheduled or automatic sync will not run until unsuspended.")
  suspend?: boolean;

  @doc("uuid of oneshot sync")
  oneshot?: UUIDType;
}

@doc("a scheme for filtering blobs to mirror")
model BlobFilteringConfig {
  @doc("prefix to use for filtering")
  blobNamePrefix: string;
}

@doc("account kinds that exist")
union AccountConfigKind {
  blob: "blob",
  onelake: "onelake",
  string,
}

@doc("an account used for mirroring")
@discriminator("kind")
model AccountConfig {
  kind: AccountConfigKind;
}

@doc("possible values for indextags")
union IndexTagsModes {
  @doc("use mirror")
  mirrorIndexTags: "MirrorIndexTags",

  @doc("no tags used")
  noIndexTags: "NoIndexTags",

  string,
}

@doc("a blob account used for mirroring")
model BlobAccountConfig extends AccountConfig {
  kind: "blob";

  @doc("Blob storage endpoint, for example: https://mysa.core.windows.net")
  @minLength(3)
  @maxLength(1024)
  accountEndpoint: string;

  @doc("Blob container name.")
  @minLength(3)
  @maxLength(64)
  containerName?: string;

  @doc("Mode MirrorIndexTags requires higher permissions. When set index tags will be translated to corresponding azindex.<name> xattrs. NoIndexTags will keep index tag xattrs unset.")
  indexTagsMode?: IndexTagsModes = IndexTagsModes.noIndexTags;
}

@doc("A onelake account used for mirroring")
model OnelakeAccountConfig extends AccountConfig {
  kind: "onelake";

  @doc("Onelake endpoint, for example: https://onelake.blob.fabric.microsoft.com")
  @minLength(3)
  @maxLength(1024)
  accountEndpoint: string;

  @doc("Blob container name.")
  containerName?: string;
}

/**
 * Defines the observed status of the MirrorSubvolume resource.
 */
@doc("Defines the observed status of the MirrorSubvolume resource.")
model MirrorSubvolumeStatus {
  @doc("The current state of the subvolume.")
  state?: MirrorSubvolumeState;

  @doc("Describes the backend connection.")
  backendConnection?: BackendConnectionState;
}

@doc("States of an MirrorSubvolume")
union MirrorSubvolumeState {
  @doc("MirrorSubvolume is in an unknown state")
  Unknown: "unknown",

  @doc("MirrorSubvolume configuration is in progress")
  Configuring: "configuring",

  @doc("MirrorSubvolume is configured and ready")
  Configured: "configured",

  @doc("MirrorSubvolume is being deleted")
  CleaningUp: "cleaning_up",

  string,
}

/**
 * Resource operations for the MirrorSubvolume resource.
 */
@armResourceOperations
interface MirrorSubvolumes {
  createOrUpdate is ArmResourceCreateOrUpdateAsync<MirrorSubvolume>;
  delete is ArmResourceDeleteWithoutOkAsync<MirrorSubvolume>;
  get is ArmResourceRead<MirrorSubvolume>;
  list is ArmResourceListByParent<MirrorSubvolume>;
  update is ArmResourcePatchAsync<MirrorSubvolume, MirrorSubvolumeProperties>;
}
