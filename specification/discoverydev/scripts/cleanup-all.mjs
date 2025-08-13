import fs, {
  existsSync,
  mkdirSync,
  readdirSync,
  readFileSync,
  rmSync,
  writeFileSync,
} from "fs";
import { fileURLToPath } from "url";
import { basename, dirname, resolve } from "path";
import * as crypto from "node:crypto";

import {
  apiVersions,
  dataPlanePackageNames,
  validatePackage,
} from "./common.mjs";
import path from "node:path";

const getPathForOperationId = ({ swaggerObject, operationId }) => {
  for (const [basePath, operations] of Object.entries(swaggerObject.paths)) {
    for (const [operationName, operationDetails] of Object.entries(
      operations,
    )) {
      if (operationDetails.operationId === operationId) {
        return basePath;
      }
    }
  }
  console.warn(`Unable to find operation "${operationId}"`);
  // throw new Error(`Unable to find operation "${operationId}"`)
};

const fixSetLists = ({ properties }) => {
  const res = {
    ...properties,
  };
  for (const propName of discoveryTypeNames) {
    const key = `${propName}s`;
    if (Array.isArray(res[key])) {
      for (const ii in res[key]) {
        res[key][ii][`${propName}Id`] = makeArmId({
          resourceTypeName: propName,
        });
      }
    }
  }
  return res;
};

const readJsonFromFile = async ({ resourceTypeName, propertyName }) => {
  if (!resourceTypeName) {
    throw new Error("Resource type name is missing");
  }
  const __filename = fileURLToPath(import.meta.url);
  const __dirname = dirname(__filename);
  const filePath = path.resolve(
    __dirname,
    "json",
    resourceTypeName.toLowerCase(),
    `${propertyName}.json`,
  );
  if (!fs.existsSync(filePath)) {
    throw new Error(
      `readJsonFromFile: Could not find JSON file for "${resourceTypeName}.${propertyName}": ${filePath}`,
    );
  }
  // const rawText = fs.readFileSync(filePath, "utf8");
  // if (!rawText) {
  //   throw new Error(
  //     `readJsonFromFile: No file content for "${resourceTypeName}.${propertyName}": ${filePath}`,
  //   );
  // }
  let parsedJson = null;
  try {
    const rawText = fs.readFileSync(filePath, "utf8");
    parsedJson = JSON.parse(rawText);
  } catch (err) {
    throw new Error(`Invalid JSON file: ${filePath}`);
  }
  console.log(
    `      - replacing ${resourceTypeName} > ${propertyName} with: ${filePath}.`,
  );
  return parsedJson;
    } 

const uuid = "00000011-1111-2222-2222-123456789111";
const fixPropertiesBag = async ({ properties, resourceTypeName }) => {
  if (!properties) {
    return undefined;
  }
  const res = {
    ...properties,
    workspaceId: !properties.workspaceId
      ? undefined
      : "/subscriptions/31735C59-6307-4464-8B80-3675223F23D2/providers/Microsoft.Discovery/workspaces/workspace1",
    subnetId: !properties?.subnetId
      ? undefined
      : "/subscriptions/31735C59-6307-4464-8B80-3675223F23D2/providers/Microsoft.Network/virtualNetworks/virtualnetwork1",
    managedOnBehalfOfConfiguration: !properties?.managedOnBehalfOfConfiguration
      ? undefined
      : {
          moboBrokerResources: [
            {
              id: "/subscriptions/31735C59-6307-4464-8B80-3675223F23D2/providers/Microsoft.Storage/storageAccounts/storage1",
            },
          ],
        },
    identities: properties.identities
      ? fixManagedIds({ object: properties.identities })
      : undefined,
    ...fixDiscoverIds({ object: properties }),
    definitionContent:
      resourceTypeName && properties.definitionContent
        ? await readJsonFromFile({
            resourceTypeName,
            propertyName: "definitionContent",
          })
        : undefined,
  };
  for (const propName of ["workspaceIdentity"]) {
    if (res[propName]) {
      res[propName] = managedIdentityResourceObj;
    }
  }
  return fixSetLists({ properties: res });
};

const managedIdentityResourceObj = {
  id: "/subscriptions/31735C59-6307-4464-8B80-3675223F23D2/providers/Microsoft.ManagedIdentity/userAssignedIdentities/managedid1",
};

const makeArmId = ({
  resourceTypeName,
  name,
  provider = "Microsoft.Discovery",
}) => {
  let rtName = resourceTypeName;
  if (!rtName.endsWith("s")) {
    const irregularPlurals = {
      bookshelf: "bookshelves",
    };
    rtName = irregularPlurals[resourceTypeName] ?? `${resourceTypeName}s`;
  }

  return `/subscriptions/31735C59-6307-4464-8B80-3675223F23D2/resourceGroups/rgdiscovery/providers/${provider}/${rtName}/${name || resourceTypeName + "12"}`;
};

const fixManagedIds = ({ object }) => {
  const res = {
    ...object,
  };
  const identityPropertyNames = ["clusterIdentity", "kubeletIdentity"];
  for (const propertyName of identityPropertyNames) {
    if (res[propertyName]) {
      res[propertyName] = managedIdentityResourceObj;
    }
  }
  const identityListPropertyNames = ["workloadIdentities"];

  for (const propertyName of identityListPropertyNames) {
    const _it = res[propertyName];
    if (_it && typeof _it === "object" && !Array.isArray(_it)) {
      for (const [key, val] of Object.entries(_it)) {
        _it[key] = fixIdentity({ identity: val });
      }
      res[propertyName] = _it;
    }
  }
  return res;
};

const discoveryTypeNames = [
  "storage",
  "supercomputer",
  "dataContainer",
  "dataAsset",
  "bookshelf",
  "tool",
  "agent",
  "model",
  "nodePool",
  "workspace",
  "workflow",
];

const fixDiscoverIds = ({ object }) => {
  const resp = {
    // ...object
  };
  for (const resourceTypeName of discoveryTypeNames) {
    if (object[`${resourceTypeName}Id`]) {
      resp[`${resourceTypeName}Id`] = makeArmId({
        resourceTypeName,
      });
    }
    if (object[`${resourceTypeName}Ids`]) {
      resp[`${resourceTypeName}Ids`] = [
        makeArmId({
          resourceTypeName,
        }),
      ];
    }
  }
  if (object.entryReferenceId) {
    resp.entryReferenceId = makeArmId({ resourceTypeName: "agents" });
  }
  if (object.onlineEndpoint) {
    let wsId = makeArmId({
      resourceTypeName: "workspaces",
      provider: "Microsoft.MachineLearningServices",
    });
    resp.onlineEndpoint = `${wsId}/onlineEndpoints/ep2`;
  }
  return resp;
};
const fixIdentity = ({ identity }) => {
  if (!identity) {
    return undefined;
  }
  const resp = {
    ...identity,
    principalId: identity?.principalId && uuid,
    tenantId: identity?.tenantId && uuid,
    clientId: identity?.clientId && uuid,
  };
  if (identity?.userAssignedIdentities) {
    for (const [key, { principalId, clientId, ...rest }] of Object.entries(
      identity?.userAssignedIdentities,
    )) {
      resp.userAssignedIdentities[key] = {
        ...rest,
        principalId: principalId && uuid,
        clientId: clientId && uuid,
      };
    }
  }
  return resp;
};

const definitionContent = "artifact_definition_content_in_yaml_format";

const fixIds = async ({
  swaggerObject,
  exampleObject,
  operationId,
  isControlPlane,
}) => {
  let basePath = getPathForOperationId({
    swaggerObject,
    operationId,
  });
  if (!basePath) {
    console.warn(`Unable to find base path "${basePath}"`);
    return exampleObject;
  }
  const resourceTypeName = operationId.split("_")[0];
  for (const [returnCode, { body, ...rest }] of Object.entries(
    exampleObject.responses,
  )) {
    if (!body) {
      continue;
    }
    const { id, name, identity, properties, ...bodyRest } = body;
    for (const [propName, propVal] of Object.entries(
      exampleObject.parameters,
    )) {
      basePath = basePath.replaceAll(`{${propName}}`, propVal);
    }
    if (basePath.indexOf(":") > 0) {
      basePath = basePath.substring(0, basePath.indexOf(":"));
    }
    if (basePath.indexOf("/operations/") > 0) {
      basePath = basePath.substring(0, basePath.indexOf("/operations/"));
    }
    let _name = basePath.substring(basePath.lastIndexOf("/") + 1);
    // if(_name.indexOf(":") > 0) {
    //   _name = _name.substring(0, _name.indexOf(":"))
    // }

    if (Object.keys(body).length > 0) {
      let fixedProperties = properties;
      if (properties) {
        fixedProperties = await fixPropertiesBag({
          properties,
          resourceTypeName,
        });
      }
      exampleObject.responses[returnCode] = {
        ...rest,
        body: {
          id: !id
            ? undefined
            : isControlPlane
              ? makeArmId({ resourceTypeName, name: _name })
              : basePath,
          name: name && _name ? _name : name,
          ...bodyRest,
          identity: identity && fixIdentity({ identity }),

          properties: fixedProperties,

          // Handle list responses
          value: !Array.isArray(body?.value)
            ? body?.value
            : body.value.map(({ id, name, identity, properties, ..._val }) => ({
                id:
                  id && isControlPlane
                    ? makeArmId({ resourceTypeName, name })
                    : undefined,
                name,
                ..._val,
                identity: identity && fixIdentity({ identity }),
                ...fixDiscoverIds({ object: _val }),
                properties: fixedProperties,
              })),
          definitionContent: !body.definitionContent
            ? undefined
            : definitionContent,
        },
      };
    }
  }
  return exampleObject;
};

const fixRegexIssues = ({ object }) => {
  const res = {
    ...object,
  };
  for (const [key, value] of Object.entries(object)) {
    if (
      typeof value === "string" &&
      value?.startsWith(
        "Replace this value with a string matching RegExp ^[a-zA-Z0-9-]",
      )
    ) {
      //{3,24}$")) {
      res[key] = crypto.randomBytes(9).toString("hex");
    }
  }
  return res;
};

const runMain = async () => {
  console.log("***********************************");
  const dirs = [];
  const makeDirs = () => {
    for (const apiVersion of apiVersions) {
      dirs.push({
        inDir: `specification/discoverydev/resource-manager/Private.Discovery/preview/${apiVersion}/examples`,
        outDir: `specification/discoverydev/Discovery.Management/examples/${apiVersion}`,
      });
      for (const dpPackageName of dataPlanePackageNames) {
        dirs.push({
          inDir: `specification/discoverydev/data-plane/Microsoft.Discovery.${dpPackageName}/preview/${apiVersion}/examples`,
          outDir: `specification/discoverydev/Discovery.${dpPackageName}/examples/${apiVersion}`,
        });
      }
    }
    return dirs;
  };
  for (const { inDir, outDir } of makeDirs()) {
    const outDirPath = resolve(outDir);
    const isControlPlane = outDirPath.includes(".Management/");

    const swaggerDir = resolve(dirname(inDir));
    console.log("swaggerDir: ", swaggerDir);
    let swaggerFile = "";
    for (const file of readdirSync(swaggerDir)) {
      if (file.endsWith(".json")) {
        swaggerFile = resolve(swaggerDir, file);
      }
    }
    if (!swaggerFile) {
      throw new Error("No specification file found");
    }
    const fileText = readFileSync(swaggerFile, "utf8");
    const swaggerObject = JSON.parse(fileText);
    console.log("swaggerFile: ", swaggerFile);

    console.log("\nDeleting:", outDirPath);
    rmSync(outDirPath, { recursive: true, force: true });
    mkdirSync(outDirPath, { recursive: true });
    console.log("\n------------------------");
    console.log("Processing: ", inDir);
    for (const file of readdirSync(inDir)) {
      if (!file.endsWith("_Gen.json")) {
        continue;
      }
      const filePath = resolve(inDir, file);
      console.log("   - ", file);
      let { title, ...contents } = JSON.parse(readFileSync(filePath, "utf8"));
      if (title.indexOf("] rule") > 0) {
        title = title.substring(0, title.indexOf("] rule") + "] rule".length);
      }
      if (file.includes("_MaximumSet")) {
        title = title.replaceAll("MinimumSet", "MaximumSet");
        if (!title.endsWith(" - generated by [MaximumSet] rule")) {
          title = `${title} - generated by [MaximumSet] rule`;
        }
      } else if (file.includes("_MinimumSet")) {
        title = title.replaceAll("MaximumSet", "MinimumSet");
        if (!title.endsWith(" - generated by [MinimumSet] rule")) {
          title = `${title} - generated by [MinimumSet] rule`;
        }
      }
      const resourceTypeName = contents.operationId.split("_")[0];
      if (contents.parameters) {
        contents.parameters = fixRegexIssues({ object: contents.parameters });

        if (contents.parameters.resource?.definitionContent) {
          contents.parameters.resource.definitionContent = definitionContent;
        }
        if (contents.parameters.resource?.properties) {
          // Fix issue with sending managedOnBehalfOfConfiguration in create/update payload
          contents.parameters.resource.properties.managedOnBehalfOfConfiguration =
            undefined;
          contents.parameters.resource.properties = await fixPropertiesBag({
            properties: contents.parameters.resource.properties,
            resourceTypeName,
          });
        }
        if (contents.parameters.properties?.properties) {
          // Fix issue with sending managedOnBehalfOfConfiguration in create/update payload
          contents.parameters.properties.properties.managedOnBehalfOfConfiguration =
            undefined;
          contents.parameters.properties.properties = await fixPropertiesBag({
            properties: contents.parameters.properties.properties,
            resourceTypeName,
          });
        }
      }
      // else {
      //   console.log(`---- ${filePath} no parameters?`)
      // }
      try {
        await fixIds({
          swaggerObject,
          exampleObject: contents,
          operationId: contents.operationId,
          isControlPlane,
        });
      } catch (err) {
        console.log(`Failed to fox IDs for ${file}: ${err.message}`);
        throw err;
      }
      const regexToReplace =
        "Replace this value with a string matching RegExp ^[a-zA-Z0-9-]{3,24}$";
      const fileText = JSON.stringify(
        {
          title,
          ...contents,
        },
        null,
        2,
      ).replaceAll(regexToReplace, "myReallyGoodName");
      writeFileSync(filePath, fileText);
      writeFileSync(resolve(outDirPath, file), fileText);
    }
  }
  // import("./validate-all.mjs")
};

runMain().catch((err) => {
  console.error(err);
});
