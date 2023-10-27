param(
  [String]$targetFolder,
  [String]$sourceFolder,
  [String]$destinationFolder,
  [String]$hintsFile = "$PSScriptRoot\hints.txt",
  [String]$newHintsFile,
  [ValidateSet("strict", "mixMissing", "mixNew", "mixAll")]
  [String]$matchMode = "strict"
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

if (!(Test-Path $destinationFolder -PathType Container)) {
  New-Item -ItemType Directory -Force -Path $destinationFolder -ErrorAction Stop > $null
}

$hintsFile = Resolve-Path $hintsFile -ErrorAction Stop

if ([string]::IsNullOrWhiteSpace($newHintsFile)) {
  $newHintsFile = (Get-Location).Path | Join-Path -ChildPath "newHints.txt"
}

# Write-Host $targetFolder
# Write-Host $sourceFolder
# Write-Host $destinationFolder
# Write-Host $hintsFile
# Write-Host $newHintsFile

Push-Location $PSScriptRoot
python update.py $targetFolder $sourceFolder $destinationFolder $hintsFile $newHintsFile $matchMode
Pop-Location