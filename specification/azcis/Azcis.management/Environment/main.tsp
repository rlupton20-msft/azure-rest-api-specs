import "../versions.tsp";
import "./autopilotEnvironment.tsp";

using TypeSpec.Versioning;
using Azure.ResourceManager;

@armProviderNamespace
@service({
  title: "Azure CIS - AutopilotEnvironment",
})
@doc("Autopilot Environment Provider")
@versioned(Microsoft.AzureCis.Versions)
namespace Microsoft.AzureCis;

interface Operations extends Azure.ResourceManager.Operations {}
