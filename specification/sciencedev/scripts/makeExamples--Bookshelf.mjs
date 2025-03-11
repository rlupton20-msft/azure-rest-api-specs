import {  updateExamples, compilePackage, dataPlanePackageNames } from "./common.mjs";

const runMain = () => {
  updateExamples({
    tspPackageDir: "specification/sciencedev/Science.Bookshelf",
    swaggerPackageDir: "specification/sciencedev/data-plane/Microsoft.Science.Bookshelf",

  })
}

runMain()