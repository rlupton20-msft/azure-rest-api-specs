import "@azure-tools/typespec-azure-core";
import "@typespec/versioning";

using Azure.Core;
using TypeSpec.Versioning;

namespace Private.DeviceRegistry;

@doc("The mode to authenticate the user of the client at the server.")
union UserAuthenticationMode {
  @doc("The user authentication mode is anonymous.")
  Anonymous: "Anonymous",

  @doc("The user authentication mode is an x509 certificate.")
  Certificate: "Certificate",

  @doc("The user authentication mode is a username and password.")
  UsernamePassword: "UsernamePassword",

  string,
}
