import "./connectionBase.tsp";
import "./kafkaConnectionDetails.tsp";
import "./microsoftFabricConnectionDetails.tsp";
import "./oracleConnectionDetails.tsp";
using TypeSpec.Versioning;
using Azure.ResourceManager;

namespace Private.OracleDatabaseDev;

/**
 * Alias for resource.properties: OAS v2 polymorphism is done via discriminator + allOf (not oneOf),
 * so we use base model here.
 */
alias ConnectionProperties = ConnectionBaseProperties;
@added(Versions.v20251001_preview)
@doc("The Connection resource model.")
model Connection is TrackedResource<ConnectionProperties> {
  ...ResourceNameParameter<Connection>;
  ...AvailabilityZonesProperty;
}
