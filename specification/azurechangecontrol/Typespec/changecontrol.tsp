import "@typespec/rest";
import "@typespec/http";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.Core;
using Azure.ResourceManager;

namespace Microsoft.AzureChangeControl;

@doc("A AzureChangeControlProviderHub resource")
model ChangeControl is TrackedResource<ChangeControlProperties> {
    @pattern("^[a-zA-Z0-9-]{3,24}$")
    @key("changeControlName")
    @segment("changeControls")
    @path
    @visibility("read")
    @minLength(3)
    @maxLength(128)
    @doc("The name of the change control")
    name: string;
}

@doc("The time window")
model TimeWindow
{
    @doc("The start time")
    startTime: utcDateTime;

    @doc("The end time")
    endTime: utcDateTime;
}

@doc("The target link")
model TargetLink
{
    @doc("target operation")
    operation: string;

    @doc("target resource id")
    resourceId: string;
}

@doc("Details of the AzureChangeControl ChangeControl.")
model ChangeControlProperties {
    @visibility("read")
    @doc("The status of the last operation.")
    provisioningState?: ProvisioningState;

    @doc("The change control kind")
    changeKind: ChangeKind;

    @doc("Validity period of the change control.")
    validityPeriod: TimeWindow;

    @doc("The external change reference.")
    changeReference?: string;

    @doc("The external service reference.")
    serviceReference?: string;

    @doc("Linked change control targets")
    @OpenAPI.extension("x-ms-identifiers", [])
    targets?: TargetLink[];

    @doc("The change control description")
    changeDescription?: string;
}

@doc("The status of the current operation.")
@Azure.Core.lroStatus
union ProvisioningState {
    @doc("Initial provisioning in progress")
    Provisioning: "Provisioning",

    @doc("Update in progress")
    Updating: "Updating",

    @doc("Deletion in progress")
    Deleting: "Deleting",

    @doc("Change accepted for processing")
    Accepted: "Accepted",

    @doc("Provisioning succeeded")
    Succeeded: "Succeeded",

    @doc("Provisioning failed")
    Failed: "Failed",

    @doc("Provisioning canceled")
    Canceled: "Canceled",
}

@doc("The ARM operation.")
union ARMOperation {
    @doc("ARM Delete operation.")
    Delete: "Delete",
}

@doc("The type of change being made.")
union ChangeKind {
    @doc("A breakglass scenario change.")
    Breakglass: "Breakglass",
}

@doc("The validation result.")
model IsValidResult {
    @doc("Validation result.")
    isValid: boolean;
    
    @doc("The validation errors.")
    validationErrors?: string;
}

@doc("The validation request.")
model IsValidRequest {
    @doc("The ARM operation.")
    operation: ARMOperation;
    
    @doc("The resourceId.")
    resourceId: string;
}

interface Operations extends Azure.ResourceManager.Operations {}

@armResourceOperations(ChangeControl)
interface ChangeControls {
    get is ArmResourceRead<ChangeControl>;
    createOrUpdate is ArmResourceCreateOrReplaceAsync<ChangeControl>;
    update is ArmResourcePatchSync<ChangeControl, ChangeControlProperties>;
    delete is ArmResourceDeleteSync<ChangeControl>;
    listByResourceGroup is ArmResourceListByParent<ChangeControl>;
    listBySubscription is ArmListBySubscription<ChangeControl>;
    
    @doc("Check if ChangeControl is valid")
    @action("isValid")
    isValid is ArmResourceActionAsync<ChangeControl, IsValidRequest, IsValidResult>;
}