Push-Location $PSScriptRoot

# Compile and update swagger in management folder
Push-Location ../../
Remove-Item -path ./PaloAltoNetworks.Cloudngfw -recurse -ErrorAction SilentlyContinue
Remove-Item -path ./examples -recurse -ErrorAction SilentlyContinue
npm run format
npm run compile -- . --option arm-types-path="../../common-types/resource-management/v3/types.json" --output-path="./"
npm run compile -- . --option arm-types-path="../../../../../common-types/resource-management/v3/types.json" --option azure-resource-provider-folder="../"
Pop-Location

# update openapi.json in management folder
Push-Location ../../PaloAltoNetworks.Cloudngfw
Get-ChildItem -Include openapi.json -File -Recurse | ForEach-Object { $_.FullName } |
ForEach-Object {
  $file = $_
  (Get-Content $file).Replace('"description": "ARM','"description": "Azure') | Set-Content $file
}
Pop-Location

# update openapi.json in management folder
Push-Location ../../
Get-ChildItem -Include openapi.json -File -Recurse | ForEach-Object { $_.FullName } |
ForEach-Object {
  $file = $_
  (Get-Content $file).Replace('"description": "ARM','"description": "Azure') | Set-Content $file
}
Pop-Location

Pop-Location