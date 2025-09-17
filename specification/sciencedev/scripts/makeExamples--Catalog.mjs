import {  updateExamples, compilePackage, dataPlanePackageNames } from "./common.mjs";

const runMain = () => {
  updateExamples({
    tspPackageDir: "specification/sciencedev/Science.Catalog",
    swaggerPackageDir: "specification/sciencedev/data-plane/Microsoft.Science.Catalog",

  })
}

runMain()