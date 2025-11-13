import { resolve } from "path";
import { execSync } from "child_process";
import fs from "fs";
import fastGlob from "fast-glob";

export const apiVersions = ["2025-12-01-preview"];
export const dataPlanePackageNames = ["Bookshelf", "Workspace"];

export const compilePackage = ({ packagePath }) => {
  //try {
  const cmd = `npx tsp compile ${packagePath}`;
  console.log(cmd);
  execSync(cmd, { stdio: "inherit" });
  // } catch (err) {
  //   console.warn(err)
  // }
};

export const validatePackage = ({ packagePath }) => {
  const cmd = `npx tsv ${packagePath}`;
  console.log(cmd);
  execSync(cmd, { stdio: "inherit" });
};

export const updateExamples = ({ tspPackageDir, swaggerPackageDir }) => {
  console.log("Deleting generated Swagger file and examples:", tspPackageDir);
  const dirGlobsToClean = [
    resolve(tspPackageDir, "examples/**/*_Gen.json"),
    resolve(swaggerPackageDir, "preview/**/examples/*_Gen.json"),
  ];

  for (const _glob of dirGlobsToClean) {
    console.log("\x1b[90m", ` • Deleting Swagger examples from: ${_glob}`);
    for (const filePath of fastGlob.sync(_glob)) {
      fs.rmSync(filePath);
    }
  }

  compilePackage({
    packagePath: resolve(tspPackageDir),
  });

  console.log("Generating examples:", tspPackageDir);

  for (const apiVersion of apiVersions) {
    const swaggerDir = resolve(swaggerPackageDir, `preview/${apiVersion}`);
    for (const fileName of fs.readdirSync(swaggerDir)) {
      const filePath = resolve(swaggerDir, fileName);
      if (
        fs.lstatSync(filePath).isFile() &&
        filePath.toLowerCase().endsWith(".json")
      ) {
        // try {
        const cmd = `npx oav generate-examples ${filePath}`;
        console.log(`\x1b[35m${cmd}`); // 35
        execSync(cmd, { stdio: "inherit" });
        // } catch (error) {
        //   console.error('\x1b[31m%s\x1b[39m', `Issues occurred running oav. See logs above: ${error.message}`)
        // }
      }
    }
  }

  console.log(
    "\x1b[32m",
    "Finished generating examples for",
    swaggerPackageDir,
  );
};
