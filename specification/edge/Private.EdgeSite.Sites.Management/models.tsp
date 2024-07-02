import "@typespec/rest";
import "@typespec/http";
import "@typespec/openapi";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Rest;
using TypeSpec.Http;
using TypeSpec.OpenAPI;
using Azure.ResourceManager;

namespace Private.EdgeSite;

@doc("Site properties")
model SiteProperties {
  @doc("displayName of Site resource")
  displayName?: string;

  @doc("Description of Site resource")
  description?: string;

  @doc("AddressResource ArmId of Site resource")
  addressResourceId?: Azure.Core.armResourceIdentifier<[
    {
      type: "Microsoft.EdgeOrder/addresses";
    }
  ]>;

  @doc("Configuration ArmId for Site resource")
  configurationResourceId?: Azure.Core.armResourceIdentifier<[
    {
      type: "Private.EdgeSite/Configurations";
    }
  ]>;

  @doc("Provisioning state of last operation")
  @visibility("read")
  provisioningState?: ResourceProvisioningState;
}

@doc("The updatable properties of the Site.")
model SiteUpdateProperties {
  @doc("displayName of Site resource")
  displayName?: string;

  @doc("Description of Site resource")
  description?: string;

  @doc("AddressResource ArmId of Site resource")
  addressResourceId?: Azure.Core.armResourceIdentifier<[
    {
      type: "Microsoft.EdgeOrder/addresses";
    }
  ]>;

  @doc("Configuration ArmId for Site resource")
  configurationResourceId?: Azure.Core.armResourceIdentifier<[
    {
      type: "Private.EdgeSite/Configurations";
    }
  ]>;
}

@doc("The type used for update operations of the Site.")
model SiteUpdate {
  @doc("The updatable properties of the Site.")
  properties?: SiteUpdateProperties;
}
