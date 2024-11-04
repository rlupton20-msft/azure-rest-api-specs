import "@typespec/http";
import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@azure-tools/typespec-autorest";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.Core;
using Azure.ResourceManager;
using OpenAPI;

@armProviderNamespace
@service({
  title: "Carbon",
})
@doc("Carbon Report Resource Provider query API.")
@versioned(Versions)
@armCommonTypesVersion(Azure.ResourceManager.CommonTypes.Versions.v5)
namespace Microsoft.Carbon;

/**
 * The available API versions.
 */
enum Versions {
  /**
   * The 2024-02-01-preview API version.
   */
  @useDependency(Azure.ResourceManager.Versions.v1_0_Preview_1)
  @useDependency(Azure.Core.Versions.v1_0_Preview_1)
  v2024_02_01_preview: "2024-02-01-preview",
}

interface Operations extends Azure.ResourceManager.Operations {}

@doc("Date range to be used with QueryParameter")
model DateRange {
  @doc("Start date parameter, format is yyyy-MM-01, it should first day of each month")
  start: plainDate;

  @doc("End date parameter, format is yyyy-MM-01, it should first day of each month")
  end: plainDate;
}

@doc("Supported category types to be used with QueryParameter")
union CategoryTypeEnum {
  @doc("Subscription level aggregation granularity")
  Subscription: "Subscription",

  @doc("ResourceGroup level aggregation granularity")
  ResourceGroup: "ResourceGroup",

  @doc("Location level aggregation granularity")
  Location: "Location",

  @doc("Resource level aggregation granularity")
  Resource: "Resource",

  @doc("ResourceType level aggregation granularity")
  ResourceType: "ResourceType",

  string,
}

@doc("Supported carbon emission scopes to be used with QueryParameter")
union EmissionScopeEnum {
  @doc("Scope1 carbon emission")
  Scope1: "Scope1",

  @doc("Scope2 carbon emission")
  Scope2: "Scope2",

  @doc("Scope3 carbon emission")
  Scope3: "Scope3",

  string,
}

@doc("Enum for Access Decision")
union AccessDecisionEnum {
  @doc("Access allowed")
  Allowed: "Allowed",

  @doc("Access denied")
  Denied: "Denied",

  string,
}

@doc("Enum for Report Type")
union ReportTypeEnum {
  @doc("OverallSummaryReport provide summary carbon emission for given query filter")
  OverallSummaryReport: "OverallSummaryReport",

  @doc("MonthlySummaryReport provide summary carbon emission by monthly for given query filter")
  MonthlySummaryReport: "MonthlySummaryReport",

  @doc("TopItemsSummaryReport provide Top N items summary report for given query filter")
  TopItemsSummaryReport: "TopItemsSummaryReport",

  @doc("TopItemsMonthlySummaryReport provide Top N items report by monthly for given query filter")
  TopItemsMonthlySummaryReport: "TopItemsMonthlySummaryReport",

  @doc("ItemDetailsReport provide item (like Resource/ResourceGroup/ResourceType/Location/Subscription) detail list for given query filter")
  ItemDetailsReport: "ItemDetailsReport",

  string,
}

@doc("Query filter parameter specified by users")
@discriminator("reportType")
model QueryFilter {
  @doc("Report type")
  reportType: ReportTypeEnum;

  @doc("The start date and end date for carbon emissions data, for ItemDetailsReport and TopItemsSummaryReport, it only support one month data, the startDate and endDate should be equal.")
  dateRange: DateRange;

  @doc("SubscriptionId list for carbon emissions data, subscriptionId should be all lower")
  @extension("x-ms-identifiers", [])
  subscriptionList: string[];

  @doc("resourceGroupUrl list for carbon emissions data, resourceGroupUrl value format is '/subscriptions/{subscriptionId}/resourcegroups/{resourceGroup}', all lower ")
  @extension("x-ms-identifiers", [])
  resourceGroupUrlList?: string[];

  @doc("resource type list for carbon emissions data, resource type value is like 'microsoft.storage/storageaccounts', all lower")
  @extension("x-ms-identifiers", [])
  resourceTypeList?: string[];

  @doc("Location list for carbon emissions data, for example 'east us', all lower")
  @extension("x-ms-identifiers", [])
  locationList?: string[];

  @doc("Carbon emission scope for carbon emissions data")
  @extension("x-ms-identifiers", [])
  carbonScopeList: EmissionScopeEnum[];
}

@doc("Query Parameters for Overall Carbon Emissions Summary")
model OverallSummaryReportQueryFilter extends QueryFilter {
  @doc("Overall summary report type name")
  reportType: ReportTypeEnum.OverallSummaryReport;
}

@doc("Query Parameters for Monthly Carbon Emissions Summary")
model MonthlySummaryReportQueryFilter extends QueryFilter {
  @doc("Monthly summary report type name")
  reportType: ReportTypeEnum.MonthlySummaryReport;
}

@doc("Query Parameters for Top Items Carbon Emission by Category Type")
model TopItemsSummaryReportQueryFilter extends QueryFilter {
  @doc("Top items summary report type name")
  reportType: ReportTypeEnum.TopItemsSummaryReport;

  @doc("Item Category type, see supported type value defined in CategoryTypeEnum")
  categoryType: CategoryTypeEnum;

  @doc("Number of top items to return. The value should be between 1 and 10")
  @maxValue(10)
  @minValue(1)
  topItems: int32;
}

@doc("Query Parameters for Top Items Carbon Emissions by Month")
model TopItemsMonthlySummaryReportQueryFilter extends QueryFilter {
  @doc("Top items monthly summary report type name")
  reportType: ReportTypeEnum.TopItemsMonthlySummaryReport;

  @doc("Item Category type, see supported type value defined in CategoryTypeEnum")
  categoryType: CategoryTypeEnum;

  @doc("Number of top items to return. The value should be between 1 and 10")
  @maxValue(10)
  @minValue(1)
  topItems: int32;
}

@doc("Query Parameters for Detailed carbon emissions by pageSize")
model ItemDetailsQueryFilter extends QueryFilter {
  @doc("Item pagination data report type name")
  reportType: ReportTypeEnum.ItemDetailsReport;

  @doc("Item Category type, see supported type value defined in CategoryTypeEnum")
  categoryType: CategoryTypeEnum;

  @doc("Order by column name")
  orderBy: string;

  @doc("Direction for sorting")
  sortDirection: string;

  @doc("Number of items to return in one request, max value is 5000.")
  @maxValue(5000)
  @minValue(1)
  pageSize: int32;

  @doc("The pagination token to fetch next page data, nullable. It's return back in previous request's response if next page data is available")
  skipToken?: string;
}

@doc("Access Decision for each Subscription")
model SubscriptionAccessDecision {
  @doc("Id of Subscription")
  subscriptionId: string;

  @doc("Access decision to subscription")
  decision: AccessDecisionEnum;
}

@doc("The response data type of Carbon emission data")
union ResponseDataTypeEnum {
  @doc("The response data type for OverallSummaryReport")
  OverallSummaryData: "OverallSummaryData",

  @doc("The response data type for MonthlySummaryReport")
  MonthlySummaryData: "MonthlySummaryData",

  @doc("The response data type for TopItemsSummaryReport")
  TopItemsSummaryData: "TopItemsSummaryData",

  @doc("The response data type for Resource's TopItemsSummaryReport")
  ResourceTopItemsSummaryData: "ResourceTopItemsSummaryData",

  @doc("The response data type for ResourceGroup's TopItemsSummaryReport")
  ResourceGroupTopItemsSummaryData: "ResourceGroupTopItemsSummaryData",

  @doc("The response data type for TopItemsMonthlySummaryReport")
  TopItemsMonthlySummaryData: "TopItemsMonthlySummaryData",

  @doc("The response data type for Resource's TopItemsMonthlySummaryReport")
  ResourceTopItemsMonthlySummaryData: "ResourceTopItemsMonthlySummaryData",

  @doc("The response data type for ResourceGroup's TopItemsMonthlySummaryReport")
  ResourceGroupTopItemsMonthlySummaryData: "ResourceGroupTopItemsMonthlySummaryData",

  @doc("The response data type for ItemDetailsReport")
  ItemDetailsData: "ItemDetailsData",

  @doc("The response data type for Resource's ItemDetailsReport")
  ResourceItemDetailsData: "ResourceItemDetailsData",

  @doc("The response data type for ResourceGroup's ItemDetailsReport")
  ResourceGroupItemDetailsData: "ResourceGroupItemDetailsData",

  string,
}

@discriminator("dataType")
@doc("The basic response for different query report, all query report result will have these information")
model CarbonEmissionData {
  @doc("Query result data type name")
  dataType: ResponseDataTypeEnum;

  @doc("Total carbon emissions for given query parameters, the value unit is kgCO2E")
  totalCarbonEmission: float64;

  @doc("Total carbon emission of previous month")
  totalCarbonEmissionLastMonth: float64;

  @doc("Change ratio between totalCarbonEmission and totalCarbonEmissionLastMonth")
  changeRatioForLastMonth: float64;

  @doc("Change Value between totalCarbonEmission and totalCarbonEmissionLastMonth")
  changeValueMonthOverMonth?: float64;
}

@doc("Response for Overall Carbon Emissions Summary")
model CarbonEmissionOverallSummaryData extends CarbonEmissionData {
  @doc("Overall summary data")
  dataType: ResponseDataTypeEnum.OverallSummaryData;
}

@doc("Response for Monthly Carbon Emissions Summary")
model CarbonEmissionMonthlySummaryData extends CarbonEmissionData {
  @doc("Monthly summary data")
  dataType: ResponseDataTypeEnum.MonthlySummaryData;

  @doc("Monthly date string, format is yyyy-MM-dd")
  date: string;

  @doc("Carbon Intensity")
  carbonIntensity: float64;
}

@doc("Response for Top Items by Category Type")
model CarbonEmissionTopItemsSummaryData extends CarbonEmissionData {
  @doc("Top items summary data")
  dataType: ResponseDataTypeEnum.TopItemsSummaryData;

  @doc("Item name, it can be resource name, resource type name, location, resource group name or subscriptionId. It depends on category type.")
  itemName: string;

  @doc("Item category, see supported type value defined in CategoryTypeEnum")
  categoryType: CategoryTypeEnum;
}

@doc("Response for Top Items For Resource Category")
model ResourceCarbonEmissionTopItemsSummaryData extends CarbonEmissionData {
  @doc("Resource top items summary data")
  dataType: ResponseDataTypeEnum.ResourceTopItemsSummaryData;

  @doc("It's resource name for Resource Category")
  itemName: string;

  @doc("Resource Item category")
  categoryType: CategoryTypeEnum;

  @doc("Subscription Id")
  subscriptionId: string;

  @doc("Resource Group")
  resourceGroup: string;

  @doc("Resource Id")
  resourceId: string;
}

@doc("Response for Top Items For ResourceGroup")
model ResourceGroupCarbonEmissionTopItemsSummaryData
  extends CarbonEmissionData {
  @doc("Resource group top items summary data")
  dataType: ResponseDataTypeEnum.ResourceGroupTopItemsSummaryData;

  @doc("It's resourceGroup name for ResourceGroup Category")
  itemName: string;

  @doc("ResourceGroup Item category")
  categoryType: CategoryTypeEnum;

  @doc("Subscription Id")
  subscriptionId: string;

  @doc("Resource Group url, value format is '/subscriptions/{subscriptionId}/resourcegroups/{resourceGroup}'")
  resourceGroupUrl: string;
}

@doc("Response for Top Items Carbon Emissions by Month")
model CarbonEmissionTopItemMonthlySummaryData extends CarbonEmissionData {
  @doc("Top items Monthly summary data")
  dataType: ResponseDataTypeEnum.TopItemsMonthlySummaryData;

  @doc("Item name, it can be resource name, resource type name, location, resource group name or subscriptionId. It depends on category type.")
  itemName: string;

  @doc("Item category, see supported type value defined in CategoryTypeEnum")
  categoryType: CategoryTypeEnum;

  @doc("Month date")
  date: string;
}

@doc("Response for Top Items Carbon Emissions by Month for ResourceType")
model ResourceCarbonEmissionTopItemMonthlySummaryData
  extends CarbonEmissionData {
  @doc("Resource top items Monthly summary data")
  dataType: ResponseDataTypeEnum.ResourceTopItemsMonthlySummaryData;

  @doc("It's resource name for Resource Category")
  itemName: string;

  @doc("Resource Item category")
  categoryType: CategoryTypeEnum;

  @doc("Monthly date string, format is yyyy-MM-dd")
  date: string;

  @doc("Subscription Id")
  subscriptionId: string;

  @doc("Resource Group")
  resourceGroup: string;

  @doc("Resource Id")
  resourceId: string;
}

@doc("Response for Top Items Carbon Emissions by Month for ResourceGroupType")
model ResourceGroupCarbonEmissionTopItemMonthlySummaryData
  extends CarbonEmissionData {
  @doc("Resource group top items Monthly summary data")
  dataType: ResponseDataTypeEnum.ResourceGroupTopItemsMonthlySummaryData;

  @doc("It's resource group name for ResourceGroup category")
  itemName: string;

  @doc("ResourceGroup Item category")
  categoryType: CategoryTypeEnum;

  @doc("Monthly date string, format is yyyy-MM-dd")
  date: string;

  @doc("Subscription Id")
  subscriptionId: string;

  @doc("Resource Group url, value format is '/subscriptions/{subscriptionId}/resourcegroups/{resourceGroup}'")
  resourceGroupUrl: string;
}

@doc("Response for detailed carbon emissions")
model CarbonEmissionItemDetailData extends CarbonEmissionData {
  @doc("Item details data")
  dataType: ResponseDataTypeEnum.ItemDetailsData;

  @doc("Item name, it can be resource name, resource type name, location, resource group name or subscriptionId. It depends on category type.")
  itemName: string;

  @doc("Item category, see supported type value defined in CategoryTypeEnum")
  categoryType: CategoryTypeEnum;
}

@doc("Response for Resource detailed carbon emissions")
model ResourceCarbonEmissionItemDetailData extends CarbonEmissionData {
  @doc("ResourceGroup's item details data")
  dataType: ResponseDataTypeEnum.ResourceItemDetailsData;

  @doc("It's resource name.")
  itemName: string;

  @doc("Resource Item category")
  categoryType: CategoryTypeEnum;

  @doc("Subscription Id")
  subscriptionId: string;

  @doc("Resource Group")
  resourceGroup: string;

  @doc("Resource Id Url")
  resourceId: string;

  @doc("Resource Location")
  location?: string;

  @doc("Resource Type")
  resourceType?: string;
}

@doc("Response for Resource Group detailed carbon emissions")
model ResourceGroupCarbonEmissionItemDetailData extends CarbonEmissionData {
  @doc("ResourceGroup item details data")
  dataType: ResponseDataTypeEnum.ResourceGroupItemDetailsData;

  @doc("It's resource group name")
  itemName: string;

  @doc("ResourceGroup Item category")
  categoryType: CategoryTypeEnum;

  @doc("Subscription Id")
  subscriptionId: string;

  @doc("Resource Group url, value format is '/subscriptions/{subscriptionId}/resourcegroups/{resourceGroup}'")
  resourceGroupUrl: string;
}

@doc("List of carbon emission results")
@Azure.Core.pagedResult
model CarbonEmissionDataListResult {
  @doc("The CarbonEmissionData items on this page")
  @extension("x-ms-identifiers", [])
  @items
  value: CarbonEmissionData[];

  @doc("The pagination token to fetch next page data, it's null or empty if it doesn't have next page data")
  skipToken?: string;

  @doc("If next page data available, the nextLink will return back with value like: {refererHeaderUrl}?$skipToken={opaqueString}")
  nextLink?: string;

  @doc("The access decision list for each input subscription ")
  @extension("x-ms-identifiers", [])
  subscriptionAccessDecisionList?: SubscriptionAccessDecision[];
}

@doc("Response for available date range of carbon emission data")
model CarbonEmissionDataAvailableDateRange {
  @doc("Start date parameter, format is yyyy-MM-dd")
  startDate: string;

  @doc("End date parameter, format is yyyy-MM-dd")
  endDate: string;
}

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator" "Each resource interface must have an @armResourceOperations decorator."
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-operation-missing-decorator" "Resource POST operation must be decorated with @armResourceAction or @armResourceCollectionAction."
interface CarbonService {
  @doc("API for Carbon Emissions Reports")
  @post
  @armResourceCollectionAction
  @route("/providers/Microsoft.Carbon/carbonEmissionReports")
  queryCarbonEmissionReports(
    ...ApiVersionParameter,

    @body
    @doc("Query parameters")
    queryParameters: QueryFilter,
  ): CarbonEmissionDataListResult | ErrorResponse;

  @doc("API for query carbon emission data available date range")
  @post
  @armResourceAction(CarbonEmissionDataAvailableDateRange)
  @route("/providers/Microsoft.Carbon/queryCarbonEmissionDataAvailableDateRange")
  queryCarbonEmissionDataAvailableDateRange(
    ...ApiVersionParameter,
  ): ArmResponse<CarbonEmissionDataAvailableDateRange> | ErrorResponse;
}
