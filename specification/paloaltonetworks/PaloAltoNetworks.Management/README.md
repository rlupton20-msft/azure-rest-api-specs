# CADL for RPaaS

## Prerequisites

1. Need Node version >= 16

## Making the CADL Changes
Here are some resources to get started on CADL:

https://github.com/Azure/cadl-azure/blob/main/docs/cadl-getting-started.md

https://github.com/Azure/cadl-azure/blob/main/packages/cadl-providerhub-templates/README.md

http://aka.ms/cadl/rpaas-start

playground for Azure: https://aka.ms/trycadlazure

## Compile and PR Ready

We have scripts in place that allow us to easily run the commands to compile, generate examples and get check in ready once the cadl changes are made.

We can execute them in order:
```powershell
.\scripts\sudhanshu\1.initialize.ps1
.\scripts\sudhanshu\2.compile.ps1  
.\scripts\sudhanshu\3.generate.ps1 
.\scripts\sudhanshu\4.merge.ps1
.\scripts\sudhanshu\5.validate.ps1
.\scripts\sudhanshu\6.checkInReady.ps1
```

To understand what these scripts do, watch this learning session by Sudhanshu: https://microsoftapc-my.sharepoint.com/:v:/g/personal/sbaruntar_microsoft_com/Ea0Lqgs0u0lIo6E7eJhEmVUBitRhEyNEFF0XjsOXl7MK-Q

Once all the scripts have run successfully, we need to update the specification file in both PaloAltoNetworks.Management directory and resource-manager directory. We can do that by performing these steps:

#### 1. Update PaloAltoNetworks.Cloudngfw.json under PaloAltoNetworks.Management directory

When we compile the CADL changes using the compile script mentioned above, it updates the `openapi.json` file.  This means our updated spec is as per `openapi.json`, and the previous spec is as per file `PaloAltoNetworks.Cloudngfw.json`. We need to compare these two files, and apply the updates in `openapi.json` to `PaloAltoNetworks.Cloudngfw.json`.

#### 2. Update PaloAltoNetworks.Cloudngfw.json and examples under resource-manager directory
We need to copy-paste the `examples` folder and the `PaloAltoNetworks.Cloudngfw.json` file under `resource-manager` directory, under the relevant api-version folder.

#### 3. Raise a PR for RPSaaSDev branch.
Link to [sample PR](https://github.com/Azure/azure-rest-api-specs-pr/pull/10817/files).
#### 4. Raise a PR for RPSaaSMaster branch.
This will only contain the changes under resource-manager. We can checkout a new branch from RPSaaSMaster, and check out only the changes under resource-manager directory that were made  from the RPSaaSDev based branch. Here are git commands to do the same:

```powershell
cd .\resource-manager\

git checkout origin/RPSaaSDev -- **/*.json
```

Here is a link to [sample PR](https://github.com/Azure/azure-rest-api-specs-pr/pull/10951/files).

## More Details

[OneNote](https://microsoftapc.sharepoint.com/teams/Liftr-PAN/Shared%20Documents/Engineering/Palo%20Alto%20Networks%20-%20Liftr/CADL.one#Compile&section-id={2C19B114-E059-43AD-84F9-E6A06A7C5264}&page-id={1F29F333-5870-4D3E-A05C-4D48EB6A347D}&end)