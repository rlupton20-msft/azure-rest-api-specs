import "@typespec/rest";
import "@typespec/http";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;

namespace Microsoft.SaaSHub;

interface Operations extends Azure.ResourceManager.Operations {}

/**
 * Indicates whether auto renewal is turned on or off for a SaaSHub cloud service. The default value will be 'On' for products that support autorenew.
 */
union AutoRenew {
  string,
  Off: "Off",
  On: "On",
}

/**
 * The policy override for the resource indicates whether the self-serve cancellation or seat reduction is allowed.
 */
union Cancellation {
  string,
  Allowed: "Allowed",
  NotAllowed: "NotAllowed",
}

/**
 * Gets the status of the SaaSHub cloud service at the time the operation was called.
 */
union ProvisioningState {
  string,
  Succeeded: "Succeeded",
  Failed: "Failed",
  Canceled: "Canceled",
  Accepted: "Accepted",
  Processing: "Processing",
  Updating: "Updating",
  Unknown: "Unknown",
}

/**
 * The status of the cloud service.
 */
union SaasResourceStatus {
  string,
  Unknown: "Unknown",
  Active: "Active",
  Disabled: "Disabled",
  Deleted: "Deleted",
  PastDue: "PastDue",
  Expiring: "Expiring",
  Expired: "Expired",
  AutoRenew: "AutoRenew",
  Cancelled: "Cancelled",
  Suspended: "Suspended",
}

/**
 * Whether the validation passed/failed.
 */
union EvaluateResult {
  string,
  Unknown: "Unknown",
  Passed: "Passed",
  Failed: "Failed",
}

/**
 * True if user is eligible for this promotion, false otherwise
 */
union EligibilityResult {
  string,
  Ineligible: "Ineligible",
  Eligible: "Eligible",
}

/**
 * Whether the target is cloud resource or contract.
 */
union CoTermTargetType {
  string,
  Resource: "Resource",
  Contract: "Contract",
}

/**
 * Type of the offer for which the cloud service is purchased
 */
union OfferType{
  string,
  Paid: "Paid",
  Trial: "Trial",
  Free: "Free",
}

/**
 * The properties of a SaaSHub cloud service.
 */
model SaasResourceProperties {
  /**
   * Indicates whether auto renewal is turned on or off for a SaaSHub cloud service. The default value will be 'On' for products that support autorenew.
   */
  autoRenew?: AutoRenew;

  /**
   * The billing scope to use for purchasing the resource. Needs full billing scope to invoice section level like: providers/Microsoft.Billing/billingAccounts/{baId}/billingProfiles/{bfId}/invoiceSections/{isId}
   */
  billingScope?: string;

  /**
   * The billing subscription id linked to this resource, with full format like /providers/Microsoft.Billing/billingAccounts/1111:2222/billingSubscriptions/Id
   */
  @visibility("read")
  billingSubscriptionId?: string;

  /**
   * The end customer billing account in CSP scenario, will full format like /providers/Microsoft.Billing/billingAccounts/1111:2222
   */
  endCustomerBillingAccount?: string;

  /**
   * System imposed policies that regulate behavior of the resource.
   */
  systemOverrides?: SaasResourcePropertiesSystemOverrides;

  /**
   * The name of the cloud service.
   */
  displayName?: string;

  /**
   * Type of the product for which the cloud service is purchased
   */
  @visibility("read")
  productType?: string;

  /**
   * Type of the offer for which the cloud service is purchased
   */
  @visibility("read")
  offerType?: OfferType;

  /**
   * Product Universal Product Number of the product
   */
  productCode?: string;

  /**
   * License data of the product
   */
  @visibility("read")
  licenseData?: string;

  /**
   * Gets the status of the SaaSHub cloud service at the time the operation was called.
   */
  @visibility("read")
  provisioningState?: ProvisioningState;

  /**
   * The number of licenses purchased for the cloud service
   */
  quantity?: int64;

  /**
   * Renewal term details of the cloud service.
   */
  renewalTerm?: RenewalTermDetails;

  /**
   * The SKU description of the product for which the cloud service is purchased.
   */
  @visibility("read")
  skuDescription?: string;

  /**
   * The status of the cloud service.
   */
  @visibility("read")
  status?: SaasResourceStatus;

  /**
   * The suspension reason for a cloud service.
   */
  @visibility("read")
  suspensionReasons?: string[];

  /**
   * Term details of the cloud service.
   */
  term?: TermDetails;

  /**
   * The original resource uri, if the new resource will be created by splitting part of the licenses from an existing resource
   */
  originalResourceUri?: string;

  /**
   * The Id of the tenant where licenses will be provisioned for this resource. It will only be populated if licenses are provisioned in a different tenant.
   */
  provisioningTenantId?: string;

  /**
   * An external Id which could be used to reference other commcerce system entity, such as OMS sub id or proposal id. ExternalId value will have "{externalSystem}:{externalId}", e.g. "oms:1111-2222-444-666"
   */
  externalId?: string;
}

/**
 * System imposed policies that regulate behavior of the resource.
 */
model SaasResourcePropertiesSystemOverrides {
  /**
   * The policy override for the resource indicates whether the self-serve cancellation or seat reduction is allowed.
   */
  @visibility("read")
  cancellation?: Cancellation;

  /**
   * The end date in UTC time by when the self-serve cancellation ends.
   */
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  cancellationAllowedEndDate?: utcDateTime;
}

/**
 * Renewal term details of the cloud service.
 */
model RenewalTermDetails {
  /**
   * The number of licenses purchased for the cloud service
   */
  quantity?: int64;

  /**
   * Upn value of the product, which can be used to resolve product Id/sku Id/availability Id/term Id
   */
  productCode?: string;

  /**
   * Billing frequency of the product under the cloud service. Example P1Y and P1M
   */
  @visibility("read")
  billingFrequency?: string;

  /**
   * The duration for which you can use the cloud service. Example P1Y and P1M
   */
  @visibility("read")
  termUnit?: string;

  /**
   * End date of the term in UTC time. It can be patched for co-term scenario, the time part passed in will be ignored
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  endDate?: utcDateTime;
}

/**
 * Term details of the cloud service.
 */
model TermDetails {
  /**
   * Billing frequency of the product under the cloud service. Example P1Y and P1M
   */
  @visibility("read")
  billingFrequency?: string;

  /**
   * The duration for which you can use the cloud service. Example P1Y and P1M
   */
  @visibility("read")
  termUnit?: string;

  /**
   * Start date of the term in UTC time.
   */
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  startDate?: utcDateTime;

  /**
   * End date of the term in UTC time. When there is a value passed in for PUT scenario, it is to support co-term scenario. When there is a value passed in for PATCH scenario, it is to support extend trial scenario. The time part passed in will be ignored
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  endDate?: utcDateTime;
}

/**
 * Request to check if the resource can be created
 */
model CanCreateRequest is SaasResource {
}

/**
 * Validation result for canCreate operation.
 */
model CanCreateResult {
  /**
   * Whether the validation passed/failed.
   */
  @visibility("read")
  evaluateResult?: EvaluateResult;

  /**
   * ReasonCode for why the request payload failed validation. Null when validation passed.
   */
  @visibility("read")
  reasonCode?: string;

  /**
   * Detailed reason for why the request payload failed validation. Null when validation passed.
   */
  @visibility("read")
  reason?: string;

  /**
   * Additional information for failed validation.
   */
  @visibility("read")
  additionalInfo?: CanCreateResultAdditionalInfo;
}

/**
 * Additional information for failed validation.
 */
model CanCreateResultAdditionalInfo {
  /**
   * Additional detail when request payload failed addOn constraints. Null when constraints passed or not applicable.
   */
  @visibility("read")
  addOn?: CanCreateResultAddOnInfo;

  /**
   * Additional detail when request payload failed promotion constraints. Null when constraints passed or not applicable.
   */
  @visibility("read")
  promotion?: CanCreateResultPromotionInfo[];

  /**
   * Additional evaluation eligibility result for qualifying co-term resources for a future price concession. Null when constraints passed or not applicable.
   */
  @visibility("read")
  futurePrice?: CanCreateResultFuturePriceInfo[];

  /**
   * Additional detail when request payload failed coTerm constraints. Null when constraints passed or not applicable.
   */
  @visibility("read")
  coTermDates?: CoTermDateEligibilityResult[];
}

/**
 * Additional detail when request payload failed addOn constraints. Null when constraints passed or not applicable.
 */
model CanCreateResultAddOnInfo {
  /**
   * AddOn ineligible reasons.
   */
  @visibility("read")
  ineligibilityReasons?: string[];

  /**
   * AddOn eligibility constraints.
   */
  @visibility("read")
  eligibilityConstraints?: EligibilityConstraint[];
}

/**
 * Shared eligibility constraint model.
 */
model EligibilityConstraint {
  /**
   * The failed eligibility constraint type.
   */
  @visibility("read")
  constraintType?: string;

  /**
   * true if eligibility is satisfied, false otherwise
   */
  @visibility("read")
  isEligible?: EligibilityResult;
}

/**
 * Model to present promotion eligibility info.
 */
model CanCreateResultPromotionInfo {
  /**
   * Promotion id.
   */
  @visibility("read")
  promotionId?: string;

  /**
   * True if user is eligible for this promotion, false otherwise
   */
  @visibility("read")
  isEligible?: EligibilityResult;

  /**
   * Promotion ineligible reasons.
   */
  @visibility("read")
  ineligibilityReasons?: string[];

  /**
   * Promotion eligibility constraints.
   */
  @visibility("read")
  eligibilityConstraints?: EligibilityConstraint[];
}

/**
 * Model to present additional info about future price eligibility
 */
model CanCreateResultFuturePriceInfo {
  /**
   * The term end date in UTC time, for resources in this group.
   */
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  termEndDate?: utcDateTime;

  /**
   * Total cumulative quantity of licenses for resources in this group.
   */
  @visibility("read")
  totalQuantity?: int64;

  /**
   * Whether the future price concession eligibility is satisfied by subscriptions in this group
   */
  @visibility("read")
  isEligible?: EligibilityResult;

  /**
   * List of qualifying resources for the future price concession
   */
  @visibility("read")
  qualifyingResources?: CanCreateResultFuturePriceQualifyingResource[];

  /**
   * Types of future price concession. E.g. FuturePriceNotToExceedCap, PercentageDiscount
   */
  @visibility("read")
  futurePriceConcessionTypes?: string[];

  /**
   * Minimum number of seats required to be eligible for the future price concession
   */
  @visibility("read")
  minimumQuantityRequired?: int64;
}

/**
 * Model to represent the future price qualified resource
 */
model CanCreateResultFuturePriceQualifyingResource {
  /**
   * Qualifying resource names
   */
  @visibility("read")
  resourceName?: string;
}

/**
 * Additional information for failed validation.
 */
model CoTermDateEligibilityResult {
  /**
   * Target cloud resource or contract name to coTerm to.
   */
  @visibility("read")
  coTermTarget?: string;

  /**
   * Whether the target is cloud resource or contract.
   */
  @visibility("read")
  coTermTargetType?: CoTermTargetType;

  /**
   * CoTerm end date in UTC time.
   */
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  termEndDate?: utcDateTime;

  /**
   * CoTerm error details
   */
  @visibility("read")
  errorCode?: string;
}

/**
 * Validation result for canCancel operation.
 */
model CanCancelResult {
  /**
   * Whether the validation passed/failed.
   */
  @visibility("read")
  evaluateResult?: EvaluateResult;

  /**
   * ReasonCode for why the request payload failed validation. Null when validation passed.
   */
  @visibility("read")
  reasonCode?: string;

  /**
   * Detailed reason for why the request payload failed validation. Null when validation passed.
   */
  @visibility("read")
  reason?: string;

  /**
   * Additional information for failed validation.
   */
  @visibility("read")
  additionalInfo?: CanCancelResultAdditionalInfo;
}

/**
 * Additional information for failed validation.
 */
model CanCancelResultAdditionalInfo {
  /**
   * The end date in UTC time by when the self-serve cancellation ends.
   */
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  cancellationWindowEndTimestamp?: utcDateTime;
}

/**
 * Request to merge multiple cloud service resources into one target cloud service resource
 */
model MergeSaasResourceRequest {
  /**
   * List of source resources to be merged into target resource.
   */
  sourceResources?: MergeSourceSaasResource[];
}

/**
 * Cloud service to be used in merge operation as source.
 */
model MergeSourceSaasResource {
  /**
   * Id of the cloud service
   */
  id?: string;

  /**
   * The quantity of license to be merged
   */
  quantity?: int64;

  /**
   * The validation error it ran into. Null when validation passed.
   */
  @visibility("read")
  validationError?: string;
}

/**
 * Validation result for canMerge operation.
 */
model CanMergeResult {
  /**
   * Whether the validation passed/failed.
   */
  @visibility("read")
  evaluateResult?: EvaluateResult;

  /**
   * ReasonCode for why the request payload failed validation. Null when validation passed.
   */
  @visibility("read")
  reasonCode?: string;

  /**
   * Detailed reason for why the request payload failed validation. Null when validation passed.
   */
  @visibility("read")
  reason?: string;

  /**
   * Additional information for failed validation.
   */
  @visibility("read")
  additionalInfo?: MergeSourceSaasResource[];
}

/**
 * Validation result for canUpdate operation.
 */
model CanUpdateResult {
  /**
   * Whether the validation passed/failed.
   */
  @visibility("read")
  evaluateResult?: EvaluateResult;

  /**
   * ReasonCode for why the request payload failed validation. Null when validation passed.
   */
  @visibility("read")
  reasonCode?: string;

  /**
   * Detailed reason for why the request payload failed validation. Null when validation passed.
   */
  @visibility("read")
  reason?: string;

  /**
   * Update scenario that was identified based on the canUpdate request body values.
   */
  @visibility("read")
  updateScenario?: string;

  /**
   * Additional information for failed validation.
   */
  @visibility("read")
  additionalInfo?: CanUpdateResultAdditionalInfo;
}

/**
 * Additional information for failed validation.
 */
model CanUpdateResultAdditionalInfo {
  /**
   * Additional detail when request payload failed refundableQuantity constraints. Null when constraints passed or not applicable. Relevant scenarios: remove quantity.
   */
  @visibility("read")
  refundableQuantity?: RefundableQuantityResult;

  /**
   * Additional detail when request payload failed coTerm constraints. Null when constraints passed or not applicable. Relevant scenarios: coterm, scheduled conversion with coterm.
   */
  @visibility("read")
  coTermDates?: CoTermDateEligibilityResult[];
}

/**
 * Shared refundable quantity constraint model.
 */
model RefundableQuantityResult {
  /**
   * Total refundable quantity at the time of the evaluation.
   */
  @visibility("read")
  totalRefundableQuantity?: int64;

  /**
   * Batches of refundable quantity with their respective refund window end date.
   */
  @visibility("read")
  refundableQuantities?: RefundableQuantityResultRefundableQuantitiesInfo[];
}

/**
 * Model to present the refundable license infomation
 */
model RefundableQuantityResultRefundableQuantitiesInfo {
  /**
   * Refundable quantity within this window.
   */
  @visibility("read")
  quantity?: int64;

  /**
   * The end date in UTC time by when the refund window ends.
   */
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  returnWindowEndDateTime?: utcDateTime;
}
