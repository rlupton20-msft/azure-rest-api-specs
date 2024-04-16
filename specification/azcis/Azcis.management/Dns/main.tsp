import "../versions.tsp";
import "./addressrecord.tsp";
import "./apslbvip.tsp";
import "./canonicalnamerecord.tsp";
import "./ptrrecord.tsp";
import "./servicerecord.tsp";

using TypeSpec.Versioning;
using Azure.ResourceManager;

#suppress "@azure-tools/typespec-azure-core/casing-style" "The names of Namespace types must use PascalCaseTypeSpec"
@armProviderNamespace
@service({
  title: "Azure CIS - Dns",
})
@doc("Dns Service")
@versioned(Microsoft.AzureCis.Versions)
namespace Microsoft.AzureCis;

interface Operations extends Azure.ResourceManager.Operations {}
