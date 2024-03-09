import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "@typespec/http";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.Core;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.OpenAPI;

namespace Microsoft.PortalServices;
/**
 * The portal extension resource definition.
 */
model PortalTenantCompileFile is TrackedResource<PortalTenantCompileFileProperties> {
/**
 * The name of the portal tenant compile file.
 */
  @path
  @key("compilefile")
  @segment("compilefile")
  @visibility("read")
  name: string;
}

@armResourceOperations  
interface PortalTenantCompileFiles {
  @doc("Compile a file under the tenant")
  @route("/providers/Microsoft.PortalServices/compilefile")
  compileFile is ArmResourceActionSync<PortalTenantCompileFile, PortalTenantCompileFile, PortalTenantCompileFileResult>;
}