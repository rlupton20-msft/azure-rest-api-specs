import { compilePackage, dataPlanePackageNames } from "./common.mjs";
import { resolve } from "path";

const runMain = () => {

  const packageNames = [
    "Management",
    ...dataPlanePackageNames
  ]
  console.log("Start: Compiling TypeSpec packages")
  console.log("---------------------------")
  for(const packageName of packageNames) {

    const packagePath = resolve(`./specification/sciencedev/Science.${packageName}`)
    compilePackage({packagePath})
  }
  console.log('\x1b[32m', "Finished: Compiling TypeSpec packages")
  console.log("---------------------------")
}
runMain()