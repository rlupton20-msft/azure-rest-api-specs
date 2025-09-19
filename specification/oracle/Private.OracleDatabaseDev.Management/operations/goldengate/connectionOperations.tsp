import "../../models/goldengate/connection.tsp";
import "../commons.tsp";

using Azure.ResourceManager;
using Autorest;
using TypeSpec.Versioning;

namespace Private.OracleDatabaseDev;

@added(Versions.v20251001_preview)
@armResourceOperations(Connection)
interface Connections
  extends OracleTrackedResource<Connection, ConnectionProperties> {}
