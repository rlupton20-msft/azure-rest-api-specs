import {
  updateExamples,
  compilePackage,
  dataPlanePackageNames,
} from "./common.mjs";

const runMain = () => {
  updateExamples({
    tspPackageDir: "specification/discoverydev/Discovery.Management",
    swaggerPackageDir:
      "specification/discoverydev/resource-manager/Private.Discovery",
  });
};

runMain();
