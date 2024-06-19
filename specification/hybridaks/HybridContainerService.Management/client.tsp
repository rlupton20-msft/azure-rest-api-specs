import "./main.tsp";
import "@azure-tools/typespec-client-generator-core";

using Private.HybridContainerService;

@@Azure.ClientGenerator.Core.clientName(HybridIdentityMetadataOperationGroup,
  "HybridIdentityMetadata"
);
