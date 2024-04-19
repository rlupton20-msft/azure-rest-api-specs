import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-autorest";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Http;
using TypeSpec.Rest;
using OpenAPI;
using Azure.ResourceManager;
using Autorest;

namespace Microsoft.AzureCis;

@doc("storageAccountDsms properties.")
model StorageAccountDsmsResourceProperties {
  @doc("Gets or sets the root path of the certificate.")
  rootPath: string;

  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-duplicate-property" "Duplicate property found in the resource envelope and resource properties."
  @doc("Gets or sets name.")
  name: string;

  @doc("Description to this xstore account.")
  description: string;

  @doc("Subscription alias.")
  subscriptionAlias: string;

  @doc("Subscription ID to use this xstore account.")
  subscriptionId?: string;

  @doc("Storage account resource provider. Valid values are \"Classic\", \"ARM\".")
  resourceProvider: string;

  @doc("Label of this xstore account.")
  label: string;

  @doc("Location of this storage account.")
  location?: string;

  @doc("Storage account resource group name.")
  resourceGroupName?: string;

  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-duplicate-property" "Duplicate property found in the resource envelope and resource properties."
  @doc("Properties")
  @extension("x-ms-identifiers", [])
  properties?: Property[];

  @doc("Provisioning state")
  @visibility("read")
  provisioningState?: StorageAccountDsmsProvisioningState;
}

@doc("Defines the property element.")
model Property {
  @doc("Gets or sets the name of the property.")
  name?: string;

  @doc("Gets or sets the value of the property.")
  value?: string;
}

@doc("Defines where the secret should be replicated to.")
model Replicate {
  @doc("Local: This secret is not replicated to other dSMS instance. AllDsmsRegions: This secret can be replicated to all dSMS instances. SpecifiedDsmsRegions: This secret can only be replicated to the specified dSMS instances.")
  type?: string;

  @doc("Gets or sets the regions the secret will be replicated to (Applicable when the type of replication is SpecifiedDsmsRegions). Regions are separated by semicolon.")
  values?: string;
}

@doc("Sas Key Information.")
model AccountSasInfo {
  @doc("dSMS root folder.")
  rootPath?: string;

  @doc("Name of the storage account.")
  name?: string;

  @doc("Path in Dsms endpoint. If this specified, then RootPath and Name should be ignored.")
  dsmsLocation?: string;

  @doc("The signed permissions for the account SAS. Possible values include: Read (r), Write (w), Delete (d), List (l), Add (a), Create (c), Update (u) and Process (p).")
  signedPermissions?: string;

  @doc("Services like blob(b), queue(q) and table(t).")
  signedServices?: string;

  @doc("The signed resource types that are accessible with the account SAS. Service (s)/Container (c)/Object (o).")
  signedResourceTypes?: string;
}

@doc("storageAccounts Resource")
model StorageAccountDsmsResource
  is ProxyResource<StorageAccountDsmsResourceProperties> { // This can be TrackedResource based on resourcetype
  @doc("The name of resource.")
  @pattern("^[a-zA-Z0-9-]{3,80}$")
  @key("resourceName")
  @segment("storageAccountDsmss") // Start with lower case. Should be plural
  @visibility("read")
  @path
  name: string;
}

#suppress "@azure-tools/typespec-azure-resource-manager/no-resource-delete-operation" "The resource must have a delete operation.TypeSpec"
@armResourceOperations
interface StorageAccountDsms {
  createOrUpdate is ArmResourceCreateOrUpdateAsync<StorageAccountDsmsResource>;
  listBySubscription is ArmListBySubscription<StorageAccountDsmsResource>;
  listByResourceGroup is ArmResourceListByParent<StorageAccountDsmsResource>;
  get is ArmResourceRead<StorageAccountDsmsResource>;
}
