import "@typespec/http";
import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@azure-tools/typespec-client-generator-core";
import "@typespec/openapi";
import "@azure-tools/typespec-azure-portal-core";
import "../shared/main.tsp";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using OpenAPI;
using Azure.Core;
using Azure.ClientGenerator.Core;
using Azure.ResourceManager;
using Azure.Portal;

#suppress "@azure-tools/typespec-azure-resource-manager/missing-operations-endpoint" "Suppress missing operations endpoint as the same is defined ../operations/main.tsp."
@armProviderNamespace
@service(#{ title: "Microsoft.GcpConnector" })
@doc("Microsoft.GcpConnector Resource Provider management API.")
@versioned(Versions)
@armCommonTypesVersion(Azure.ResourceManager.CommonTypes.Versions.v5)
namespace Microsoft.GcpConnector;

/** Api versions */
enum Versions {
  /** 2025-12-01-preview api version */
  @useDependency(Azure.ResourceManager.Versions.v1_0_Preview_1)
  `2025-12-01-preview`,
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Suppress casing style as the name is defined in GCP."
@about({
  displayNames: {
    singular: "Storage Bucket",
    plural: "Storage Buckets",
  },
  keywords: ["Microsoft.GcpConnector", "Storage", "Bucket"],
})
@doc("A Microsoft.GcpConnector resource")
model StorageBucket is TrackedResource<BucketProperties> {
  @doc("Name of StorageBucket")
  @pattern("^(?=.{0,259}[^\\s.]$)(?!.*[<>%&\\?/#])")
  @key("name")
  @path
  @segment("storageBuckets")
  name: string;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Suppress casing style as the property name is defined in GCP."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Suppress no-unknown to handle the datatype object used in GCP"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Suppress arm-no-record to handle the datatype object used in GCP"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "GCPConnector will not generate SDK. So, Suppressing this error"
@doc("Definition of BucketProperties")
model BucketProperties {
  @doc("GCP Properties")
  gcpProperties?: GcpBucketProperties;

  ...GCPCommonProperties;
}

/**
 * A bucket.
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Suppress arm-no-record to handle the datatype object used in gcp"
#suppress "@azure-tools/typespec-azure-core/casing-style" "Suppress casing style as the property name is defined in gcp."
model GcpBucketProperties {
  /**
   * Access controls on the bucket.
   */
  acl?: BucketAccessControl[];

  /**
   * The bucket's Autoclass configuration.
   */
  autoclass?: {
    enabled?: boolean;
    terminalStorageClass?: string;
    terminalStorageClassUpdateTime?: utcDateTime;
    toggleTime?: utcDateTime;
  };

  /**
   * The bucket's billing configuration.
   */
  billing?: {
    requesterPays?: boolean;
  };

  /**
   * The bucket's Cross-Origin Resource Sharing (CORS) configuration.
   */
  @extension("x-ms-identifiers", #[])
  cors?: {
    maxAgeSeconds?: int32;
    method?: string[];
    origin?: string[];
    responseHeader?: string[];
  }[];

  /**
   * The bucket's custom placement configuration for Custom Dual Regions.
   */
  customPlacementConfig?: {
    dataLocations?: string[];
  };

  /**
   * The default value for event-based hold on newly created objects in this bucket. Event-based hold is a way to retain objects indefinitely until an event occurs, signified by the hold's release. After being released, such objects will be subject to bucket-level retention (if any). One sample use case of this flag is for banks to hold loan documents for at least 3 years after loan is paid in full. Here, bucket-level retention is 3 years and the event is loan being paid in full. In this example, these objects will be held intact for any number of years until the event has occurred (event-based hold on the object is released) and then 3 more years after that. That means retention duration of the objects begins from the moment event-based hold transitioned from true to false. Objects under event-based hold cannot be deleted, overwritten or archived until the hold is removed.
   */
  defaultEventBasedHold?: boolean;

  /**
   * Default access controls to apply to new objects when no ACL is provided.
   */
  defaultObjectAcl?: ObjectAccessControl[];

  /**
   * Encryption configuration for a bucket.
   */
  encryption?: {
    defaultKmsKeyName?: string;
  };

  /**
   * HTTP 1.1 Entity tag for the bucket.
   */
  etag?: string;

  /**
   * The bucket's hierarchical namespace configuration.
   */
  hierarchicalNamespace?: {
    enabled?: boolean;
  };

  /**
   * The bucket's IAM configuration.
   */
  iamConfiguration?: {
    bucketPolicyOnly?: {
      enabled?: boolean;
      lockedTime?: utcDateTime;
    };
    publicAccessPrevention?: string;
    uniformBucketLevelAccess?: {
      enabled?: boolean;
      lockedTime?: utcDateTime;
    };
  };

  /**
   * The ID of the bucket. For buckets, the id and name properties are the same.
   */
  id?: string;

  /**
   * The content generation of this object. Used for object versioning..
   */
  generation?: string;

  /**
   * The kind of item this is. For buckets, this is always storage#bucket.
   */
  kind?: string = "storage#bucket";

  /**
   * User-provided labels, in key/value pairs.
   */
  labels?: Record<string>;

  /**
   * The bucket's lifecycle configuration. See lifecycle management for more information.
   */
  lifecycle?: {
    @extension("x-ms-identifiers", #[])
    rule?: {
      action?: {
        storageClass?: string;
        type?: string;
      };
      condition?: {
        age?: int32;
        createdBefore?: plainDate;
        customTimeBefore?: plainDate;
        daysSinceCustomTime?: int32;
        daysSinceNoncurrentTime?: int32;
        isLive?: boolean;
        matchesPattern?: string;
        matchesPrefix?: string[];
        matchesStorageClass?: string[];
        matchesSuffix?: string[];
        noncurrentTimeBefore?: plainDate;
        numNewerVersions?: int32;
      };
    }[];
  };

  /**
   * The location of the bucket. Object data for objects in the bucket resides in physical storage within this region. Defaults to US. See the developer's guide for the authoritative list.
   */
  location?: string;

  /**
   * The type of the bucket location.
   */
  locationType?: string;

  /**
   * The bucket's logging configuration, which defines the destination bucket and optional name prefix for the current bucket's logs.
   */
  logging?: {
    logBucket?: string;
    logObjectPrefix?: string;
  };

  /**
   * The metadata generation of this bucket.
   */
  metageneration?: string;

  /**
   * The name of the bucket.
   */
  name?: string;

  /**
   * The bucket's object retention config.
   */
  objectRetention?: {
    mode?: string;
  };

  /**
   * The owner of the bucket. This is always the project team's owner group.
   */
  owner?: {
    entity?: string;
    entityId?: string;
  };

  /**
   * The project number of the project the bucket belongs to.
   */
  projectNumber?: string;

  /**
   * The bucket's retention policy. The retention policy enforces a minimum retention time for all objects contained in the bucket, based on their creation time. Any attempt to overwrite or delete objects younger than the retention period will result in a PERMISSION_DENIED error. An unlocked retention policy can be modified or removed from the bucket via a storage.buckets.update operation. A locked retention policy cannot be removed or shortened in duration for the lifetime of the bucket. Attempting to remove or decrease period of a locked retention policy will result in a PERMISSION_DENIED error.
   */
  retentionPolicy?: {
    effectiveTime?: utcDateTime;
    isLocked?: boolean;
    retentionPeriod?: string;
  };

  /**
   * The Recovery Point Objective (RPO) of this bucket. Set to ASYNC_TURBO to turn on Turbo Replication on a bucket.
   */
  rpo?: string;

  /**
   * Reserved for future use.
   */
  satisfiesPZS?: boolean;

  /**
   * The URI of this bucket.
   */
  selfLink?: string;

  /**
   * The bucket's soft delete policy, which defines the period of time that soft-deleted objects will be retained, and cannot be permanently deleted.
   */
  softDeletePolicy?: {
    effectiveTime?: utcDateTime;
    retentionDurationSeconds?: string;
  };

  /**
   * The bucket's default storage class, used whenever no storageClass is specified for a newly-created object. This defines how objects in the bucket are stored and determines the SLA and the cost of storage. Values include MULTI_REGIONAL, REGIONAL, STANDARD, NEARLINE, COLDLINE, ARCHIVE, and DURABLE_REDUCED_AVAILABILITY. If this value is not specified when the bucket is created, it will default to STANDARD. For more information, see storage classes.
   */
  storageClass?: string;

  /**
   * The creation time of the bucket in RFC 3339 format.
   */
  timeCreated?: utcDateTime;

  /**
   * The modification time of the bucket in RFC 3339 format.
   */
  updated?: utcDateTime;

  /**
   * The bucket's versioning configuration.
   */
  versioning?: {
    enabled?: boolean;
  };

  /**
   * The bucket's website configuration, controlling how the service behaves when accessing bucket contents as a web site. See the Static Website Examples for more information.
   */
  website?: {
    mainPageSuffix?: string;
    notFoundPage?: string;
  };
}

/**
 * An access-control entry.
 */
model BucketAccessControl {
  /**
   * The name of the bucket.
   */
  bucket?: string;

  /**
   * The domain associated with the entity, if any.
   */
  domain?: string;

  /**
   * The email address associated with the entity, if any.
   */
  email?: string;

  @doc("""
    The entity holding the permission, in one of the following forms: 
    - user-userId 
    - user-email 
    - group-groupId 
    - group-email 
    - domain-domain 
    - project-team-projectId 
    - allUsers 
    - allAuthenticatedUsers Examples: 
    - The user liz@example.com would be user-liz@example.com. 
    - The group example@googlegroups.com would be group-example@googlegroups.com. 
    - To refer to all members of the Google Apps for Business domain example.com, the entity would be domain-example.com.
    """)
  entity?: string;

  /**
   * The ID for the entity, if any.
   */
  entityId?: string;

  /**
   * HTTP 1.1 Entity tag for the access-control entry.
   */
  etag?: string;

  /**
   * The ID of the access-control entry.
   */
  id?: string;

  /**
   * The kind of item this is. For bucket access control entries, this is always storage#bucketAccessControl.
   */
  kind?: string = "storage#bucketAccessControl";

  /**
   * The project team associated with the entity, if any.
   */
  projectTeam?: {
    projectNumber?: string;
    team?: string;
  };

  /**
   * The access permission for the entity.
   */
  role?: string;

  /**
   * The link to this access-control entry.
   */
  selfLink?: string;
}

/**
 * An access-control entry.
 */
model ObjectAccessControl {
  /**
   * The name of the bucket.
   */
  bucket?: string;

  /**
   * The domain associated with the entity, if any.
   */
  domain?: string;

  /**
   * The email address associated with the entity, if any.
   */
  email?: string;

  @doc("""
    The entity holding the permission, in one of the following forms: 
    - user-userId 
    - user-email 
    - group-groupId 
    - group-email 
    - domain-domain 
    - project-team-projectId 
    - allUsers 
    - allAuthenticatedUsers Examples: 
    - The user liz@example.com would be user-liz@example.com. 
    - The group example@googlegroups.com would be group-example@googlegroups.com. 
    - To refer to all members of the Google Apps for Business domain example.com, the entity would be domain-example.com.
    """)
  entity?: string;

  /**
   * The ID for the entity, if any.
   */
  entityId?: string;

  /**
   * HTTP 1.1 Entity tag for the access-control entry.
   */
  etag?: string;

  /**
   * The content generation of the object, if applied to an object.
   */
  generation?: string;

  /**
   * The ID of the access-control entry.
   */
  id?: string;

  /**
   * The kind of item this is. For object access control entries, this is always storage#objectAccessControl.
   */
  kind?: string = "storage#objectAccessControl";

  /**
   * The name of the object, if applied to an object.
   */
  object?: string;

  /**
   * The project team associated with the entity, if any.
   */
  projectTeam?: {
    projectNumber?: string;
    team?: string;
  };

  /**
   * The access permission for the entity.
   */
  role?: string;

  /**
   * The link to this access-control entry.
   */
  selfLink?: string;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Suppress casing style as the name is defined in GCP."
@armResourceOperations
interface StorageBuckets {
  get is ArmResourceRead<StorageBucket>;
  @doc("Create a StorageBucket. Please note that end user resource creation is currently restricted, but it will be enabled in the future.")
  createOrReplace is ArmResourceCreateOrReplaceAsync<StorageBucket>;
  update is ArmCustomPatchAsync<
    StorageBucket,
    Azure.ResourceManager.Foundations.TagsUpdateModel<StorageBucket>
  >;
  delete is ArmResourceDeleteWithoutOkAsync<StorageBucket>;
  listByResourceGroup is ArmResourceListByParent<StorageBucket>;
  listBySubscription is ArmListBySubscription<StorageBucket>;
}
