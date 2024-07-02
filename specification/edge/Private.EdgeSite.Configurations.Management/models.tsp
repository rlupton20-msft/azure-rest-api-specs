import "@typespec/rest";
import "@typespec/http";
import "@typespec/openapi";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Rest;
using TypeSpec.Http;
using TypeSpec.OpenAPI;
using Azure.ResourceManager;

namespace Private.EdgeSite;

model Configuration is TrackedResource<ConfigurationProperties> {
    ...ResourceNameParameter<Configuration>;
}

@doc("Configuration Properties")
model ConfigurationProperties {
    @doc("Timezone")
    timezone: string;

    @doc("The status of the last operation.")
    @visibility("read")
    provisioningState?: ResourceProvisioningState;
}
