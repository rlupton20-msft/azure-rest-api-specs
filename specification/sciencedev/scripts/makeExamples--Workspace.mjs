import {  updateExamples, compilePackage, dataPlanePackageNames } from "./common.mjs";

const runMain = () => {
  updateExamples({
    tspPackageDir: "specification/sciencedev/Science.Workspace",
    swaggerPackageDir: "specification/sciencedev/data-plane/Microsoft.Science.Workspace",

  })
}

runMain()