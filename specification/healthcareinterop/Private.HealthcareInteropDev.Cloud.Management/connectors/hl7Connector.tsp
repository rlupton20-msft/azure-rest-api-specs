import "@typespec/rest";
import "@typespec/http";
import "@azure-tools/typespec-azure-resource-manager";
import "./../common/provisioningState.tsp";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.ResourceManager;

namespace Private.HealthcareInteropDev;

@doc("The healthcare interop Hl7 connector resource.")
@resource("hl7connectors")
model Hl7Connector is TrackedResource<Hl7ConnectorProperties> {
  @doc("The name of the Hl7 connector resource")
  @pattern("^[a-zA-Z0-9-]{3,24}$")
  @key("hl7ConnectorName")
  @segment("hl7connectors")
  @path
  name: string;
}

@doc("Hl7Connector properties")
model Hl7ConnectorProperties {
  @doc("The status of the last operation.")
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningLROState;

  @doc("Resource ID of the hub resource to associate the hl7 connector to.")
  hubResourceId: Azure.Core.armResourceIdentifier<[
    {
      type: "Private.HealthcareInteropDev/hubs";
    }
  ]>;

  @doc("The receiver configuration to be used for the Hl7 connector.")
  receiver?: {
    @doc("The receiver endpoint configuration to be used for Hl7 connector.")
    hl7Configuration?: Hl7ReceiverConfiguration;

    @doc("The listener configuration to be used for Hl7 connector.")
    messageListenerConfiguration: MessageListenerConfiguration;
  };
}

@doc("The Hl7 receiver endpoint configuration properties.")
model Hl7ReceiverConfiguration {
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
}

@doc("The message listener configuration properties.")
model MessageListenerConfiguration {
  @doc("The inactivity timeout in seconds.")
  @minValue(1)
  inactivityTimeoutInSeconds?: int32;

  @doc("The size of the message buffer.")
  @minValue(1)
  messageBufferSize?: int32;

  @doc("The port number to use.")
  @minValue(0)
  @maxValue(65535)
  port: int32;

  @doc("Indicates whether to reuse the connection.")
  reuseConnection?: boolean;
}

@doc("The error acknowledgment strategy.")
union ErrorAckStrategy {
  string,

  /** The error acknowledgment strategy is to send a negative acknowledgment (NACK) message */
  SendNackOnError: "SendNackOnError",

  /** The error acknowledgment strategy is to never send a negative acknowledgment (NACK) message */
  NeverSendNack: "NeverSendNack",
}

@armResourceOperations
interface Hl7Connectors {
  get is ArmResourceRead<Hl7Connector>;
  createOrUpdate is ArmResourceCreateOrReplaceAsync<Hl7Connector>;
  update is ArmResourcePatchAsync<Hl7Connector, Hl7ConnectorProperties>;
  delete is ArmResourceDeleteWithoutOkAsync<Hl7Connector>;
  listByResourceGroup is ArmResourceListByParent<Hl7Connector>;
  listBySubscription is ArmListBySubscription<Hl7Connector>;
}
