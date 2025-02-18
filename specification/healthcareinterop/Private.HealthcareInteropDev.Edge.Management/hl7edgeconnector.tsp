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

@doc("The healthcare interop Hl7EdgeConnector resource.")
model Hl7EdgeConnector is TrackedResource<Hl7EdgeConnectorProperties> {
  @doc("The name of the hl7 edge connector")
  @pattern("^[a-zA-Z0-9-]{3,24}$")
  @key("hl7EdgeConnectorName")
  @segment("hl7EdgeConnectors")
  @path
  name: string;

  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property"
  @doc("The extended location.")
  @visibility("read", "create")
  extendedLocation: ExtendedLocation;
}

@doc("Hl7EdgeConnector properties")
model Hl7EdgeConnectorProperties {
  @doc("The Receiver Configuration to be used for hl7 connector configuration.")
  @visibility("create", "read", "update", "delete")
  receiver?: {
    @doc("The Receiver Endpoint Configuration to be used for hl7 connector configuration.")
    @visibility("create", "read")
    hl7Configuration?: {
      @doc("Optional string representing the carriage return character.")
      @maxLength(1)
      carriageReturn?: string;

      @doc("Optional boolean indicating if the carriage return is optional.")
      carriageReturnOptional?: boolean;

      @doc("Optional string representing the end block delimiter.")
      @maxLength(1)
      endBlockDelimiter?: string;

      @doc("Optional enum representing the error acknowledgment strategy.")
      errorAckStrategy?: ErrorAckStrategy;

      @doc("Optional boolean indicating if no start byte is required.")
      noStartByteRequired?: boolean;

      @doc("Optional string representing the start block delimiter.")
      @maxLength(1)
      startBlockDelimiter?: string;
    };

    @doc("The Listener Configuration to be used for hl7 connector configuration.")
    @visibility("create", "read")
    messageListenerConfiguration?: {
      @doc("The inactivity timeout in seconds.")
      @minValue(1)
      inactivityTimeoutInSeconds?: int32;

      @doc("The size of the message buffer.")
      @minValue(1)
      messageBufferSize?: int32;

      @doc("The port number to use.")
      @minValue(0)
      @maxValue(65535)
      @visibility("create", "read", "update")
      port: int32;

      @doc("Indicates whether to reuse the connection.")
      reuseConnection?: boolean;
    };

    @doc("The Storage Endpoint Configuration to be used for hl7 connector configuration.")
    @visibility("create", "read")
    storageEndpointConfiguration?: {
      @doc("URL of the blob storage where the output will be stored.")
      @visibility("create", "read", "update")
      @pattern("^https://.*$")
      blobUrl: string;

      @doc("Name of the container in the blob storage.")
      @pattern("^[a-z0-9](?!.*--)[a-z0-9-]{1,61}[a-z0-9]$")
      @visibility("create", "read", "update")
      container: string;

      @doc("Optional file extension for the output file.")
      @pattern("^[a-zA-Z0-9]+$")
      fileExtension?: string;

      @doc("Optional format for the output file name.")
      @maxLength(255)
      outputFileNameFormat?: string;

      @doc("Optional format for the output folder.")
      @maxLength(255)
      outputFolderFormat?: string;
    };
  };

  @doc("The status of the last operation.")
  @visibility("read")
  provisioningState?: ProvisioningState;
}

@armResourceOperations
interface Hl7EdgeConnectors {
  get is ArmResourceRead<Hl7EdgeConnector>;
  createOrUpdate is ArmResourceCreateOrReplaceAsync<Hl7EdgeConnector>;
  update is ArmResourcePatchAsync<Hl7EdgeConnector, Hl7EdgeConnectorProperties>;
  delete is ArmResourceDeleteWithoutOkAsync<Hl7EdgeConnector>;
  listByResourceGroup is ArmResourceListByParent<Hl7EdgeConnector>;
  listBySubscription is ArmListBySubscription<Hl7EdgeConnector>;
}
