import "@typespec/http";
import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "./extendedLocation.tsp";
import "./provisioningState.tsp";
import "./authenticationMethod.tsp";

using TypeSpec.Versioning;

namespace Private.DeviceRegistry;

@doc("The x509 certificate for authentication mode Certificate.")
model X509Credentials {
  @doc("A reference to secret containing the certificate and private key (e.g. stored as .der/.pem or .der/.pfx).")
  @removed(Versions.v2024_07_01_preview)
  certificateReference: string;

  @doc("The name of the secret containing the certificate and private key (e.g. stored as .der/.pem or .der/.pfx).")
  @added(Versions.v2024_07_01_preview)
  certificateSecretName: string;
}

@doc("The credentials for authentication mode UsernamePassword.")
model UsernamePasswordCredentials {
  @doc("A reference to secret containing the username.")
  @removed(Versions.v2024_07_01_preview)
  usernameReference: string;

  @doc("The name of the secret containing the username.")
  @added(Versions.v2024_07_01_preview)
  usernameSecretName: string;

  @doc("A reference to secret containing the password.")
  @removed(Versions.v2024_07_01_preview)
  passwordReference: string;

  @doc("The name of the secret containing the password.")
  @added(Versions.v2024_07_01_preview)
  passwordSecretName: string;
}

@doc("The x509 certificate for authentication mode Certificate.")
@added(Versions.v2025_10_01)
model X509CertificateCredentials {
  @doc("The name of the secret containing the certificate and private key (e.g. stored as .der/.pem or .der/.pfx).")
  certificateSecretName: string;

  @doc("The name of the secret containing the certificate private key in PEM or DER format.")
  keySecretName?: string;

  @doc("The name of the secret containing the combined intermediate certificates in PEM format.")
  intermediateCertificatesSecretName?: string;
}
