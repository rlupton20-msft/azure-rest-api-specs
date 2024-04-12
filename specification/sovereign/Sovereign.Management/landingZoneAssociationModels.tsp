using Azure.ResourceManager;
using TypeSpec.Versioning;
using Azure.Core;

namespace Microsoft.Sovereign;

@added(Versions.Preview20240831)
@doc("The properties of landing zone association resource type.")
model LandingZoneAssociationProperties {
  @visibility("read")
  @doc("The status of a user-initiated, control-plane operation on the landing Zone association resource type.")
  provisioningState?: ResourceProvisioningState;

  @doc("The resource id of the top level management group")
  existingTopLevelMgId: armResourceIdentifier<[
    {
      type: "Microsoft.Management/managementGroups";
    }
  ]>;

  @doc("The resource id of the associated landing zone template.")
  existingLandingZoneTemplateId: armResourceIdentifier<[
    {
      type: "Microsoft.Sovereign/landingZoneTemplates";
    }
  ]>;
}
