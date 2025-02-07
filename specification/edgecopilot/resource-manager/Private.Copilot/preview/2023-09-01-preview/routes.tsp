// FIXME: Operations in this file are not detected as a resource operation, please confirm the conversion result manually

import "@azure-tools/typespec-azure-core";
import "@typespec/rest";
import "./models.tsp";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.ResourceManager;
using TypeSpec.OpenAPI;

namespace Private.Copilot;

@armResourceOperations
interface Edge {
  #suppress "@azure-tools/typespec-azure-core/no-openapi" ""
  @extension("x-ms-examples", {
    "PostChat": {
      "$ref": "./examples/PostChat.json"
    }
  })
  /**
   * Post a message to chatbot
   */
  @autoRoute
  chat is ArmProviderActionSync<
    Request = ChatRequest,
    Response = ChatResponse,
    Scope = SubscriptionActionScope,
    Parameters = LocationParameter
  >;
}
