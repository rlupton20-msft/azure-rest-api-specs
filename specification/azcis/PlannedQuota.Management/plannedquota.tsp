import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-autorest";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

using OpenAPI;
using TypeSpec.Http;
using TypeSpec.Rest;
using Azure.Core;
using Azure.ResourceManager;
using Autorest;

namespace Microsoft.AzureCis;

@doc("plannedQuota properties")
model PlannedQuotaResourceProperties {
  @doc("Name of the resource template")
  plannedQuotaName: string;

  @doc("Contact email for manual approval")
  contactEmail: string;

  @doc("Subscription Name in plan")
  subscriptionNameInPlan: string;

  @doc("Stage name")
  stage?: string;

  @doc("Plan version")
  planVersion?: string;

  @doc("The Azure location.")
  azureLocation: azureLocation;

  @doc("Property bindings")
  @extension("x-ms-identifiers", [])
  propertyBindings?: Array<PropertyBinding>;

  @doc("Skip unsupported silently")
  skipUnsupportedSilently?: boolean;

  @doc("Provisioning status of the resource.")
  @visibility("read")
  provisioningState?: PlannedQuotaProvisioningState;

  @doc("Fulfilled Plan details after fulfilling the quota of the plan; a part of provisioning ResultData output.")
  @visibility("read") // A part of provisioning ResultData output, gets PATCHed back from FRP.
  fulfilledPlan?: FulfilledPlan;

  #suppress "@azure-tools/typespec-azure-resource-manager/no-empty-model" "Generic object model is used, because the number of nested properties can be different."
  @doc("Dictionary of the SKUs with alternative assigned. The key is the original SKU and the value is the alternative; a part of provisioning ResultData output.")
  @visibility("read") // A part of provisioning ResultData output, gets PATCHed back from FRP.
  alternatives?: {};
}

@doc("Fulfilled Plan details after fulfilling the quota of the plan.")
model FulfilledPlan {
  #suppress "@azure-tools/typespec-azure-resource-manager/no-empty-model" "Generic object model is used, because the number of nested properties can be different."
  @doc("Same as the \"arm\" node in the plan for the corresponding Subscription.")
  arm?: {};

  #suppress "@azure-tools/typespec-azure-resource-manager/no-empty-model" "Generic object model is used, because the number of nested properties can be different."
  @doc("Same as the \"rdfe\" node in the plan for the corresponding Subscription.")
  rdfe?: {};

  @doc("Indicates whether AZ is enabled.")
  isAzEnabled?: boolean;
}

@doc("plannedQuota Property Binding")
model PropertyBinding {
  @doc("Property binding placeholder")
  placeholder: string;

  @doc("Resource name of the property")
  resourceName: string;
}

@doc("plannedQuota Resource")
model PlannedQuotaResource
  is ProxyResource<PlannedQuotaResourceProperties> { // this can be TrackedResource based on resourcetype
  @doc("The name of resource.")
  @pattern("^[a-zA-Z0-9-]{3,80}$")
  @key("resourceName")
  @segment("plannedQuotas") // Start with lower case. Should be plural
  @visibility("read")
  @path
  name: string;
}

#suppress "@azure-tools/typespec-azure-resource-manager/no-resource-delete-operation" "The resource must have a delete operation.TypeSpec"
@armResourceOperations
interface PlannedQuota {
  createOrUpdate is ArmResourceCreateOrUpdateAsync<PlannedQuotaResource>;
  listBySubscription is ArmListBySubscription<PlannedQuotaResource>;
  listByResourceGroup is ArmResourceListByParent<PlannedQuotaResource>;
  get is ArmResourceRead<PlannedQuotaResource>;
}
