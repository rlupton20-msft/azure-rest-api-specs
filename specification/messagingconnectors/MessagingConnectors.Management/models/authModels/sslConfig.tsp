import "@typespec/http";
import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

namespace Private.MessagingConnectors.Models.Auth;

@doc("SslConfiguration Model.")
model SslConfiguration {
  @doc("Uri for keyvault which store the Certificate.")
  keyVaultUri?: string;

  @doc("Access token for keyVault.")
  @secret
  keyVaultToken?: string;

  @doc("Certificate Authority.")
  certCa?: string;

  @doc("Protocol version for ssl.")
  protocol?: string;

  @doc("Cipher Suites configuration.")
  cipherSuites?: string;

  @doc("Whether verify the server hostname with the certificate.")
  verifyHostname?: boolean;
}
