import "@typespec/rest";
import "@typespec/http";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.ResourceManager;

namespace Microsoft.TypeSpace;

@subscriptionResource
model NameSpace is ProxyResource<NameSpaceProperties> {
  @doc("The namespace")
  @key("nameSpaceName")
  @segment("nameSpaces")
  @path
  @visibility("read")
  name: string;
}

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "This is a tenant level proxy resource type where provisioning state doesn't apply"
@doc("The properties of the namespace")
model NameSpaceProperties {
  @doc("The namespace")
  nameSpace: string;
  @doc("The list of types under the namespace")
  types: string[];
}

@subscriptionResource
@parentResource(NameSpace)
model Type is ProxyResource<TypeProperties> {
  @doc("The name of the type")
  @key("typeName")
  @segment("types")
  @visibility("read")
  @path
  name: string;
}

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "This is a tenant level proxy resource type where provisioning state doesn't apply"
@doc("The properties of the type")
model TypeProperties {
  @doc("The resource type namespace")
  nameSpace: string;
  @doc("The resource type name")
  type: string;
  @doc("The list of API versions for the type")
  versions: string[];
}

@subscriptionResource
@parentResource(Type)
model Version is ProxyResource<VersionProperties> {
  @doc("The version of the type")
  @key("version")
  @segment("versions")
  @visibility("read")
  @path
  name: string;
}

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "This is a tenant level proxy resource type where provisioning state doesn't apply"
@doc("The properties of the version")
model VersionProperties {
  @doc("The resource namespace")
  nameSpace: string;
  @doc("The resource type")
  type: string;
  @doc("The list of operations under the API version")
  operations: string[];
}

@subscriptionResource
@parentResource(Type)
model Annotation is ProxyResource<AnnotationProperties> {
  @doc("The annotations of the type")
  @key("annotationName")
  @segment("annotations")
  @visibility("read")
  @path
  name: string;
}

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "This is a tenant level proxy resource type where provisioning state doesn't apply"
@doc("The properties of the annotations")
model AnnotationProperties {
  @doc("The resource namespace")
  nameSpace: string;
  @doc("The resource type")
  type: string;
  @doc("The annotation")
  annotation: string;
  @doc("The annotation values for each property path")
  values: Record<string>;
}

@subscriptionResource
@parentResource(Version)
model Operation is ProxyResource<OperationProperties> {
  @doc("The name of the operation")
  @pattern("^[a-zA-Z0-9-]{3,50}$")
  @key("operation")
  @segment("operations")
  @visibility("read")
  @path
  name: string;
}

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "This is a tenant level proxy resource type where provisioning state doesn't apply"
@doc("The properties of the resource operation")
model OperationProperties {
  @doc("The resource namespace, ex. Microsoft.Compute")
  nameSpace: string;
  @doc("The resource type, ex. virtualMachines")
  type: string;
  @doc("The API Version")
  version: string;
  @doc("The operation ID, ex. /Microsoft.Computey/virtualMachines/2022-11-01/GET/200")
  operationId: string;
  @doc("The operation name, ex. GET")
  operation: string;
  @doc("The possible response codes")
  responseCode: string;
  @doc("The properties of the resource type")
  typeProperties: Record<TypePropertyBag>;
}

@doc("The property bag of the resource type")
model TypePropertyBag {
    @doc("The type of the resource property, ex. string")
    type: string;
    @doc("The property flags of the resource property")
    propertyFlags?: string[];
    @doc("The defaultValue of the property, TODO: make required when enum is in propertyFlag")
    defaultValue?: string;
    @doc("The enum storing all values of the property, TODO: make required when enum is in propertyFlag")
    enums?: string[];
}
