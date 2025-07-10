import { resolve } from "path"
import { execSync } from "child_process"

export const apiVersions = [
  "2024-11-01-preview",
  "2025-07-01-preview"
]
export const dataPlanePackageNames = [
  "Bookshelf",
  "Catalog",
  "Workspace",
]

export const compilePackage = ({packagePath}) => {

  //try {
  const cmd = `npx tsp compile ${packagePath}`
  console.log(cmd)
  execSync(cmd, { stdio: 'inherit' })
  // } catch (err) {
  //   console.warn(err)
  // }
}

export const validatePackage = ({packagePath}) => {
  const cmd = `npx tsv ${packagePath}`
  console.log(cmd)
  execSync(cmd, { stdio: 'inherit' })
}



export const updateExamples = ({tspPackageDir, swaggerPackageDir}) => {
  console.log("Deleting generated Swagger file and examples:", tspPackageDir);
  const dirsToClean = [
    resolve(tspPackageDir, "examples/**/*_Gen.json"),
    resolve(swaggerPackageDir, "preview/**/examples/*_Gen.json"),
    resolve(swaggerPackageDir, "preview/**/science*.json"),
  ]
  for(const path of dirsToClean) {
    const cmd = `rm -f  ${path}`
    console.log(cmd);
    execSync(cmd, { stdio: 'inherit' });
  }

  compilePackage({
    packagePath: resolve(tspPackageDir),
  })

  console.log("Generating examples:", tspPackageDir);
  const swaggerFiles = apiVersions.map((version) => resolve(swaggerPackageDir, `preview/${version}/science*.json`))
  for(const swaggerFile of swaggerFiles) {
    // try {
      const cmd = `npx oav generate-examples ${swaggerFile}`
      console.log(cmd);
      execSync(cmd, { stdio: 'inherit' });
    // } catch (error) {
    //   console.error('\x1b[31m%s\x1b[39m', `Issues occurred running oav. See logs above: ${error.message}`)
    // }
  }


  console.log('\x1b[32m', "Finished generating examples for", swaggerPackageDir);

}


