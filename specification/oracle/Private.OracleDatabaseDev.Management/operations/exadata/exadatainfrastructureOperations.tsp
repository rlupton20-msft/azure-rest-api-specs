import "../commons.tsp";
import "../../models/exadata/exadatainfra.tsp";

using Azure.ResourceManager;
using Autorest;

using TypeSpec.Versioning;
namespace Private.OracleDatabaseDev;

@armResourceOperations(CloudExadataInfrastructure)
interface CloudExadataInfrastructures
  extends OracleTrackedResource<
      CloudExadataInfrastructure,
      CloudExadataInfrastructureProperties
    > {
  //OCI addStorageCapacityCloudExadataInfrastructure API doc: https://docs.oracle.com/en-us/iaas/api/#/en/database/20160918/CloudExadataInfrastructure/AddStorageCapacityCloudExadataInfrastructure
  @doc("Perform add storage capacity on exadata infra")
  addStorageCapacity is ArmResourceActionAsync<
    CloudExadataInfrastructure,
    void,
    CloudExadataInfrastructure
  >;

  @doc("Configures Exascale on Cloud exadata infrastructure resource")
  @added(Versions.v20250801_preview)
  configureExascale is ArmResourceActionAsync<
    CloudExadataInfrastructure,
    ConfigureExascaleCloudExadataInfrastructureDetails,
    CloudExadataInfrastructure
  >;
}
