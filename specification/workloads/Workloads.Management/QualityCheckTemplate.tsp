import "@typespec/rest";
import "@typespec/http";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "./model.tsp";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.Core;
using Azure.ResourceManager;
using TypeSpec.OpenAPI;

#suppress "@azure-tools/typespec-azure-resource-manager/missing-operations-endpoint"
namespace Private.Workloads;

/** Quality Check Template as Proxy Resource */
model QualityCheckTemplate
  is ExtensionResource<QualityCheckTemplateProperties> {
  @doc("The name of the quality check template")
  @key("qualityCheckTemplate")
  @segment("qualityCheckTemplates")
  @pattern("^[a-zA-Z0-9-]{3,63}$")
  @path
  name: string;
}

@armResourceOperations
interface QualityCheckTemplates {
  update is ArmResourcePatchSync<
    QualityCheckTemplate,
    QualityCheckTemplateProperties
  >;
  get is ArmResourceRead<QualityCheckTemplate>;
  list is ArmResourceListByParent<QualityCheckTemplate>;
  delete is ArmResourceDeleteSync<QualityCheckTemplate>;
}
