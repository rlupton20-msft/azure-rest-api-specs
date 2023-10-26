import "@typespec/http";
import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-providerhub";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.ResourceManager;

@armProviderNamespace("Microsoft.MartinRPDemo")
@service({
  title: "Microsoft.MartinRPDemo",
  version: "2021-08-03-preview",
})
@useDependency(Azure.ResourceManager.Versions.v1_0_Preview_1)
namespace Microsoft.MartinRPDemo;

interface Operations extends Azure.ResourceManager.Operations {}

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-path-segment-invalid-chars" "Existing Template"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-key-invalid-chars" "Existing template"
@doc("A MartinRPDemoProviderHub resource")
model Database is TrackedResource<DatabaseProperties> {
  @doc("The name of the employee")
  @pattern("^[a-zA-Z0-9-]{3,24}$")
  @key("DatabaseName")
  @segment("Databases")
  @path
  name: string;
}

@doc("The status of the current operation.")
@Azure.Core.lroStatus
enum ProvisioningState {
  ...ResourceProvisioningState,
  Provisioning,
  Updating,
  Deleting,
  Accepted,
}

@doc("Details of the MartinRPDemo Database.")
model DatabaseProperties {
  @visibility("read")
  @doc("The status of the last operation.")
  provisioningState?: ProvisioningState;
}

@doc("The response sent by the HealthCheck operation")
model HealthCheckResponse{
  @doc("The health of the resource.")
  healthStatus: string;
}

@armResourceOperations
interface Databases extends TrackedResourceOperations<Database, DatabaseProperties> {
  @armResourceAction(Database)
  @doc("Action to check the status of the database")
  @segment("checkDB")
  @post op CheckDB(
    ...ResourceInstanceParameters<Database>
  ) : ArmResponse<HealthCheckResponse> | ErrorResponse;
}

