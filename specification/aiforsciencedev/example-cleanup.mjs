import { readdirSync, readFileSync, writeFileSync} from "fs";
import { resolve } from "path"

const runMain = () => {
  const inDirs = [
    "specification/aiforsciencedev/Science.Catalog/examples/2024-11-01-preview",
    "specification/aiforsciencedev/Science.Management/examples/2024-11-01-preview",
    "specification/aiforsciencedev/Science.Workspace/examples/2024-12-01-preview",
  ]
  for(const dir of inDirs) {
    console.log("\n------------------------")
    console.log("Processing: ", dir)
    for(const file of readdirSync(dir)) {
      const filePath = resolve(dir, file);
      console.log("   - ", file)
      let {title, ...contents} = JSON.parse(readFileSync(filePath, "utf8"));
      if(title.indexOf(" ") > 0) {
        title = title.substring(0,title.indexOf(" "))
      }
      if(file.includes("_MaximumSet")) {
        title = title.replace("_MinimumSet", "_MaximumSet");
        if(!title.endsWith("_MaximumSet")) {
          title = `${title}_MaximumSet`
        }

      } else if(file.includes("_MinimumSet")) {
        title = title.replace("_MaximumSet", "_MinimumSet");
        if(!title.endsWith("_MinimumSet")) {
          title = `${title}_MinimumSet`
        }
      }
      writeFileSync(
        filePath,
          JSON.stringify({
          title,
          ...contents,
        }, null, 2)
      )
    }
  }
}
runMain()
