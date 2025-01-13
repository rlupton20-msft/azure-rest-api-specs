import "../../models/oraclesubscription/oracleSubscription.tsp";

using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using Autorest;
using TypeSpec.Versioning;

namespace Private.OracleDatabaseDev;

@armResourceOperations(OracleSubscription<Foundations.Plan>)
interface OracleSubscriptions
  extends OracleSubscriptionLevelResource<
      OracleSubscription<Foundations.Plan>,
      OracleSubscriptionProperties
    > {
  @doc("List Cloud Account Details")
  listCloudAccountDetails is ListActions.ArmResourceListActionSync<
    OracleSubscription<Foundations.Plan>,
    CloudAccountDetails
  >;

  @doc("List Saas Subscription Details")
  listSaasSubscriptionDetails is ListActions.ArmResourceListActionSync<
    OracleSubscription<Foundations.Plan>,
    SaasSubscriptionDetails
  >;

  @doc("List Activation Links")
  listActivationLinks is ListActions.ArmResourceListActionSync<
    OracleSubscription<Foundations.Plan>,
    ActivationLinks
  >;

  @added(Versions.v20240601_preview)
  @doc("Add Azure Subscriptions")
  addAzureSubscriptions is ArmResourceActionNoResponseContentAsync<
    OracleSubscription<Foundations.Plan>,
    AzureSubscriptions
  >;

  @added(Versions.v20240601_preview)
  @doc("Remove Azure Subscriptions")
  removeAzureSubscriptions is ArmResourceActionNoResponseContentAsync<
    OracleSubscription<Foundations.Plan>,
    AzureSubscriptions
  >;

  /**
   * @dev Update a resource using the asynchronous call pattern.
   * @template Resource The ArmResource to update.
   * @template Properties RP-specific property bag for the resource
   * @template BaseParameters The http parameters that are part of the request
   */
  update is ArmCustomPatchAsync<
    OracleSubscription<Foundations.Plan>,
    ResourceUpdateModel<
      OracleSubscription<ResourcePlanTypeUpdate>,
      OracleSubscriptionProperties
    >,
    DefaultBaseParameters<OracleSubscription<Foundations.Plan>>
  >;
}
