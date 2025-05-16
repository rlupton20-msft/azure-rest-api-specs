import {
  updateExamples,
  compilePackage,
  dataPlanePackageNames,
} from "./common.mjs";

const runMain = () => {
  updateExamples({
    tspPackageDir: "specification/discoverydev/Discovery.Workspace",
    swaggerPackageDir:
      "specification/discoverydev/data-plane/Microsoft.Discovery.Workspace",
  });
};

runMain();
