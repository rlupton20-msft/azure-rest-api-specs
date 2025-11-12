import {
  updateExamples,
  compilePackage,
  dataPlanePackageNames,
} from "./common.mjs";

const runMain = () => {
  updateExamples({
    tspPackageDir: "specification/discoverydev/Discovery.Supercomputer",
    swaggerPackageDir:
      "specification/discoverydev/data-plane/Microsoft.Discovery.Supercomputer",
  });
};

runMain();
