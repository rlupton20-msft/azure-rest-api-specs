using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.Core;
using Azure.ResourceManager;
using OpenAPI;

namespace Private.OracleDatabaseDev;

@added(Versions.v20251001_preview)
@doc("Possible lifecycle states for connection assignments")
union ConnectionAssignmentLifecycleState {
  @doc("Indicates that resource in Creating state")
  Creating: "CREATING",

  @doc("Indicates that resource in Active state")
  Active: "ACTIVE",

  @doc("Indicates that resource in Failed state")
  Failed: "FAILED",

  @doc("Indicates that resource in Updating state")
  Updating: "UPDATING",

  @doc("Indicates that resource in Deleting state")
  Deleting: "DELETING",

  string,
}

@added(Versions.v20251001_preview)
@doc("The ConnectionAssignment model")
model ConnectionAssignment {
  @doc("The OCID of the connection being referenced.")
  connectionId: Ocid;

  @doc("The OCID of the deployment being referenced.")
  deploymentId: Ocid;

  @doc("The OCID of the compartment being referenced.")
  compartmentId?: Ocid;

  @doc("The connection assignment OCID.")
  ocid?: Ocid;

  @doc("The connection assignment's lifecycle state.")
  lifecycleState?: ConnectionAssignmentLifecycleState;

  @doc("The time the resource was created in RFC3339 format.")
  @visibility(Lifecycle.Read)
  timeCreated?: string;

  @doc("The time the resource was last updated in RFC3339 format.")
  @visibility(Lifecycle.Read)
  timeUpdated?: string;
}

@added(Versions.v20251001_preview)
@doc("The payload for assigning a connection to a deployment.")
model ConnectionAssignmentCreateByDeploymentParams {
  @doc("The OCID of a connection being assigned.")
  connectionId: Ocid;
}
