import "@typespec/http";
import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "./extendedLocation.tsp";
import "./provisioningState.tsp";
import "./authenticationMethod.tsp";
import "./sharedDeviceProperties.tsp";

using TypeSpec.Versioning;
using OpenAPI;

namespace Private.DeviceRegistry;

@removed(Versions.v2024_10_01_preview)
@added(Versions.v2024_11_01)
@doc("Defines the Asset Endpoint Profile properties.")
model AssetEndpointProfileProperties {
  @doc("Globally unique, immutable, non-reusable id.")
  @visibility(Lifecycle.Read)
  uuid?: string;

  @doc("The local valid URI specifying the network address/DNS name of a southbound device. The scheme part of the targetAddress URI specifies the type of the device. The additionalConfiguration field holds further connector type specific configuration.")
  targetAddress: url;

  @doc("Defines the configuration for the connector type that is being used with the endpoint profile.")
  @added(Versions.v2024_07_01_preview)
  endpointProfileType: string;

  @doc("Defines the client authentication mechanism to the server.")
  @removed(Versions.v2024_07_01_preview)
  userAuthentication?: Authentication;

  @doc("Defines the client authentication mechanism to the server.")
  @added(Versions.v2024_07_01_preview)
  authentication?: Authentication;

  @doc("Defines the authentication mechanism for the southbound connector connecting to the shop floor/OT device.")
  @removed(Versions.v2024_07_01_preview)
  transportAuthentication?: TransportAuthentication;

  @doc("Stringified JSON that contains connectivity type specific further configuration (e.g. OPC UA, Modbus, ONVIF).")
  additionalConfiguration?: string;

  @doc("Reference to a discovered asset endpoint profile. Populated only if the asset endpoint profile has been created from discovery flow. Discovered asset endpoint profile name must be provided.")
  @visibility(Lifecycle.Read, Lifecycle.Create)
  @added(Versions.v2024_07_01_preview)
  discoveredAssetEndpointProfileRef?: string;

  @doc("Read only object to reflect changes that have occurred on the Edge. Similar to Kubernetes status property for custom resources.")
  @visibility(Lifecycle.Read)
  @added(Versions.v2024_07_01_preview)
  status?: AssetEndpointProfileStatus;

  @doc("Provisioning state of the resource.")
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningState;
}

@removed(Versions.v2024_10_01_preview)
@added(Versions.v2024_11_01)
@doc("Definition of the client authentication mechanism to the server.")
@renamedFrom(Versions.v2024_07_01_preview, "UserAuthentication")
model Authentication {
  @doc("Defines the method to authenticate the user of the client at the server.")
  @renamedFrom(Versions.v2024_07_01_preview, "mode")
  // Default mode is Certificate
  method: AuthenticationMethod = AuthenticationMethod.Certificate;

  @doc("Defines the username and password references when UsernamePassword user authentication mode is selected.")
  usernamePasswordCredentials?: UsernamePasswordCredentials;

  @doc("Defines the certificate reference when Certificate user authentication mode is selected.")
  x509Credentials?: X509Credentials;
}

@doc("Definition of the authentication mechanism for the southbound connector.")
@removed(Versions.v2024_07_01_preview)
model TransportAuthentication {
  @doc("Defines a reference to a secret which contains all certificates and private keys that can be used by the southbound connector connecting to the shop floor/OT device. The accepted extensions are .der for certificates and .pfx/.pem for private keys.")
  @extension("x-ms-identifiers", #[])
  @removed(Versions.v2024_07_01_preview)
  ownCertificates: OwnCertificate[];
}

@doc("Certificate or private key that can be used by the southbound connector connecting to the shop floor/OT device. The accepted extensions are .der for certificates and .pfx/.pem for private keys.")
@removed(Versions.v2024_07_01_preview)
model OwnCertificate {
  @doc("Certificate thumbprint.")
  certThumbprint?: string;

  @doc("Secret Reference name (cert and private key).")
  certSecretReference?: string;

  @doc("Secret Reference Name (Pfx or Pem password).")
  certPasswordReference?: string;
}

@doc("Defines the asset endpoint profile status properties.")
@added(Versions.v2024_07_01_preview)
@removed(Versions.v2024_10_01_preview)
@added(Versions.v2024_11_01)
model AssetEndpointProfileStatus {
  @doc("Array object to transfer and persist errors that originate from the Edge.")
  @extension("x-ms-identifiers", #[])
  @visibility(Lifecycle.Read)
  errors?: AssetEndpointProfileStatusError[];
}

@doc("Defines the asset endpoint profile status error properties.")
@added(Versions.v2024_07_01_preview)
@removed(Versions.v2024_10_01_preview)
@added(Versions.v2024_11_01)
model AssetEndpointProfileStatusError {
  @doc("Error code for classification of errors (ex: 400, 404, 500, etc.).")
  @visibility(Lifecycle.Read)
  code?: int32;

  @doc("Human readable helpful error message to provide additional context for error (ex: “targetAddress 'foo' is not a valid url”).")
  @visibility(Lifecycle.Read)
  message?: string;
}
