param(
  [String]$targetFolder,
  [String]$sourceFolder,
  [String]$destinationFolder
)

if ([string]::IsNullOrWhiteSpace($targetFolder)) {
  Push-Location $PSScriptRoot
  Push-Location ../../PaloAltoNetworks.Cloudngfw
  $items = @(Get-ChildItem -Include examples -Directory -Recurse | ForEach-Object { $_.FullName } | Sort-Object)
  $targetFolder = $items[-1]
  Pop-Location
  Pop-Location
}
$targetFolder = Resolve-Path $targetFolder -ErrorAction Stop

if ([string]::IsNullOrWhiteSpace($sourceFolder)) {
  Push-Location $PSScriptRoot
  Push-Location ../../../resource-manager/PaloAltoNetworks.Cloudngfw
  $items = @(Get-ChildItem -Include examples -Directory -Recurse | ForEach-Object { $_.FullName } | Sort-Object)
  $sourceFolder = $items[-1]
  Pop-Location
  Pop-Location
}
$sourceFolder = Resolve-Path $sourceFolder -ErrorAction Stop

if ([string]::IsNullOrWhiteSpace($destinationFolder)) {
  $destinationFolder = (Get-Item $targetFolder).Parent.FullName | Join-Path -ChildPath "\saved"
}
else {
  $destinationFolderName = Resolve-Path $destinationFolder -ErrorAction SilentlyContinue
  if ([string]::IsNullOrWhiteSpace($destinationFolderName)) {
    $destinationFolder = (Get-Location).Path | Join-Path -ChildPath $destinationFolder
  }
  else {
    $destinationFolder = $destinationFolderName
  }
}

$examplesBackup = ((Get-Item $targetFolder).Parent.FullName | Join-Path -ChildPath "\examplesBackup")

# Write-Host $targetFolder
# Write-Host $sourceFolder
# Write-Host $destinationFolder
# Write-Host $examplesBackup


Remove-Item -path $examplesBackup -recurse -ErrorAction SilentlyContinue
Rename-Item -Path $targetFolder -NewName "examplesBackup"
Move-Item -Path $destinationFolder -Destination $targetFolder -ErrorAction Stop
npm run oav -- validate-example ((Get-Item $targetFolder).Parent.FullName | Join-Path -ChildPath "\openapi.json")
Copy-Item ((Get-Item $sourceFolder).Parent.FullName | Join-Path -ChildPath "\PaloAltoNetworks.Cloudngfw.json") -Destination (Get-Item $targetFolder).Parent.FullName -Force -ErrorAction Stop
npm run oav -- validate-example ((Get-Item $targetFolder).Parent.FullName | Join-Path -ChildPath "\PaloAltoNetworks.Cloudngfw.json")
Move-Item -Path $targetFolder -Destination $destinationFolder -ErrorAction Stop
Rename-Item -Path $examplesBackup -NewName "examples" -ErrorAction Stop