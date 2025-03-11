import {  updateExamples, compilePackage, dataPlanePackageNames } from "./common.mjs";

const runMain = () => {
  updateExamples({
    tspPackageDir: "specification/sciencedev/Science.Management",
    swaggerPackageDir: "specification/sciencedev/resource-manager/Private.Science",

  })
}

runMain()