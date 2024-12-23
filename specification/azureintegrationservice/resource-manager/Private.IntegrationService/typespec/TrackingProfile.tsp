namespace Private.IntegrationService;

@doc("The tracking profile for the business process")
model TrackingProfileDefinition {
    #suppress "@azure-tools/typespec-azure-core/casing-style"
    @doc("The tracking definition schema uri.")
    $schema?: string;

    @doc("The business process reference.")
    businessProcess?: BusinessProcessReference;

    @doc("The tracking definitions.")
    trackingDefinitions?: Record<FlowTrackingDefinition>;
}

@doc("The business process reference.")
model BusinessProcessReference {
    @doc("The business process name.")
    name?: string;

    @doc("The business process version.")
    version?: string;
}

@doc("The workflow tracking definition.")
model FlowTrackingDefinition {
    @doc("The tracking correlation context.")
    correlationContext?: TrackingCorrelationContext;

    @doc("The tracking events.")
    events?: Record<TrackingEventDefinition>;
}

@doc("The tracking correlation context.")
model TrackingCorrelationContext {
    @doc("The operation type for correlation context.")
    operationType?: string;

    @doc("The operation name for correlation context.")
    operationName?: string;

    @doc("The name of the correlation property.")
    propertyName?: string;

    @doc("The template expression for correlation context property valu.")
    value?: string;
}

#suppress "deprecated" "This is a temporary."
@doc("The tracking event definition.")
model TrackingEventDefinition {
    @doc("The operation type.")
    operationType?: string;

    @doc("The operation name.")
    operationName?: string;

    @doc("The properties to be collected for event.")
    properties?: Record<object>
}
