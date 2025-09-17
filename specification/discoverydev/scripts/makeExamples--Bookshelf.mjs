import {
  updateExamples,
  compilePackage,
  dataPlanePackageNames,
} from "./common.mjs";

const runMain = () => {
  updateExamples({
    tspPackageDir: "specification/discoverydev/Discovery.Bookshelf",
    swaggerPackageDir:
      "specification/discoverydev/data-plane/Microsoft.Discovery.Bookshelf",
  });
};

runMain();
