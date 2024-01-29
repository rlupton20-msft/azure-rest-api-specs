import "@typespec/rest";
import "@typespec/http";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.Core;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;

namespace Microsoft.CodeSigning;

interface Operations extends Azure.ResourceManager.Operations {}

@doc("Provisioning state of the code signing account")
enum ProvisioningState {
  @doc("Resource has been created.") Succeeded,
  @doc("Resource creation failed.") Failed,
  @doc("Resource creation was canceled.") Canceled,
  @doc("Updating in progress") Updating,
  @doc("Deletion in progress") Deleting,
  @doc("Change accepted for processing") Accepted,
}

@doc("Profile type of the certificate")
enum ProfileType {
  PublicTrust,
  PrivateTrust,
  PrivateTrustCIPolicy,
  VBSEnclave,
  PublicTrustTest,
}

@doc("Status of the certificate profiles")
enum CertificateProfileStatus {
  Active,
  Disabled,
  Suspended
}

@doc("Status of the certificate")
enum CertificateStatus {
  Active,
  Expired,
  Revoked
}

@doc("Revocation status of the certificate")
enum RevocationStatus {
  Succeeded,
  InProgress,
  Failed 
}

@doc("Name of this SKU")
@fixed
enum SkuName {
  Basic,
  Premium,
}

@doc("The reason that a code signing account name could not be used. The Reason element is only returned if nameAvailable is false.")
@fixed
enum NameUnavailabilityReason {
  AccountNameInvalid,
  AlreadyExists,
}

@doc("Properties of the code signing account")
model CodeSigningAccountProperties {
  @doc("The URI of the code signing account for performing operations on certificate profiles. This property is readonly")
  @visibility("read")
  accountUri?: string;

  @doc("SKU of the code signing account")
  sku?: AccountSku;

  @doc("Provisioning state of the code signing account")
  @visibility("read")
  provisioningState?: ProvisioningState;
}

@doc("SKU of the code signing account")
model AccountSku {
  @doc("Name of this SKU")
  name: SkuName;
}

@doc("Parameters for creating or updating a code signing account")
model CodeSigningAccountPatch {
  @doc("Resource tags.")
  tags?: Record<string>;

  @doc("Properties of the code signing account")
  properties?: CodeSigningAccountPatchProperties;
}

@doc("Properties of the code signing account")
model CodeSigningAccountPatchProperties {
  @doc("SKU of the code signing account")
  sku?: AccountSku;
}

@doc("Properties of the certificate profile")
model CertificateProfileProperties {
  @doc("Profile type of the certificate")
  profileType: ProfileType;

  @doc("Used as CN in the subject name of the certificate")
  commonName: string;

  @doc("Used as O in the subject name of the certificate")
  organization: string;

  @doc("Used as OU in the subject name of the private trust certificate")
  organizationUnit?: string;

  @visibility("read")
  streetAddress?: string;

  @doc("Whether to include in the public trust certificate subject name")
  includeStreetAddress?: boolean = false;

  @visibility("read")
  state?: string;

  @doc("Whether to include in the public trust or private trust certificate subject name")
  includeState?: boolean = false;

  @visibility("read")
  city?: string;

  @doc("Whether to include in the public trust or private trust certificate subject name")
  includeCity?: boolean = false;

  @visibility("read")
  postalCode?: string;

  @doc("Whether to include in the public trust certificate subject name")
  includePostalCode?: boolean = false;

  @visibility("read")
  country?: string;

  @doc("Whether to include in the public trust or private trust certificate subject name")
  includeCountry?: boolean = false;

  @doc("Enhanced key usage of the certificate")
  @visibility("read")
  enhancedKeyUsage?: string;

  @visibility("read")
  identityValidationId?: string;

  @doc("Provisioning state of the code signing account")
  @visibility("read")
  provisioningState?: ProvisioningState;

  @doc("Status of the certificate profiles")
  @visibility("read")
  status?: CertificateProfileStatus;

  @visibility("read")
  certificates?: Certificate[];
}

@doc("Properties of the certificate")
model Certificate {
  @doc("Serial number of the certificate")
  serialNumber?: string;

  @doc("Subject name of the certificate")
  subjectName?: string;

  @doc("Thumbprint of the certificate")
  thumbprint?: string;

  @doc("Certificate created date")
  createdDate?: string;

  @doc("Certificate expiry date")
  expiryDate?: string;

  @doc("Status of the certificate")
  status?: CertificateStatus;

  @doc("Revocations history of a certificate")
  revocation?: Revocation;
}

@doc("Revocations history of a certificate")
model Revocation {
  @doc("The timestamp when the revocation is requested")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  requestedAt?: utcDateTime;

  @doc("The timestamp when the revocation is effective")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  effectiveAt?: utcDateTime;

  @doc("Reason for revocation")
  reason?: string;

  @doc("Remarks for the revocation")
  remarks?: string;

  @doc("Status of the revocation")
  status?: RevocationStatus;

  @doc("Reason for the revocation failure")
  failureReason?: string;
}

@doc("Defines the certificate revoke properties.")
model RevokeCertificate {
  @doc("Serial number of the certificate")
  serialNumber: string;

  @doc("Thumbprint of the certificate")
  thumbprint: string;

  @doc("The timestamp when the revocation is effective")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  effectiveAt: utcDateTime;

  @doc("Reason for revocation")
  reason: string;

  @doc("Remarks for the revocation")
  remarks?: string;
}

@doc("The parameters used to check the availability of the code signing account name.")
model CheckNameAvailability {
  @doc("Code signing account name.")
  name: string;
}

@doc("The CheckNameAvailability operation response.")
model CheckNameAvailabilityResult {
  @doc("A boolean value that indicates whether the name is available for you to use. If true, the name is available. If false, the name has already been taken or is invalid and cannot be used.")
  @visibility("read")
  nameAvailable?: boolean;

  @doc("The reason that a code signing account name could not be used. The Reason element is only returned if nameAvailable is false.")
  @visibility("read")
  reason?: NameUnavailabilityReason;

  @doc("An error message explaining the Reason value in more detail.")
  @visibility("read")
  message?: string;
}