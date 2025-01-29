import "@azure-tools/typespec-azure-resource-manager";
import "../../models/anchors/resourceAnchor.tsp";

using Azure.ResourceManager;
using Autorest;
using TypeSpec.Versioning;

namespace Private.OracleDatabaseDev;

@added(Versions.v20250301_preview)
@armResourceOperations(ResourceAnchor)
interface ResourceAnchors
  extends OracleTrackedResource<ResourceAnchor, ResourceAnchorProperties> {}
