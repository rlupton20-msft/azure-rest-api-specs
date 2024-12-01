'''
This file will fix Missing Resource ID issue
1. Dump the error into report.json
2. format the dump to be a json like below
      {
        "issue": [
          {
            ...
          },
          ...
        ]
      }
4. update the getId section as per needs
'''

import json

def populate(parameters, name, default="armId1"):
  return parameters[name] if name in parameters else default

def getId(path:str, parameters):
  nPath = path[len('examples/'):]
  # print(parameters)
  # print(path)
  rId = ""
  subscription = None if "subscriptionId" not in parameters else f'/subscriptions/{parameters["subscriptionId"]}'
  rId += subscription if subscription else ""
  rgName = None if "resourceGroupName" not in parameters else f'/resourcegroups/{parameters["resourceGroupName"]}'
  rId += rgName if rgName else ""
  rType = "/providers/PaloAltoNetworks.Cloudngfw/firewalls" if "Firewall" in path else ("/providers/PaloAltoNetworks.Cloudngfw/localRulestacks" if "LocalRulestack" in path else "/providers/PaloAltoNetworks.Cloudngfw/globalRulestacks")
  rId += rType if rType else ""
  rName = populate(parameters, "firewallName","firewall") if "Firewall" in path else (populate(parameters, "localRulestackName", "lrs1") if "LocalRulestack" in path else populate(parameters, "globalRulestackName", "grs1"))
  rId += f'/{rName}' if rName else ""
  srType = "prefixlists" if "PrefixList" in path else ("certificates" if "Certificate" in path else ("fqdnlists" if "Fqdn" in path else ("localrules" if "LocalRules_" in path else ("prerules" if "PreRules" in path else ("postrules" if "PostRules" in path else None)))))
  rId += f'/{srType}' if srType else ""
  srName = populate(parameters, "name", "prefixlists1") if "PrefixList" in path else (populate(parameters, "name", "certificates1") if "Certificate" in path else (populate(parameters, "name", "fqdnlists1") if "Fqdn" in path else (populate(parameters, "priority", "1") if "LocalRules_" in path else (populate(parameters, "priority", "1") if "PreRules" in path else (populate(parameters, "priority", "1") if "PostRules" in path else None)))))
  rId += f'/{srName}' if srName else ""
  # print(subscription, rgName, rType, rName, srType, srName)
  # print(rId)
  return rId

with open("report.json") as reportFile:
  report = json.load(reportFile)
  for issue in report["issues"]:
    path = issue["exampleUrl"]
    missing = issue["exampleJsonPath"].split('.')
    # print(missing)
    if issue["code"] != "MISSING_RESOURCE_ID":
      print(f'Skipping {issue["code"]}, {issue["exampleUrl"]}')
      continue
    missing[0] = missing[0][1:]
    print(missing, path)
    value = None
    with open(path) as fixFile:
      value = json.load(fixFile)
      # print(path)
      parameters = value['parameters']
      node = value
      for i in missing:
        if i == 'value[0]':
          node = node['value'][0]
        else:
          node = node[i]
      node['id'] = getId(path, parameters)
    print(path, missing)
    print(value)
    with open(path, "w") as fixFile:
      json.dump(value, fixFile, sort_keys=True, indent=2)
      fixFile.write("\n")
