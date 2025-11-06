import "@typespec/http";
import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using OpenAPI;
using Azure.Core;
using Azure.ResourceManager;

namespace Private.DeviceRegistry;

@added(Versions.v2025_08_01_preview)
@doc("A Credential Policy")
@parentResource(Credential)
model Policy is Azure.ResourceManager.TrackedResource<PolicyProperties> {
  @doc("The name of the Policy tracked resource.")
  @minLength(3)
  @maxLength(63)
  @pattern("^[0-9a-zA-Z][a-zA-Z0-9-]*$")
  @key("policyName")
  @segment("policies")
  @path
  name: string;
}

@added(Versions.v2025_08_01_preview)
@doc("Details of the Credential Policy.")
model PolicyProperties {
  @visibility(Lifecycle.Read)
  @doc("The status of the last operation.")
  provisioningState?: ProvisioningState;

  @doc("The certificate configuration.")
  certificate?: CertificateConfiguration;
}

@added(Versions.v2025_08_01_preview)
@doc("The certificate configuration.")
model CertificateConfiguration {
  @doc("The configuration to set up an ICA.")
  certificateAuthorityConfiguration: CertificateAuthorityConfiguration;

  @doc("The leaf certificate configuration.")
  leafCertificateConfiguration: LeafCertificateConfiguration;
}

@added(Versions.v2025_08_01_preview)
@doc("The configuration to set up an ICA.")
model CertificateAuthorityConfiguration {
  @doc("Crypto type: RSA or EC.")
  @visibility(Lifecycle.Create, Lifecycle.Read)
  keyType: SupportedKeyType;

  @doc("Certificate subject.")
  @visibility(Lifecycle.Read)
  subject?: string;

  @doc("Certificate is valid not before this date. Format ISO8601. Generated based on on validity period.")
  @visibility(Lifecycle.Read)
  validityNotBefore?: utcDateTime;

  @doc("Certificate is valid not after this date. Format ISO8601. Generated based on validity period.")
  @visibility(Lifecycle.Read)
  validityNotAfter?: utcDateTime;
}

@added(Versions.v2025_08_01_preview)
@doc("Supported key types.")
union SupportedKeyType {
  string,

  //@doc("Indicate the RSA key type.")
  //RSA,
  @doc("Indicate the ECC key type.")
  ECC: "ECC",
}

@added(Versions.v2025_08_01_preview)
@doc("The leaf certificate configuration.")
model LeafCertificateConfiguration {
  // Old property: max 30 days, removed in new version
  @maxValue(30)
  @doc("The validity period in days.")
  @removed(Versions.v2025_11_01_preview)
  @renamedFrom(Versions.v2025_11_01_preview, "validityPeriodInDays")
  validityPeriodInDaysV1: int32;

  // New property: max 90 days, only in new version
  @doc("The validity period in days.")
  @added(Versions.v2025_11_01_preview)
  @maxValue(90)
  validityPeriodInDays: int32;
}

@added(Versions.v2025_08_01_preview)
@doc("Body for Revoke Device API request.")
model RevokeDeviceRequest {
  @doc("ResourceId of the device to revoke credentials for.")
  resourceId?: armResourceIdentifier<[
    {
      type: "Microsoft.DeviceRegistry/namespaces/devices";
    }
  ]>;
}

@added(Versions.v2025_08_01_preview)
@armResourceOperations
interface Policies {
  get is ArmResourceRead<Policy>;
  createOrUpdate is ArmResourceCreateOrUpdateAsync<Policy>;
  delete is ArmResourceDeleteWithoutOkAsync<Policy>;
  // Using 'ArmCustomPatchAsync' instead of 'ArmResourcePatchAsync' to define the correct patch payload for the resource.
  // This is a workaround to fix the patch payload that otherwise will expose the 'location' field (not present in patch),
  // since otherwise it extends the ARM TrackedResource type.
  @patch(#{ implicitOptionality: true })
  update is ArmCustomPatchAsync<
    Policy,
    Azure.ResourceManager.Foundations.ResourceUpdateModel<
      Policy,
      PolicyProperties
    >
  >;
  listByResourceGroup is ArmResourceListByParent<Policy>;
  listBySubscription is ArmListBySubscription<Policy>;

  revokeDevice is ArmResourceActionNoContentSync<Policy, RevokeDeviceRequest>;
}
