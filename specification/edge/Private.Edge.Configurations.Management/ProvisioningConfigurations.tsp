import "@typespec/http";
import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "./Configuration.tsp";

using TypeSpec.OpenAPI;
using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.Core;
using Azure.ResourceManager;

namespace Private.Edge;

@armResourceOperations
interface ProvisioningConfigurations {
  get is ArmResourceRead<ProvisioningConfiguration>;
  createOrUpdate is ArmResourceCreateOrReplaceSync<ProvisioningConfiguration>;
  update is ArmResourcePatchSync<
    ProvisioningConfiguration,
    ProvisioningConfigurationProperties
  >;
  delete is ArmResourceDeleteSync<ProvisioningConfiguration>;
  listByConfiguration is ArmResourceListByParent<ProvisioningConfiguration>;
}

@doc("ProvisioningConfiguration Resource")
@parentResource(Configuration)
model ProvisioningConfiguration
  is ProxyResource<ProvisioningConfigurationProperties> {
  ...ResourceNameParameter<
    ProvisioningConfiguration,
    NamePattern = "^default$"
  >;
}

@doc("ProvisioningConfigurationProperties Properties")
model ProvisioningConfigurationProperties {
  @doc("Provisioning state of resource")
  @visibility("read")
  provisioningState?: ResourceProvisioningState;

  @doc("Policy resource Id of onboarding service")
  onboardingServicePolicyResourceId: Azure.Core.armResourceIdentifier<[
    {
      type: "Microsoft.DeviceOnboarding/onboardingServices/policies";
    }
  ]>;

  @doc("Type of OwnerKey. Currently supported types are MicrosoftManagedKey and CustomerManagedKey.")
  ownerKeyType: OwnerKeyType;

  @doc("OwnerKey properties")
  ownerKeyProperties?: OwnerKeyProperties;
}

@doc("OwnerKey Types")
union OwnerKeyType {
  @doc("MicrosoftManagedKey") MicrosoftManagedKey: "MicrosoftManagedKey",
  @doc("CustomerManagedKey") CustomerManagedKey: "CustomerManagedKey",
  string,
}

@doc("OwnerKey Properties")
model OwnerKeyProperties {
  @doc("ResourceId of KeyVault")
  keyvaultResourceId: Azure.Core.armResourceIdentifier<[
    {
      type: "Microsoft.KeyVault/vaults";
    }
  ]>;

  @doc("Uri of ownership certificate. This is certificate identifier in KeyVault without certificate version.")
  ownershipCertificateUri: url;

  @doc("User assigned identity")
  userAssignedIdentity: Azure.Core.armResourceIdentifier<[
    {
      type: "Microsoft.ManagedIdentity/userAssignedIdentities";
    }
  ]>;
}

