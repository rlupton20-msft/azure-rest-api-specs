import "@typespec/http";
import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";

using TypeSpec.OpenAPI;
using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.Core;
using Azure.ResourceManager;

namespace Private.Edge;

// Don't merge in Microsoft.Edge, Only for Demo/POC purpose.
@doc("Solution Instance Validation Status")
union ValidationStatus {
  @doc("Solution Instance is valid")
  Valid: "Valid",

  @doc("Solution Instance is invalid")
  Invalid: "Invalid",

  string,
}