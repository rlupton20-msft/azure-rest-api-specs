import "./TrackingProfile.tsp";

namespace Private.IntegrationService;

@doc("The properties of business process identifier.")
model BusinessProcessIdentifier {
    @doc("The property name of the business process identifier.")
    propertyName?: string;

    @doc("The property type of the business process identifier.")
    propertyType?: string;
}

@doc("The properties of business process stage.")
model BusinessProcessStage {
    @doc("The description of the business stage.")
    description?: string;

    @doc("The properties within the properties of the business process stage.")
    properties?: Record<string>;

    @doc("The property to keep track of stages before current in the business process stage.")
    stagesBefore?: string[];
}

@doc("The properties of business process mapping.")
model BusinessProcessMappingItem {
    @doc("The logic app resource id.")
    logicAppResourceId?: string;

    @doc("The workflow name within the logic app.")
    workflowName?: string;

    @doc("The operation name.")
    operationName?: string;

    @doc("The mapping item operation type of the business process.")
    operationType?: string;
}

@doc("The properties of business process.")
model BusinessProcessProperties {
    @visibility("read")
    @doc("The status of the last operation.")
    provisioningState?: ProvisioningState;

    @visibility("read")
    @doc("The version of the business process.")
    version?: string;

    @doc("The description of the business process.")
    description?: string;

    @doc("The table name of the business process.")
    tableName?: string;

    @doc("The tracking data store reference name.")
    trackingDataStoreReferenceName?: string;

    @doc("The business process identifier.")
    identifier?: BusinessProcessIdentifier;

    @doc("The business process stages.")
    businessProcessStages?: Record<BusinessProcessStage>;

    @doc("The business process mapping.")
    businessProcessMapping?: Record<BusinessProcessMappingItem>;
}
