import "@typespec/rest";
import "@typespec/http";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "./extendedLocation.tsp";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.Core;
using Azure.ResourceManager;

namespace Private.HealthcareInteropDev;

@doc("The healthcare interop DicomEdgeConnector resource.")
model DicomEdgeConnector is TrackedResource<DicomEdgeConnectorProperties> {
  @doc("The name of the dicom edge connector")
  @pattern("^[a-zA-Z0-9-]{3,24}$")
  @key("dicomEdgeConnectorName")
  @segment("dicomEdgeConnectors")
  @path
  name: string;

  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property"
  @doc("The extended location.")
  @visibility(Lifecycle.Read, Lifecycle.Create, Lifecycle.Update)
  extendedLocation: ExtendedLocation;
}

@doc("DicomEdgeConnector properties")
model DicomEdgeConnectorProperties {
  @doc("The Receiver Configuration to be used for dicom connector configuration.")
  receiver?: {
    @doc("The Listener Configuration to be used for dicom connector configuration.")
    @visibility(Lifecycle.Create, Lifecycle.Read, Lifecycle.Update)
    dicomListenerConfiguration: {
      @doc("The port number to use.")
      @minValue(1)
      @maxValue(65535)
      @visibility(Lifecycle.Create, Lifecycle.Read, Lifecycle.Update)
      port: int32;
    };

    @doc("The Storage Endpoint Configuration to be used for dicom connector configuration.")
    @visibility(Lifecycle.Create, Lifecycle.Read, Lifecycle.Update)
    localStorageEndpointConfiguration: {
      @doc("Optional URL of the blob storage where the output will be stored.")
      @visibility(Lifecycle.Create, Lifecycle.Read, Lifecycle.Update)
      @pattern("^https://.*$")
      blobUrl?: string;

      @doc("Optional name of the container in the blob storage.")
      @pattern("^[a-z0-9](?!.*--)[a-z0-9-]{1,61}[a-z0-9]$")
      @visibility(Lifecycle.Create, Lifecycle.Read, Lifecycle.Update)
      container?: string;

      @doc("Optional format for the output folder.")
      @maxLength(255)
      outputFolderFormat?: string;
    };
  };

  @doc("The status of the last operation.")
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningState;
}

@armResourceOperations
interface DicomEdgeConnectors {
  get is ArmResourceRead<DicomEdgeConnector>;
  createOrUpdate is ArmResourceCreateOrReplaceAsync<DicomEdgeConnector>;
  update is ArmResourcePatchAsync<
    DicomEdgeConnector,
    DicomEdgeConnectorProperties
  >;
  delete is ArmResourceDeleteWithoutOkAsync<DicomEdgeConnector>;
  listByResourceGroup is ArmResourceListByParent<DicomEdgeConnector>;
  listBySubscription is ArmListBySubscription<DicomEdgeConnector>;
}
