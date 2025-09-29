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

@doc("Internal state of resource")
union InternalState {
  @doc("Resource is pending validation")
  PendingValidation: "PendingValidation",

  @doc("Resource is validated")
  Validated: "Validated",

  string,
}
