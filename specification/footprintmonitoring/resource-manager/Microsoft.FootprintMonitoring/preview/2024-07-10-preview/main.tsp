import "@typespec/http";
import "@typespec/openapi3";
import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-providerhub";
import "@azure-tools/typespec-azure-resource-manager";

using OpenAPI;
using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.Core;
using Azure.ResourceManager;

@armProviderNamespace
@service({
  title: "Profiles",
  @OpenAPI.extension(
    "x-typespec-generated", true
  )
  version: "2024-07-10-preview",
  description: "Microsoft Footprint active monitoring system REST API version 2024-07-03-preview",
  contact: {
    name: "Map of The Internet (AFD) Team",
    url: "http://aka.ms/moiteams",
    email: "moicore@microsoft.com",
  },
})
@useDependency(Azure.ResourceManager.Versions.v1_0_Preview_1)
namespace Microsoft.FootprintMonitoring;

@route("/providers/Microsoft.FootprintMonitoring/operations")
interface operations {
  @tag("Operations")
  @doc("List the operations for the provider")
  @OpenAPI.extension(
    "x-ms-examples",
    {
      `List all operations available`: {
        $ref: "../../examples/operationsList.json",
      },
    }
  )
  @OpenAPI.extension(
    "x-ms-pageable",
    {
      nextLinkName: "nextLink",
    }
  )
  @get
  list(
    @doc("The API version to be used with the HTTP request.")
    @query
    `api-version`: ApiVersionParameter,
  ): {
    @doc("The request was successful; response contains the list of operations under Microsoft.FootprintMonitoring resource provider.")
    @statusCode
    statusCode: 200;

    @body
    body: ResourceProviderOperationList;
  } | {
    @statusCode statusCode: 404 | 500 | 503;

    @doc("A response with a status and optional error describing the reason for the operation result.")
    @body
    body: DefaultErrorResponse;
  };
}

@route("/subscriptions/{subscriptionId}")
interface profiles {
  @tag("Profiles")
  @summary("Get all Footprint profiles under a subscription.")
  @doc("Retrieves the information about all Footprint profiles under a subscription.")
  @OpenAPI.extension(
    "x-ms-examples",
    {
      `List all profiles`: {
        $ref: "../../examples/profilesListBySubscription.json",
      },
    }
  )
  @OpenAPI.extension(
    "x-ms-pageable",
    {
      nextLinkName: "nextLink",
    }
  )
  // add /providers/Microsoft.FootprintMonitoring/profiles+
  @route("/providers/Microsoft.FootprintMonitoring/profiles")
  @get
  ListBySubscriptionId(
    @doc("The API version to be used with the HTTP request.")
    @query
    `api-version`: ApiVersionParameter,

    @doc("The subscription id.")
    subscriptionId: SubscriptionIdParameter,
  ): {
    @statusCode
    statusCode: 200;

    @doc("The request was successful. The response contains the Footprint profiles found.")
    @body
    body: ProfileList;
  } | {
    // all status codes except 200
    @statusCode statusCode: 404 | 500 | 503;

    @doc("A response with a status and optional error describing the reason for the operation result.")
    @body
    body: DefaultErrorResponse;
  };

  @tag("Profiles")
  @summary("Get all Footprint profiles under a resource group.")
  @doc("Retrieves the information about all Footprint profiles under a resource group.")
  @OpenAPI.extension(
    "x-ms-examples",
    {
      `List all profiles`: {
        $ref: "../../examples/profilesListByResourceGroup.json",
      },
    }
  )
  @OpenAPI.extension(
    "x-ms-pageable",
    {
      nextLinkName: "nextLink",
    }
  )
  @route("/resourceGroups/{resourceGroupName}/providers/Microsoft.FootprintMonitoring/profiles")
  @get
  ListByResourceGroup(
    @doc("The API version to be used with the HTTP request.")
    @query
    `api-version`: ApiVersionParameter,

    @doc("The subscription id.")
    subscriptionId: SubscriptionIdParameter,

    @doc("The resource group name.")
    resourceGroupName: string,
  ): {
    @statusCode
    statusCode: 200;

    @body
    body: ProfileList;
  } | {
    @statusCode statusCode: 404 | 500 | 503;

    @body
    body: DefaultErrorResponse;
  };

  @route("/resourceGroups/{resourceGroupName}/providers/Microsoft.FootprintMonitoring/profiles/{profileName}")
  @tag("Profiles")
  @summary("Get a Footprint profile resource.")
  @doc("Retrieves the information about a single Footprint profile.")
  @OpenAPI.extension(
    "x-ms-examples",
    {
      `Get a profile`: {
        $ref: "../../examples/profilesGet.json",
      },
    }
  )
  @get
  get(
    @doc("The API version to be used with the HTTP request.")
    @query
    `api-version`: ApiVersionParameter,

    @doc("The subscription id.")
    subscriptionId: SubscriptionIdParameter,

    @doc("The resource group name.")
    resourceGroupName: ResourceGroupNameParameter,

    @doc("The profile name.")
    profileName: ProfileNameParameter,
  ): {
    @statusCode
    statusCode: 200;

    @body
    @doc("The request was successful. The response contains the single Footprint profile's information.")
    body: Profile;
  } | {
    @statusCode statusCode: 404 | 500 | 503;

    @body
    body: DefaultErrorResponse;
  };

  @route("/resourceGroups/{resourceGroupName}/providers/Microsoft.FootprintMonitoring/profiles/{profileName}")
  @tag("Profiles")
  @summary("Creates or updates a Footprint profile resource.")
  @doc("Creates or updates a Footprint profile with the specified properties.")
  @OpenAPI.extension(
    "x-ms-examples",
    {
      `Create or update a profile.`: {
        $ref: "../../examples/profilesCreateOrUpdate.json",
      },
    }
  )
  @put
  createOrUpdate(
    @doc("The API version to be used with the HTTP request.")
    @query
    `api-version`: ApiVersionParameter,

    @doc("The subscription id.")
    subscriptionId: SubscriptionIdParameter,

    @doc("The resource group name.")
    resourceGroupName: ResourceGroupNameParameter,

    @doc("The profile name.")
    profileName: ProfileNameParameter,

    @doc("Footprint profile update parameters.")
    @body
    profile: Profile,
  ): {
    @statusCode
    statusCode: 200 | 201;

    @body
    body: Profile;
  } | {
    @statusCode statusCode: 404 | 500 | 503;

    @body
    body: DefaultErrorResponse;
  };

  @route("/resourceGroups/{resourceGroupName}/providers/Microsoft.FootprintMonitoring/profiles/{profileName}")
  @tag("Profiles")
  @summary("Deletes a Footprint profile resource.")
  @doc("Deletes an existing Footprint profile.")
  @OpenAPI.extension(
    "x-ms-examples",
    {
      `Delete a profile`: {
        $ref: "../../examples/profilesDelete.json",
      },
    }
  )
  @delete
  delete(
    @doc("The API version to be used with the HTTP request.")
    @query
    `api-version`: ApiVersionParameter,

    @doc("The subscription id.")
    subscriptionId: SubscriptionIdParameter,

    @doc("The resource group name.")
    resourceGroupName: ResourceGroupNameParameter,

    @doc("The profile name.")
    profileName: ProfileNameParameter,
  ): {
    @statusCode
    statusCode: 200;

    @body
    body: Profile;
  } | {
    @statusCode statusCode: 404 | 500 | 503;

    @body
    body: DefaultErrorResponse;
  };

  @route("/resourceGroups/{resourceGroupName}/providers/Microsoft.FootprintMonitoring/profiles/{profileName}")
  @tag("Profiles")
  @summary("Updates a Footprint profile resource.")
  @doc("Updates an existing Footprint profile.")
  @OpenAPI.extension(
    "x-ms-examples",
    {
      `Update a profile`: {
        $ref: "../../examples/profilesUpdate.json",
      },
    }
  )
  @patch
  update(
    @doc("The API version to be used with the HTTP request.")
    @query
    `api-version`: ApiVersionParameter,

    @doc("The subscription id.")
    subscriptionId: SubscriptionIdParameter,

    @doc("The resource group name.")
    resourceGroupName: ResourceGroupNameParameter,

    @doc("The profile name.")
    profileName: ProfileNameParameter,

    @doc("The profile properties.")
    @body
    profile: ProfilePatch,
  ): {
    @statusCode
    statusCode: 200;

    @body
    body: Profile;
  } | {
    @statusCode statusCode: 404 | 500 | 503;

    @body
    body: DefaultErrorResponse;
  };
}

@route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.FootprintMonitoring/profiles/{profileName}/measurementEndpoints")
interface measurementEndpoints {
  @tag("MeasurementEndpoints")
  @summary("Get all measurement endpoints under a profile.")
  @doc("Retrieves the information about all measurement endpoints under a Footprint profile.")
  @OpenAPI.extension(
    "x-ms-examples",
    {
      `List all measurement endpoints under a Footprint profile`: {
        $ref: "../../examples/measurementEndpointsList.json",
      },
    }
  )
  @OpenAPI.extension(
    "x-ms-pageable",
    {
      nextLinkName: "nextLink",
    }
  )
  @get
  ListByProfile(
    @doc("The API version to be used with the HTTP request.")
    @query
    `api-version`: ApiVersionParameter,

    subscriptionId: SubscriptionIdParameter,
    resourceGroupName: ResourceGroupNameParameter,
    profileName: ProfileNameParameter,
  ): {
    @statusCode
    statusCode: 200;

    @doc("The request was successful. The response contains the Footprint measurement endpoints found.")
    @body
    body: MeasurementEndpointList;
  } | {
    @statusCode statusCode: 404 | 500 | 503;

    @body
    body: DefaultErrorResponse;
  };

  @route("/{measurementEndpointName}")
  @tag("MeasurementEndpoints")
  @summary("Get a measurement endpoint under a Footprint profile resource.")
  @doc("Retrieves the information about a single measurement endpoint under a Footprint profile.")
  @OpenAPI.extension(
    "x-ms-examples",
    {
      `Get a measurement endpoint`: {
        $ref: "../../examples/measurementEndpointsGet.json",
      },
    }
  )
  @get
  get(
    @query
    `api-version`: ApiVersionParameter,

    subscriptionId: SubscriptionIdParameter,
    resourceGroupName: ResourceGroupNameParameter,
    profileName: ProfileNameParameter,
    measurementEndpointName: MeasurementEndpointNameParameter,
  ): {
    @statusCode
    statusCode: 200;

    @doc("The request was successful. The response contains the single Footprint profile's measurement endpoint information.")
    @body
    body: MeasurementEndpoint;
  } | {
    @statusCode statusCode: 404 | 500 | 503;

    @body
    body: DefaultErrorResponse;
  };

  @route("/{measurementEndpointName}")
  @tag("MeasurementEndpoints")
  @summary("Creates or updates a single measurement endpoint under a Footprint profile resource.")
  @doc("Creates or updates a single measurement endpoint under a Footprint profile with the specified properties.")
  @OpenAPI.extension(
    "x-ms-examples",
    {
      `Create or update a measurement endpoint`: {
        $ref: "../../examples/measurementEndpointsCreateOrUpdate.json",
      },
    }
  )
  @put
  createOrUpdate(
    @query
    `api-version`: ApiVersionParameter,

    @path
    subscriptionId: SubscriptionIdParameter,

    @path
    resourceGroupName: ResourceGroupNameParameter,

    @path
    profileName: ProfileNameParameter,

    @path
    measurementEndpointName: MeasurementEndpointNameParameter,

    @body // when specifying body the other parameters require explicit @path
    measurementEndpoint: MeasurementEndpoint,
  ): {
    @statusCode
    statusCode: 200 | 201;

    @doc("The request was successful. The resource was created/updated and the response contains the updated Footprint measurement endpoint's information.")
    @body
    body: MeasurementEndpoint;
  } | {
    @statusCode statusCode: 404 | 500 | 503;

    @body
    body: DefaultErrorResponse;
  };

  @route("/{measurementEndpointName}")
  @tag("MeasurementEndpoints")
  @summary("Deletes a measurement endpoint under a Footprint profile resource.")
  @doc("Deletes an existing measurement endpoint under a Footprint profile.")
  @OpenAPI.extension(
    "x-ms-examples",
    {
      `Delete a measurement endpoint`: {
        $ref: "../../examples/measurementEndpointsDelete.json",
      },
    }
  )
  @delete
  delete(
    @query
    `api-version`: ApiVersionParameter,

    subscriptionId: SubscriptionIdParameter,
    resourceGroupName: ResourceGroupNameParameter,
    profileName: ProfileNameParameter,
    measurementEndpointName: MeasurementEndpointNameParameter,
  ): {
    @doc("The request was successful. The resource was deleted.")
    @statusCode
    statusCode: 200 | 204;
  } | {
    @statusCode statusCode: 404 | 500 | 503;

    @body
    body: DefaultErrorResponse;
  };

  @route("/{measurementEndpointName}/conditions")
  @tag("MeasurementEndpointConditions")
  @summary("Get all measurement endpoint conditions under a measurement endpoint.")
  @doc("Retrieves the information about all measurement endpoint conditions under a Footprint measurement endpoint.")
  @OpenAPI.extension(
    "x-ms-examples",
    {
      `List all measurement endpoint conditions under a measurement endpoint`: {
        $ref: "../../examples/measurementEndpointConditionsListByEndpoint.json",
      },
    }
  )
  @OpenAPI.extension(
    "x-ms-pageable",
    {
      nextLinkName: "nextLink",
    }
  )
  @get
  listByMeasurementEndpoint(
    @query
    `api-version`: ApiVersionParameter,

    subscriptionId: SubscriptionIdParameter,
    resourceGroupName: ResourceGroupNameParameter,
    profileName: ProfileNameParameter,
    measurementEndpointName: MeasurementEndpointNameParameter,
  ): {
    @statusCode
    statusCode: 200;

    @doc("The request was successful. The response contains the Footprint measurement endpoint conditions found.")
    @body
    body: MeasurementEndpointConditionList;
  } | {
    @statusCode statusCode: 404 | 500 | 503;

    @body
    body: DefaultErrorResponse;
  };

  @route("/{measurementEndpointName}/conditions/{conditionName}")
  @tag("MeasurementEndpointConditions")
  @summary("Get a measurement endpoint condition under a Footprint measurement endpoint resource.")
  @doc("Retrieves the information about a single measurement endpoint condition under a Footprint measurement endpoint.")
  @OpenAPI.extension(
    "x-ms-examples",
    {
      `Get a measurement endpoint condition`: {
        $ref: "../../examples/measurementEndpointConditionsGet.json",
      },
    }
  )
  @get
  getCondition(
    @query
    `api-version`: ApiVersionParameter,

    subscriptionId: SubscriptionIdParameter,
    resourceGroupName: ResourceGroupNameParameter,
    profileName: ProfileNameParameter,
    measurementEndpointName: MeasurementEndpointNameParameter,
    conditionName: MeasurementEndpointConditionNameParameter,
  ): {
    @statusCode
    statusCode: 200;

    @doc("The request was successful. The response contains the single measurement endpoint condition under a Footprint measurement's information.")
    @body
    body: MeasurementEndpointCondition;
  } | {
    @statusCode statusCode: 404 | 500 | 503;

    @body
    body: DefaultErrorResponse;
  };

  @route("/{measurementEndpointName}/conditions/{conditionName}")
  @tag("MeasurementEndpointConditions")
  @summary("Creates or updates a single measurement endpoint condition under a Footprint measurement endpoint resource.")
  @doc("Creates or updates a single measurement endpoint condition under a Footprint measurement endpoint with the specified properties.")
  @OpenAPI.extension(
    "x-ms-examples",
    {
      `Create or update a measurement endpoint condition`: {
        $ref: "../../examples/measurementEndpointConditionsCreateOrUpdate.json",
      },
    }
  )
  @put
  createOrUpdateCondition(
    @query
    `api-version`: ApiVersionParameter,

    subscriptionId: SubscriptionIdParameter,
    resourceGroupName: ResourceGroupNameParameter,
    profileName: ProfileNameParameter,
    measurementEndpointName: MeasurementEndpointNameParameter,
    conditionName: MeasurementEndpointConditionNameParameter,

    @body
    condition: MeasurementEndpointCondition,
  ): {
    @statusCode
    statusCode: 200 | 201;

    @doc("The request was successful. The resource was updated and the response contains the updated measurement endpoint condition information under a Footprint measurement.")
    @body
    body: MeasurementEndpointCondition;
  } | {
    @statusCode statusCode: 404 | 500 | 503;

    @body
    body: DefaultErrorResponse;
  };

  @route("/{measurementEndpointName}/conditions/{conditionName}")
  @tag("MeasurementEndpointConditions")
  @summary("Deletes a measurement endpoint condition under a Footprint measurement resource.")
  @doc("Deletes an existing measurement endpoint condition under a Footprint measurement.")
  @OpenAPI.extension(
    "x-ms-examples",
    {
      `Delete a measurement endpoint condition`: {
        $ref: "../../examples/measurementEndpointConditionsDelete.json",
      },
    }
  )
  @delete
  deleteCondition(
    @query
    `api-version`: ApiVersionParameter,

    subscriptionId: SubscriptionIdParameter,
    resourceGroupName: ResourceGroupNameParameter,
    profileName: ProfileNameParameter,
    measurementEndpointName: MeasurementEndpointNameParameter,
    conditionName: MeasurementEndpointConditionNameParameter,
  ): {
    docs: ("The request was successful. The resource was deleted.");

    @statusCode
    statusCode: 200 | 204;
  } | {
    @statusCode statusCode: 404 | 500 | 503;

    @body
    body: DefaultErrorResponse;
  };
}

@route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.FootprintMonitoring/profiles/{profileName}/experiments")
interface experiments {
  @tag("Experiments")
  @summary("Get all experiments under a Footprint profile.")
  @doc("Retrieves the information about all experiments under a Footprint profile.")
  @OpenAPI.extension(
    "x-ms-examples",
    {
      `List all experiments under a Footprint profile`: {
        $ref: "../../examples/experimentsListByProfile.json",
      },
    }
  )
  @OpenAPI.extension(
    "x-ms-pageable",
    {
      nextLinkName: "nextLink",
    }
  )
  @get
  ListByProfile(
    @query
    `api-version`: ApiVersionParameter,

    subscriptionId: SubscriptionIdParameter,
    resourceGroupName: ResourceGroupNameParameter,
    profileName: ProfileNameParameter,
  ): {
    @statusCode
    statusCode: 200;

    @doc("The request was successful. The response contains the Footprint experiments found.")
    @body
    body: ExperimentList;
  } | {
    @statusCode statusCode: 404 | 500 | 503;

    @body
    body: DefaultErrorResponse;
  };

  @route("/{experimentName}")
  @tag("Experiments")
  @summary("Get an experiment under a Footprint profile resource.")
  @doc("Retrieves the information about a single experiment under a Footprint profile.")
  @OpenAPI.extension(
    "x-ms-examples",
    {
      `Get an experiment`: {
        $ref: "../../examples/experimentsGet.json",
      },
    }
  )
  @get
  get(
    @query
    `api-version`: ApiVersionParameter,

    subscriptionId: SubscriptionIdParameter,
    resourceGroupName: ResourceGroupNameParameter,
    profileName: ProfileNameParameter,
    experimentName: string,
  ): {
    @statusCode
    statusCode: 200;

    @doc("The request was successful. The response contains the single Footprint profile's experiment information.")
    @body
    body: Experiment;
  } | {
    @statusCode statusCode: 404 | 500 | 503;

    @body
    body: DefaultErrorResponse;
  };

  @route("/{experimentName}")
  @tag("Experiments")
  @summary("Creates or updates an experiment under a Footprint profile resource.")
  @doc("Creates or updates an experiment under a Footprint profile with the specified properties.")
  @OpenAPI.extension(
    "x-ms-examples",
    {
      `Create or update an experiment`: {
        $ref: "../../examples/experimentsCreateOrUpdate.json",
      },
    }
  )
  @put
  createOrUpdate(
    @query
    `api-version`: ApiVersionParameter,

    subscriptionId: SubscriptionIdParameter,
    resourceGroupName: ResourceGroupNameParameter,
    profileName: ProfileNameParameter,
    experimentName: string,

    @body
    experiment: Experiment,
  ): {
    @statusCode
    statusCode: 200 | 201;

    @doc("The request was successful. The resource was created/updated and the response contains the updated Footprint experiment's information.")
    @body
    body: Experiment;
  } | {
    @statusCode statusCode: 404 | 500 | 503;

    @body
    body: DefaultErrorResponse;
  };

  @route("/{experimentName}")
  @tag("Experiments")
  @summary("Deletes a Footprint experiment resource.")
  @doc("Deletes an existing Footprint experiment.")
  @OpenAPI.extension(
    "x-ms-examples",
    {
      `Delete an experiment`: {
        $ref: "../../examples/experimentsDelete.json",
      },
    }
  )
  @delete
  delete(
    @query
    `api-version`: ApiVersionParameter,

    subscriptionId: SubscriptionIdParameter,
    resourceGroupName: ResourceGroupNameParameter,
    profileName: ProfileNameParameter,
    experimentName: string,
  ): {
    @statusCode
    statusCode: 200;

    @doc("The request was successful. The resource was deleted.")
    @body
    body: Experiment;
  } | {
    @statusCode statusCode: 404 | 500 | 503;

    @body
    body: DefaultErrorResponse;
  };
}

// @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.FootprintMonitoring/profiles/{profileName}/experiments/{experimentName}")

// Profile
@doc("A model representing the Footprint profile resource.")
model ProfileProperties {
  @doc("The provisioned state of the resource")
  @visibility("read")
  @OpenAPI.extension(
    "x-ms-enum",
    {
      name: "ProvisioningState",
      modelAsString: true,
    }
  )
  provisioningState?: ProvisioningState;

  @doc("The id of the Footprint profile.")
  @visibility("read")
  @summary("The id of the Footprint profile.")
  profileId?: string;

  @doc("The description of the Footprint profile.")
  @summary("Profile Description")
  description?: string;

  @doc("The delay in milliseconds that the clients should wait for until they start performing measurements.")
  @summary("Start Delay (ms)")
  @minValue(0)
  @maxValue(3600000)
  startDelayMilliseconds: int32;

  @doc("The URL where the script for the Footprint profile.")
  @visibility("read")
  @summary("Profile Script URL")
  scriptUri?: string;

  @doc("The number of measurements to perform.")
  @summary("Count of Measurements")
  @minValue(0)
  measurementCount: int32;

  @doc("The default sampling percentage for cold path measurement storage.")
  @summary("Cold Path Sampling Percentage")
  @minValue(0)
  @maxValue(100)
  coldPathSamplingPercentageRate?: float32;

  @doc("The endpoints which to perform measurements to.")
  @summary("MeasurementEndpoints")
  @visibility("read")
  measurementEndpoints?: Array<MeasurementEndpoint>;

  @doc("The endpoints which to upload measurements to.")
  @summary("Reporting Endpoings")
  reportingEndpoints?: Array<string>;

  @doc("The experiments currently associated to this Footprint profile.")
  @summary("Experiments")
  @visibility("read")
  experiments?: Array<SubResource>;
  // TODO: use experiements model
}

@summary("Footprint profile.")
@doc("The Footprint profile resource.")
model Profile extends Resource {
  @doc("Name of the Footprint profile resource.")
  location: string;

  @doc("Additional Footprint profile properties.")
  @summary("Footprint profile additional properties.")
  @OpenAPI.extension("x-ms-client-flatten", true)
  properties: ProfileProperties;
}

@doc("Result of the request to list Footprint profiles. It contains a list of Footprint profiles and a URL link to get the next set of results.")
model ProfileList {
  @visibility("read")
  @doc("A collection of Footprint profiles.")
  value?: Array<Profile>;

  @doc("URL to get the next set of Footprint profile objects.")
  nextLink?: string;
}

@doc("The model for patches on Footprint profile resources.")
@summary("Footprint Profile Update Model")
model ProfilePatch {
  @doc("The tags for this resource.")
  tags?: Record<string>;
}

// MeasurementEndpoint

model MeasurementEndpoint extends SubResource {
  // @doc("Name of the Footprint profile resource.")
  // @minLength(5)
  // @maxLength(64)
  // @pattern("^[a-zA-Z0-9]")
  // @key("measurementEndpointName")
  // @path
  // @segment("measurementEndpoints")
  // name: string;
  @doc("Additional Footprint measurement endpoint properties.")
  @summary("Footprint measurement endpoint additional properties.")
  @OpenAPI.extension("x-ms-client-flatten", true)
  properties: MeasurementEndpointProperties;

  @visibility("read")
  @doc("The name of the resource.")
  name: string;

  @visibility
  @doc("The type of the resource.")
  type: string;
}

@doc("A model representing the Footprint Measurement Endpoint resource.")
@summary("Footprint Measurement Endpoint Properties")
model MeasurementEndpointProperties {
  @doc("The id of a measurement endpoint.")
  @visibility("read")
  @minLength(32)
  @maxLength(32)
  @pattern("[a-f0-9]{32}")
  endpointId?: string;

  @doc("The description of a measurement endpoint.")
  @summary("Measurement Endpoint Description")
  description?: string;

  @doc("The value of a measurement endpoint.")
  @summary("Measurement Endpoint")
  @minLength(0)
  @maxLength(1024)
  // TODO: confirm next line regex
  @pattern("^[a-z0-9\\*]+([\\-\\.]{1}[a-z0-9]+)*\\.[a-z]{2,}(:[0-9]{1,5})?$")
  endpoint: string;

  @doc("The type of a measurement endpoint.")
  @summary("Measurement Endpoint Type")
  measurementType: int32;

  @doc("The weight of a measurement endpoint, higher weight means higher priority.")
  @summary("Measurement Endpoint Weight")
  @minValue(0)
  @maxValue(2147483647)
  weight: int32;

  @doc("The id of an experiment that a measurement endpoint is part of.")
  @summary("Measurement Endpoint Experiment Id")
  @minLength(32)
  @maxLength(32)
  @pattern("[a-f0-9]{32}")
  experimentId?: string;

  @doc("The path of the object that a measurement endpoint points to.")
  @summary("Measurement Endpoint Object Path")
  @minLength(0)
  @maxLength(1024)
  @pattern("^/[a-zA-Z0-9-._~%!$&()*+,;=@/]*$")
  objectPath?: string;

  @visibility("read")
  @doc("The conditions of a measurement endpoint.")
  @summary("Measurement Endpoint Conditions")
  // TODO: use MeasurementEndpointCondition model
  conditions?: Array<SubResource>;

  @doc("The start time that a measurement endpoint should be served.")
  @summary("Measurement Endpoint Start Time")
  startTimeUTC?: utcDateTime;

  @doc("The end time that a measurement endpoint should be served.")
  @summary("Measurement Endpoint End Time")
  endTimeUTC?: utcDateTime;

  @doc("The sampling rate percentage for the hot path logging of a measurement endpoint.")
  @summary("Measurement Endpoint Hot Path Sampling Rate")
  @minValue(0)
  @maxValue(100)
  hotPathSamplingPercentageRate?: float32;

  @doc("The sampling rate percentage for the warm path logging of a measurement endpoint.")
  @summary("Measurement Endpoint Warm Path Sampling Rate")
  @minValue(0)
  @maxValue(100)
  warmPathSamplingPercentageRate?: float32;

  @doc("The sampling rate percentage for the cold path logging of a measurement endpoint.")
  @summary("Measurement Endpoint Cold Path Sampling Rate")
  @minValue(0)
  @maxValue(100)
  coldPathSamplingPercentageRateOverride?: float32;

  @doc("The metadata of a measurement endpoint.")
  @summary("Measurement Endpoint Metadata")
  metadata?: string;
}

@doc("A model representing the Footprint Measurement Endpoint Condition resource.")
@summary("Footprint Measurement Endpoint Condition")
model MeasurementEndpointCondition extends SubResource {
  @doc("Name of the Footprint measurement endpoint condition resource.")
  // @minLength(5)
  // @maxLength(64)
  // @pattern("^[a-zA-Z0-9]")
  name?: string;

  @doc("Additional Footprint measurement endpoint condition properties.")
  @summary("Footprint measurement endpoint condition additional properties.")
  @OpenAPI.extension("x-ms-client-flatten", true)
  properties: MeasurementEndpointConditionProperties;

  @visibility("read")
  @doc("The type of the resource.")
  type?: string;
}

@doc("Result of the request to list Footprint measurement endpoint conditions. It contains a list of Footprint measurement endpoint conditions objects and a URL link to get the next set of results.")
model MeasurementEndpointConditionList {
  @visibility("read")
  // @doc("A collection of Footprint measurement endpoint conditions.")
  value?: Array<MeasurementEndpointCondition>;

  @doc("URL to get the next set of Footprint measurement endpoint condition objects.")
  nextLink?: string;
}

@doc("A model representing the Footprint Measurement Endpoint Condition resource.")
@summary("Footprint Measurement Endpoint Condition Properties")
model MeasurementEndpointConditionProperties {
  @visibility("read")
  @doc("The id of a Footprint measurement endpoint condition.")
  @summary("Footprint Measurement Endpoint Condition Id")
  @minLength(32)
  @maxLength(32)
  @pattern("[a-f0-9]{32}")
  conditionId?: string;

  @doc("The type of a Footprint measurement endpoint condition.")
  @summary("Footprint Measurement Endpoint Condition Type")
  @OpenAPI.extension(
    "x-ms-enum",
    {
      name: "Type",
      modelAsString: true,
    }
  )
  type: Type;

  @doc("The variable of a Footprint measurement endpoint condition.")
  @summary("Footprint Measurement Endpoint Condition Variable")
  variable: string;

  @doc("The operator of a Footprint measurement endpoint condition.")
  @summary("Footprint Measurement Endpoint Condition Operator")
  @OpenAPI.extension(
    "x-ms-enum",
    {
      name: "Operator",
      modelAsString: true,
    }
  )
  operator: Operator;

  @doc("The constant of a Footprint measurement endpoint condition.")
  @summary("Footprint Measurement Endpoint Condition Constant")
  constant: string;
}

@doc("Result of the request to list Footprint measurement endpoints. It contains a list of Footprint measurement endpoints objects and a URL link to get the next set of results.")
model MeasurementEndpointList {
  @visibility("read")
  @doc("A collection of Footprint measurement endpoints.")
  value?: Array<MeasurementEndpoint>;

  @doc("URL to get the next set of Footprint measurement endpoint objects.")
  nextLink?: string;
}
// Experiment

@doc("A model representing the Footprint Experiment resource.")
model ExperimentProperties {
  @visibility("read")
  @doc("The id of a Footprint experiment.")
  @summary("Footprint Experiment Id")
  @minLength(32)
  @maxLength(32)
  @pattern("[a-f0-9]{32}")
  experimentId?: string;

  @doc("The description of a Footprint experiment.")
  @summary("Footprint Experiment Description")
  description?: string;

  @visibility("read")
  @doc("The status of a Footprint experiment.")
  @summary("Footprint Experiment Status")
  status?: string;
}

@doc("A model representing the Footprint experiment.")
model Experiment extends SubResource {
  @visibility("read")
  @doc("Name of the Footprint experiment resource.")
  // @minLength(3)
  // @maxLength(64)
  // @pattern("^[a-zA-Z0-9]")
  name?: string;

  @doc("Additional Footprint experiment properties.")
  @summary("Footprint experiment additional properties.")
  @OpenAPI.extension("x-ms-client-flatten", true)
  properties: ExperimentProperties;

  @visibility("read")
  @doc("The type of the resource.")
  type?: string;
}

@doc("Result of the request to list Footprint experiments. It contains a list of Footprint experiments objects and a URL link to get the next set of results.")
model ExperimentList {
  @visibility("read")
  @doc("A collection of Footprint experiments.")
  value?: Array<Experiment>;

  @doc("URL to get the next set of Footprint experiment objects.")
  nextLink?: string;
}

// Definitions
@summary("Default Error Response")
@doc("The base response with an error.")
model DefaultErrorResponse {
  @doc("The error details, if any.")
  error?: ErrorDefinition;
}

@summary("Error Definition")
@doc("The details of an error.")
model ErrorDefinition {
  @doc("Service specific error code which serves as the substatus for the HTTP error code.")
  @visibility("read")
  code?: string;

  @doc("Description of the error.")
  @visibility("read")
  message?: string;
}

@summary("Resource Provider's Available Operations")
@doc("A list of operations and a URL nextLink to get the next set of results.")
model ResourceProviderOperationList {
  @doc("Resource provider operations list.")
  value?: Array<ResourceProviderOperationDefinition>;

  @visibility("read")
  @doc("The URI that can be used to request the next page for list of Azure operations.")
  nextLink?: string;
}

@summary("Resource Provider Operation")
@doc("Describes the Resource Provider Operation.")
model ResourceProviderOperationDefinition {
  @summary("The operation's name.")
  @doc("Resource provider operation name.")
  name?: string;

  @summary("The operation's properties.")
  @doc("Resource provider display properties.")
  display?: ResourceProviderOperationDisplay;
}

@summary("Resource Provider Operation Properties")
@doc("Describes the properties of the Operation.")
model ResourceProviderOperationDisplay {
  @doc("Name of the resource provider.")
  provider?: string;

  @doc("Name of the resource type.")
  resource?: string;

  @doc("Name of the resource provider operation.")
  operation?: string;

  @doc("Description of the resource provider operation.")
  description?: string;
}

@summary("Azure Resource")
@doc("An Azure resource.")
@OpenAPI.extension("x-ms-azure-resource", true)
model Resource {
  @visibility("read")
  @doc("Fully qualified resource Id for the resource.")
  id?: string;

  @visibility("read")
  @doc("The name of the resource.")
  name?: string;

  @visibility("read")
  @doc("The type of the resource.")
  type?: string;

  @doc("Tags for the resource.")
  // TODO: add additionalProperties
  @OpenAPI.extension("x-ms-mutability", ["read", "create", "update"])
  tags?: Record<string>;

  @doc("Region where the Azure resource is located.")
  @OpenAPI.extension("x-ms-mutable", ["read", "create"])
  location?: string;
}

@doc("An Azure resource that is child to another Azure resource.")
@OpenAPI.extension("x-ms-azure-resource", true)
model SubResource {
  @visibility("read")
  @doc("Fully qualified resource Id for the resource.")
  id: string;
}

// Parameters

// Enums

@doc("The provisioning state of a resource.")
@lroStatus
enum ProvisioningState {
  ResourceProvisioningState,

  @doc("The resource is being provisioned")
  Provisioning,

  @doc("The resource is updating")
  Updating,

  @doc("The resource is being deleted")
  Deleting,

  @doc("The resource create request has been accepted")
  Accepted,

  @doc("The resource create request has been completed")
  Succeeded,

  @doc("The resource create request has failed")
  Failed,
}

@doc("The type of a Footprint measurement endpoint condition.")
enum Type {
  RequestHeader,
}

@doc("The operator of a Footprint measurement endpoint condition.")
enum Operator {
  IsExactValue,
  MatchValueIgnoreCasing,
  ContainsValue,
  ContainsValueIgnoreCasing,
  DoesNotContainValue,
  DoesNotContainValueIgnoreCasing,
}

// Parameters
model ApiVersionParameter {
  @visibility("read")
  @doc("The API version to be used with the HTTP request.")
  apiVersion: string;
}

model SubscriptionIdParameter {
  @visibility("read")
  @doc("The Azure subscription ID. This is a GUID-formatted string (e.g. 00000000-0000-0000-0000-000000000000)")
  subscriptionId: string;
}

model ResourceGroupNameParameter {
  @visibility("read")
  @doc("The name of the resource group.")
  @minLength(1)
  @maxLength(90)
  @OpenAPI.extension("x-ms-parameter-location", "method")
  resourceGroupName: string;
}

model ProfileNameParameter {
  @visibility("read")
  @doc("The name of the Footprint profile.")
  @minLength(3)
  @maxLength(64)
  @pattern("^[a-zA-Z0-9]")
  @OpenAPI.extension("x-ms-parameter-location", "method")
  profileName: string;
}

model MeasurementEndpointNameParameter {
  @visibility("read")
  @doc("Name of the Footprint measurement endpoint resource.")
  @minLength(5)
  @maxLength(64)
  @pattern("^[a-zA-Z0-9]")
  @OpenAPI.extension("x-ms-parameter-location", "method")
  measurementEndpointName: string;
}

model MeasurementEndpointConditionNameParameter {
  @visibility("read")
  @doc("Name of the Footprint measurement endpoint condition resource.")
  @minLength(5)
  @maxLength(64)
  @pattern("^[a-zA-Z0-9]")
  @OpenAPI.extension("x-ms-parameter-location", "method")
  conditionName: string;
}

model ExperimentNameParameter {
  @visibility("read")
  @doc("Name of the Footprint experiment resource.")
  @minLength(5)
  @maxLength(64)
  @pattern("^[a-zA-Z0-9]")
  @OpenAPI.extension("x-ms-parameter-location", "method")
  experimentName: string;
}