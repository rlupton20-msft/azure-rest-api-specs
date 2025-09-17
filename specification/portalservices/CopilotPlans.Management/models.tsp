import "@typespec/http";
import "@typespec/rest";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

using Azure.ResourceManager;

namespace Microsoft.PortalServices;

interface Operations extends Azure.ResourceManager.Operations {}

@doc("Available values for copilot plan access tiers.")
union AccessTier {
  string,

  @doc("Free tier with basic functionality.")
  "Free",

  @doc("Paid tier with enhanced features.")
  "Paid",
}

@doc("The Copilot Plan properties.")
model CopilotPlanProperties {
  @doc("The access tier for the copilot plan. Determines the level of functionality and features available.")
  accessTier?: AccessTier;

  @doc("Azure Cost Management budget resource ID for spending limits integration. This enables budget enforcement and cost monitoring for the copilot plan.")
  budgetResourceId?: Azure.Core.armResourceIdentifier<[
    {
      type: "Microsoft.Consumption/budgets";
    }
  ]>;

  @doc("List of agent IDs that are blocked from being used with this copilot plan. If not specified, no agents are blocked.")
  blockedAgents?: string[];

  @doc("The status of the last provisioning operation performed on the resource.")
  @visibility(Lifecycle.Read)
  provisioningState?: ResourceProvisioningState;
}

// Patch request workaround for Swagger LintDiff.
// TypeSpec Bug: ArmResourcePatchAsync auto-generates update model that extends TrackedResource
@doc("The properties of a CopilotPlan that can be updated.")
model CopilotPlanUpdate {
  ...Azure.ResourceManager.Foundations.ArmTagsProperty;

  @doc("The resource-specific properties for this resource.")
  properties?: CopilotPlanProperties;
}
