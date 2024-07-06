import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.Core;
using Azure.ResourceManager;

// Define a model for the approval request
@doc("Request to the action call to handle approval status")
model ApprovalCallbackRequest {
  @doc("Resource Id of the item being approved or declined")
  resourceId: string;

  @doc("Resource reuest action indicating actin which need to be performed at post-action")
  resourceRequestAction: "Approved" | "Declined" | "Create" | "Delete" | "Update" | "Reset" | string;

  @doc("Approval status indicating 'Approved' or 'Declined'")
  approvalStatus: "Approved" | "Declined" | string;
}

// Define a model for the approval response
@doc("Response after handling the approval status")
model ApprovalCallbackResponse {
  @doc("Confirmation message indicating the result of the operation.")
  message: string;
}
