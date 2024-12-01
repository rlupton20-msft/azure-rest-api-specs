import "@typespec/http";
import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-providerhub";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.Core;
using Azure.ResourceManager;
using OpenAPI;

@armProviderNamespace("Microsoft.AzureMonitorEdge")
@service({
    title: "Azure Monitor Edge Resource Provider",
    version: "2023-06-21-privatepreview",
  })
@doc("Azure Monitor Edge Resource Provider API")
@useDependency(Azure.ResourceManager.Versions.v1_0_Preview_1)
namespace Microsoft.AzureMonitorEdge;

@doc("The provisioning state of a resource.")
@lroStatus
enum ProvisioningState {
    ...ResourceProvisioningState,

    @doc("The resource is being provisioned")
    Provisioning,

    @doc("The resource is updating")
    Updating,

    @doc("The resource is being deleted")
    Deleting,

    @doc("The resource create request has been accepted")
    Accepted,
}

@doc("extended location")
model ExtendedLocation {
    @doc("extended location resource id")
    name: string;

    @doc("extended location type: CustomLocation")
    type?: string;
}

interface Operations extends Azure.ResourceManager.Operations {}

