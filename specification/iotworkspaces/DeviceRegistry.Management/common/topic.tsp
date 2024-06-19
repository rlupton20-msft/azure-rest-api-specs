import "@azure-tools/typespec-azure-core";
import "@typespec/versioning";

using Azure.Core;
using TypeSpec.Versioning;

namespace Private.DeviceRegistry;

@doc("Object that describes the topic information.")
@added(Versions.v2024_07_01_preview)
model Topic {
  @doc("The topic path for messages published to an MQTT broker.")
  path: string;

  @doc("When set to true, messages published to an MQTT broker will have the retain flag set. Default: false.")
  retain?: boolean = false;
}
