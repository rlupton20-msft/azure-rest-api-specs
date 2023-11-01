import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-providerhub";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

import "../virtualEnclave/virtualenclave.tsp";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.Core;
using Azure.ResourceManager;

@doc("Request to fetch parameters based on a list of parameter names.")
model GetEnclaveMetadataRequest {
  @doc("List of parameter names to be fetched.")
  parameterNames: string[];
}

@doc("Response with fetched parameters.")
model GetEnclaveMetadataResponse {
  @doc("Dictionary of parameters names and their fetched values.")
  parameters: Record<string>;
}
