import "./BusinessProcess.tsp";

using TypeSpec.Http;

namespace Private.IntegrationService;

@doc("The business process development artifact save or validate request.")
model SaveOrValidateBusinessProcessDevelopmentArtifactRequest {
    @doc("The name of the business process development artifact.")
    name: string;

    @doc("The properties of the business process development artifact.")
    properties?: BusinessProcessDevelopmentArtifactProperties;
}

@doc("The business process development artifact save or get response.")
model SaveOrGetBusinessProcessDevelopmentArtifactResponse {
    @doc("The name of the business process development artifact.")
    name: string;

    @doc("The system data of the business process development artifact.")
    systemData?:  BusinessProcessDevelopmentArtifactSystemData;

    @doc("The properties of the business process development artifact.")
    properties?: BusinessProcessDevelopmentArtifactProperties;
}

@doc("The business process development artifact get collection response.")
model ListBusinessProcessDevelopmentArtifactsResponse {
    @doc("The list of the business process development artifact.")
    value: SaveOrGetBusinessProcessDevelopmentArtifactResponse[];
}

@doc("The business process development artifact get or delete request.")
model GetOrDeleteBusinessProcessDevelopmentArtifactRequest {
    @doc("The name of the business process development artifact.")
    name: string;
}

@doc("The business process development artifact success response.")
model SuccessfulBusinessProcessDevelopmentArtifactResponse{
  @doc("the status code")
  @statusCode _:200
};

@doc("The properties of business process development artifact.")
model BusinessProcessDevelopmentArtifactProperties {
    @doc("The description of the business process.")
    description?: string;

    @doc("The business process identifier.")
    identifier?: BusinessProcessIdentifier;

    @doc("The business process stages.")
    businessProcessStages?: Record<BusinessProcessStage>;

    @doc("The business process mapping.")
    businessProcessMapping?: Record<BusinessProcessMappingItem>;

    @doc("The tracking profile for the business process.")
    trackingProfiles?: Record<TrackingProfileDefinition>;
}

@doc("The system data for business process development artifact.")
model BusinessProcessDevelopmentArtifactSystemData {
    @doc("The timestamp of last modification (UTC).")
    lastModifiedAt?: string;
}
