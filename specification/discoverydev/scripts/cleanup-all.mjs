import {
  existsSync,
  mkdirSync,
  readdirSync,
  readFileSync,
  rmSync,
  writeFileSync,
} from "fs";
import { basename, dirname, resolve } from "path";
import * as crypto from "node:crypto";

import {
  apiVersions,
  dataPlanePackageNames,
  validatePackage,
} from "./common.mjs";

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
        res[key][ii][`${propName}Id`] = makeDiscoveryArmId({
          resourceTypeName: propName,
        });
      }
    }
  }
  return res;
};

const uuid = "00000011-1111-2222-2222-123456789111";
const fixPropertiesBag = ({ properties }) => {
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
  };
  for(const propName of ["workspaceIdentity"]) {
    if(res[propName]) {
      res[propName] = managedIdentityResourceId;
    }
  }
  return fixSetLists({ properties: res });
};

const managedIdentityResourceId =
  "/subscriptions/31735C59-6307-4464-8B80-3675223F23D2/providers/Microsoft.ManagedIdentity/userAssignedIdentities/managedid1";

const makeDiscoveryArmId = ({ resourceTypeName }) => {
  const irregularPlurals = {
    bookshelf: "bookshelves",
  };
  const pathSegment =
    irregularPlurals[resourceTypeName] ?? `${resourceTypeName}s`;
  return `/subscriptions/31735C59-6307-4464-8B80-3675223F23D2/providers/Microsoft.Discovery/${pathSegment}/${resourceTypeName}12`;
};

const fixManagedIds = ({ object }) => {
  const res = {
    ...object,
  };
  const identityPropertyNames = ["clusterIdentity", "kubeletIdentity"];
  for (const propertyName of identityPropertyNames) {
    if (res[propertyName]) {
      res[propertyName] = managedIdentityResourceId;
    }
  }
  const identityListPropertyNames = ["workloadIdentities"];

  for (const propertyName of identityListPropertyNames) {
    const _it = res[propertyName]
    if (_it && (typeof _it === "object") && !Array.isArray(_it)) {
      for(const [key, val] of Object.entries(_it)) {
        _it[key] = fixIdentity({ identity: val})
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
      resp[`${resourceTypeName}Id`] = makeDiscoveryArmId({
        resourceTypeName,
      });
    }
    if (object[`${resourceTypeName}Ids`]) {
      resp[`${resourceTypeName}Ids`] = [
        makeDiscoveryArmId({
          resourceTypeName,
        }),
      ];
    }
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

const fixIds = ({ swaggerObject, exampleObject, operationId }) => {
  let basePath = getPathForOperationId({
    swaggerObject,
    operationId,
  });
  if (!basePath) {
    console.warn(`Unable to find base path "${basePath}"`);
    return exampleObject;
  }
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
      exampleObject.responses[returnCode] = {
        ...rest,
        body: {
          id: id ? basePath : undefined,
          name: name && _name ? _name : name,
          ...bodyRest,
          identity: identity && fixIdentity({ identity }),

          properties: properties && fixPropertiesBag({ properties }),

          // Handle list responses
          value: !Array.isArray(body?.value)
            ? undefined
            : body.value.map(({ id, name, identity, properties, ..._val }) => ({
                id: id && name ? `${basePath}/${name}` : undefined,
                name,
                ..._val,
                identity: identity && fixIdentity({ identity }),
                ...fixDiscoverIds({ object: _val }),
                properties: properties && fixPropertiesBag({ properties }),
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

const runMain = () => {
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
    const swaggerObject = JSON.parse(readFileSync(swaggerFile));
    // console.log("swaggerFile: ",swaggerFile)

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
      if (contents.parameters) {
        contents.parameters = fixRegexIssues({ object: contents.parameters });

        if (contents.parameters.resource?.definitionContent) {
          contents.parameters.resource.definitionContent = definitionContent;
        }
        if (contents.parameters.resource?.properties) {
          // Fix issue with sending managedOnBehalfOfConfiguration in create/update payload
          contents.parameters.resource.properties.managedOnBehalfOfConfiguration =
            undefined;
          contents.parameters.resource.properties = fixPropertiesBag({
            properties: contents.parameters.resource.properties,
          });
        }
        if (contents.parameters.properties?.properties) {
          // Fix issue with sending managedOnBehalfOfConfiguration in create/update payload
          contents.parameters.properties.properties.managedOnBehalfOfConfiguration =
            undefined;
          contents.parameters.properties.properties = fixPropertiesBag({
            properties: contents.parameters.properties.properties,
          });
        }
      }
      // else {
      //   console.log(`---- ${filePath} no parameters?`)
      // }
      try {
        fixIds({
          swaggerObject,
          exampleObject: contents,
          operationId: contents.operationId,
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

runMain();
