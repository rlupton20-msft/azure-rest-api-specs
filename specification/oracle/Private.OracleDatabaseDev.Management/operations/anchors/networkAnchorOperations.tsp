import "@azure-tools/typespec-azure-resource-manager";
import "../../models/anchors/networkAnchor.tsp";

using Azure.ResourceManager;
using Autorest;
using TypeSpec.Versioning;

namespace Private.OracleDatabaseDev;

@added(Versions.v20250301_preview)
@armResourceOperations(NetworkAnchor)
interface NetworkAnchors
  extends OracleTrackedResource<NetworkAnchor, NetworkAnchorProperties> {}
