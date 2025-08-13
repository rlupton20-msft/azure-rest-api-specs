import "@typespec/http";
import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

namespace Microsoft.Monitor;

@doc("Defines the properties for signal preview SLI.")
model SignalPreviewSliProperties {
  @doc("Determines how the SLI is evaluated—either based on request counts or time windows.")
  evaluationType: EvaluationType;

  @doc("Defines the SLO baseline associated with the SLI.")
  baselineProperties?: BaselineProperties;

  // Window-based properties (used when evaluationType is WindowBased)
  @doc("Defines the uptime criteria for window-based SLIs.")
  windowUptimeCriteria?: WindowUptimeCriteria;

  @doc("Signals used for window-based SLI calculations.")
  signals?: Signal;

  // Request-based properties (used when evaluationType is RequestBased)
  @doc("Represents good signals used in request-based SLI calculations.")
  goodSignals?: Signal;

  @doc("Represents total signals used in request-based SLI calculations.")
  totalSignals?: Signal;
}