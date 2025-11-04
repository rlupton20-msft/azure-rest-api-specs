import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./CodeSigningAccount.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;
using Versioning;

namespace Microsoft.CodeSigning;
@doc("Certificate profile resource.")
@parentResource(CodeSigningAccount)
model CertificateProfile is ProxyResource<CertificateProfileProperties> {
  @doc("Certificate profile name.")
  @pattern("^(?=.{5,100}$)[^0-9][A-Za-z0-9]+(?:-[A-Za-z0-9]+)*$")
  @path
  @key("profileName")
  @segment("certificateProfiles")
  name: string;
}

@armResourceOperations
interface CertificateProfiles {
  @doc("Get details of a certificate profile.")
  get is ArmResourceRead<CertificateProfile>;

  @doc("Create a certificate profile.")
  create is ArmResourceCreateOrReplaceAsync<CertificateProfile>;

  @doc("Delete a certificate profile.")
  delete is ArmResourceDeleteWithoutOkAsync<CertificateProfile>;

  @doc("List certificate profiles under a trusted signing account.")
  listByCodeSigningAccount is ArmResourceListByParent<CertificateProfile>;

  @doc("Revoke a certificate under a certificate profile.")
  @removed(Versions.v2025_07_30_preview)
  @added(Versions.v2025_10_13)
  @removed(Versions.v2025_11_20_preview)
  revokeCertificate is ArmResourceActionNoContentSync<
    CertificateProfile,
    RevokeCertificate
  >;

  @doc("Revokes certificates under a certificate profile.")
  @added(Versions.v2025_07_30_preview)
  @removed(Versions.v2025_10_13)
  @added(Versions.v2025_11_20_preview)
  revokeCertificates is ArmResourceActionNoContentSync<
    CertificateProfile,
    RevokeCertificateList
  >;
}

@@doc(CertificateProfiles.create::parameters.resource,
  "Parameters to create the certificate profile"
);
@@doc(CertificateProfiles.revokeCertificate::parameters.body,
  "Parameters to revoke a certificate in the certificate profile"
);
@@doc(CertificateProfiles.revokeCertificates::parameters.body,
  "Parameters to revoke the certificates in the certificate profile"
);
