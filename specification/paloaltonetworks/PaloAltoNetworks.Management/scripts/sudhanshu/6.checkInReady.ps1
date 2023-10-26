param(
  [String]$examplesFolder,
  [String]$savedFolder
)

if ([string]::IsNullOrWhiteSpace($savedFolder)) {
  Push-Location $PSScriptRoot
  Push-Location ../../PaloAltoNetworks.Cloudngfw
  $items = @(Get-ChildItem -Include examples -Directory -Recurse | ForEach-Object { $_.FullName } | Sort-Object)
  $targetFolder = $items[-1]
  Pop-Location
  Pop-Location
  $targetFolder = Resolve-Path $targetFolder -ErrorAction Stop
  $savedFolder = (Get-Item $targetFolder).Parent.FullName | Join-Path -ChildPath "\saved"
}
else {
  $savedFolderName = Resolve-Path $savedFolder -ErrorAction SilentlyContinue
  if ([string]::IsNullOrWhiteSpace($savedFolderName)) {
    $savedFolder = (Get-Location).Path | Join-Path -ChildPath $savedFolder
  }
  else {
    $savedFolder = $savedFolderName
  }
}

$savedFolder = Resolve-Path $savedFolder -ErrorAction SilentlyContinue

if ([string]::IsNullOrWhiteSpace($examplesFolder)) {
  Push-Location $PSScriptRoot
  Push-Location ../../PaloAltoNetworks.Cloudngfw
  $items = @(Get-ChildItem -Include examples -Directory -Recurse | ForEach-Object { $_.FullName } | Sort-Object)
  $targetFolder = $items[-1]
  Pop-Location
  Pop-Location
  $targetFolder = Resolve-Path $targetFolder -ErrorAction Stop
  $examplesFolder = (Get-Item $targetFolder).Parent.FullName | Join-Path -ChildPath "\examples"
}
else {
  $examplesFolderName = Resolve-Path $examplesFolder -ErrorAction SilentlyContinue
  if ([string]::IsNullOrWhiteSpace($examplesFolderName)) {
    $examplesFolder = (Get-Location).Path | Join-Path -ChildPath $examplesFolder
  }
  else {
    $examplesFolder = $examplesFolderName
  }
}

$examplesFolder = Resolve-Path $examplesFolder -ErrorAction SilentlyContinue

# Write-Host $examplesFolder
# Write-Host $savedFolder
if (-not [string]::IsNullOrWhiteSpace($examplesFolder)) {
  Remove-Item -path $examplesFolder -recurse -ErrorAction SilentlyContinue
}
if (-not [string]::IsNullOrWhiteSpace($savedFolder)) {
  Push-Location $PSScriptRoot
  Push-Location ../../
  Remove-Item -path 'examples' -recurse -ErrorAction SilentlyContinue
  Copy-Item -Path $savedFolder -Destination 'examples' -recurse -ErrorAction SilentlyContinue
  Pop-Location
  Pop-Location
  Rename-Item -Path $savedFolder -NewName "examples" -ErrorAction SilentlyContinue
}
  
Push-Location $PSScriptRoot
Push-Location ../../../../../
npm run prettier -- --write "./specification/paloaltonetworks/**/*.json"
Pop-Location
Pop-Location