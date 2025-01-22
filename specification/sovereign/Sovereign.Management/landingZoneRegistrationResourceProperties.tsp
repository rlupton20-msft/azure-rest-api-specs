using Azure.ResourceManager;
using TypeSpec.Versioning;
using Azure.Core;

namespace Microsoft.Sovereign;

@added(Versions.Preview20241031)
@doc("The properties of landing zone registration resource type.")
model LandingZoneRegistrationResourceProperties {
  @visibility("read")
  @doc("The status of a user-initiated, control-plane operation on the landing Zone registration resource type.")
  provisioningState?: provisioningState;

  @doc("The resource id of the top level management group")
  existingTopLevelMgId: armResourceIdentifier<[
    {
      type: "Microsoft.Management/managementGroups";
    }
  ]>;

  //need to check if landingZoneAccount name is needed
  @doc("The resource id of the associated landing zone configuration.")
  existingLandingZoneConfigurationId: armResourceIdentifier<[
    {
      type: "Microsoft.Sovereign/landingZoneAccounts/landingZoneConfigurations";
    }
  ]>;

  @added(Versions.Preview20250227)
  @doc("The managed identity to be tied to this landing zone registration")
  managedIdentity: ManagedIdentityProperties;
}

@added(Versions.Preview20241031)
@removed(Versions.Preview20250227)
@doc("JSON structure for Drift severity count.")
model DriftedItemsBySeverity {
  @doc("The type of severity.")
  severityType: string;

  @doc("The count of occurrences.")
  count: string;
}

@added(Versions.Preview20241031)
@removed(Versions.Preview20250227)
@doc("Structure of each JSON object for Drift API call.")
model DriftedItems {
  @doc("The name of the affected rule.")
  ruleName: string;

  @doc("The category of the rule.")
  category: string;

  @doc("The severity of the drift.")
  priority: string;

  @doc("The details of the rule.")
  detail: string;

  @doc("The identifier of the item.")
  identifier: string;
}

@added(Versions.Preview20241031)
@removed(Versions.Preview20250227)
@doc("The JSON response of the drift API call.")
model DriftResponseArray {
  @doc("The count of drift rules.")
  totalRulesEvaluated: string;

  @doc("Array of Drift severity count.")
  @OpenAPI.extension("x-ms-identifiers", ["severityType", "count"])
  driftedItemsBySeverity: DriftedItemsBySeverity[];

  @doc("Array of Drift JSON response.")
  @OpenAPI.extension(
    "x-ms-identifiers",
    ["ruleName", "category", "priority", "detail", "identifier"]
  )
  driftedItems: DriftedItems[];
}
