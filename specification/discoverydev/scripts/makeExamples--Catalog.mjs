import {  updateExamples, compilePackage, dataPlanePackageNames } from "./common.mjs";

const runMain = () => {
  updateExamples({
    tspPackageDir: "specification/discoverydev/Discovery.Catalog",
    swaggerPackageDir: "specification/discoverydev/data-plane/Microsoft.Discovery.Catalog",

  })
}

runMain()