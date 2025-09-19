import "../commons.tsp";
import "../../models/goldengate/deployment.tsp";
import "../../models/goldengate/connectionAssignment.tsp";

using Azure.ResourceManager;
using Autorest;
using TypeSpec.Versioning;

namespace Private.OracleDatabaseDev;

@added(Versions.v20251001_preview)
@armResourceOperations(Deployment)
interface Deployments
  extends OracleTrackedResource<Deployment, DeploymentProperties> {
  // OCI CreateConnectionAssignment API doc: https://docs.oracle.com/en-us/iaas/api/#/en/goldengate/20200407/ConnectionAssignment/CreateConnectionAssignment
  @doc("Perform createConnectionAssignment action on Deployment")
  createConnectionAssignment is ArmResourceActionAsync<
    Deployment,  // contains deployment id
    ConnectionAssignmentCreateByDeploymentParams,  // body
    ConnectionAssignment // response
  >;
}
