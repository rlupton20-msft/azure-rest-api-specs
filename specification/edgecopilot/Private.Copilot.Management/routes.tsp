// FIXME: Operations in this file are not detected as a resource operation, please confirm the conversion result manually

import "@typespec/rest";
import "@typespec/versioning";
import "@typespec/openapi";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "./models.tsp";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.ResourceManager;
using TypeSpec.Versioning;
using TypeSpec.OpenAPI;

namespace Private.Copilot;

@armResourceOperations
interface Edge {
  /**
   * Post a message to chatbot
   */
  @autoRoute
  chat is ArmProviderActionSync<
    Request = ChatRequest,
    Response = ChatResult,
    Scope = SubscriptionActionScope,
    Parameters = LocationParameter
  >;

  /**
   * Trigger a troubleshooting action
   */
  @added(Versions.v2025_06_01_preview)
  @autoRoute
  troubleshoot is ArmResourceActionSync<
    Resource = ExtensionResource<{}>,
    Request = ChatRequest,
    Response = ChatResult
  >;
}
