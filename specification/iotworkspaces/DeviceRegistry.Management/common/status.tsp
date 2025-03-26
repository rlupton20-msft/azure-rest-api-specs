import "@typespec/http";
import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Http;
using TypeSpec.Rest;
using Azure.Core;
using TypeSpec.Versioning;
using Azure.ResourceManager;
using OpenAPI;

namespace Private.DeviceRegistry;

@doc("Defines the status config properties.")
@added(Versions.v2025_07_01_preview)
model StatusConfig {
  @doc("A read only incremental counter indicating the number of times the configuration has been modified from the perspective of the current actual (Edge) state of the CRD. Edge would be the only writer of this value and would sync back up to the cloud. In steady state, this should equal version.")
  @visibility(Lifecycle.Read)
  version?: int64;

  @doc("A read only timestamp indicating the last time the configuration has been modified from the perspective of the current actual (Edge) state of the CRD. Edge would be the only writer of this value and would sync back up to the cloud.")
  @visibility(Lifecycle.Read)
  lastTransitionTime?: utcDateTime;

  @doc("Object to transfer and persist errors that originate from the Edge.")
  @visibility(Lifecycle.Read)
  error?: StatusError;
}

@doc("Defines the status config error properties.")
@added(Versions.v2025_07_01_preview)
model StatusError {
  @doc("Error code for classification of errors (ex: '400', '404', '500', etc.).")
  @visibility(Lifecycle.Read)
  code?: string;

  @doc("Human readable helpful error message to provide additional context for error (ex: “capability Id 'foo' does not exist”).")
  @visibility(Lifecycle.Read)
  message?: string;

  @doc("Array of event statuses that describe the status of each event.")
  @visibility(Lifecycle.Read)
  @identifiers(#[])
  details?: StatusErrorDetails[];

  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "innerError property field is custom defined by services."
  @doc("A set of key-value pairs that contain service specific details set by the service.")
  @visibility(Lifecycle.Read)
  innerError?: Record<unknown>;
}

@doc("Defines the status config error details properties.")
@added(Versions.v2025_07_01_preview)
model StatusErrorDetails {
  @doc("Multi-part error code for classification and root causing of errors (ex: 400.200.100.432).")
  @visibility(Lifecycle.Read)
  code?: string;

  @doc("Human readable helpful error message to provide additional context for error (ex: “Authentication method not supported”).")
  @visibility(Lifecycle.Read)
  message?: string;

  @doc("Human readable helpful detailed text context for debugging (ex: “The following mechanisms are supported...”).")
  @visibility(Lifecycle.Read)
  info?: string;

  @doc("Unique identifier for the transaction to aid in debugging.")
  @visibility(Lifecycle.Read)
  correlationId?: string;
}
