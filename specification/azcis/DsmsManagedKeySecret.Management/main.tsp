import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/versioning";

import "./versions.tsp";
import "./dsmsmanagedkeysecret.tsp";

using Azure.ResourceManager;
using TypeSpec.Versioning;

@armProviderNamespace
@service(#{ title: "Azure CIS FRP" })
@doc("https://eng.ms/docs/products/azcis-resource-provisioning/template-user-guide/resources/dsms/dsms-managed-key-secret-rt")
@versioned(Microsoft.AzureCis.Versions)
namespace Microsoft.AzureCis;

interface Operations extends Azure.ResourceManager.Operations {}

@doc("Provisioning status of the resource.")
union DsmsManagedKeySecretProvisioningState {
  string,
  ResourceProvisioningState,

  @doc("Accepted State")
  Accepted: "Accepted",
}
