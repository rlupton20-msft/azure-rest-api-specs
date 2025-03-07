import { existsSync, mkdirSync, readdirSync, readFileSync, rmSync, writeFileSync} from "fs";
import { resolve } from "path"
import { execSync } from "child_process"


const runMain = () => {

  const packageDirs = [
    "./specification/sciencedev/Science.Management",
    "./specification/sciencedev/Science.Workspace",
    "./specification/sciencedev/Science.Catalog",
    "./specification/sciencedev/Science.Bookshelf",
  ]
  console.log("Start: Compiling TypeSpec packages")
  console.log("---------------------------")
  for(const pkg of packageDirs) {
    const pkgPath = resolve(pkg)
    try {
      console.log("npx tsp compile ", pkgPath)
      execSync(`npx tsp compile ${pkgPath}`, { stdio: 'inherit' })
    } catch (err) {
      console.warn(err)
    }
  }
  console.log("Finished: Compiling TypeSpec packages")
  console.log("---------------------------")
}
runMain()