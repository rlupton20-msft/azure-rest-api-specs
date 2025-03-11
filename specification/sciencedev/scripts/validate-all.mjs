import { validatePackage, dataPlanePackageNames } from "./common.mjs";
import { resolve } from "path";
import { execSync } from "child_process";

const runMain = () => {

  execSync("npx prettier -w specification/sciencedev/**/*.json", {stdio: 'pipe'})
  const packageNames = [
    "Management",
    ...dataPlanePackageNames
  ]
  console.log("Start: Validating TypeSpec packages")
  console.log("+------------------------------------------------")
  const failedPackageNames = []
  for (const packageName of packageNames) {
    try {
      const packagePath = resolve(`./specification/sciencedev/Science.${packageName}`)
      validatePackage({ packagePath })

    } catch (err) {
      failedPackageNames.push(packageName)
      console.warn('\x1b[31m%s\x1b[39m', `Validation failed. See logs above: ${err.message}`)
    }
  }
  if (failedPackageNames.length) {
    console.warn(`\x1b[31m%s\x1b[39m`, `See logs above for validation errors: ${JSON.stringify(failedPackageNames)}`)
  } else {
    console.log("\n\x1b[32mFinished: Validating TypeSpec packages")
  }
  console.log("+------------------------------------------------")
}
runMain()