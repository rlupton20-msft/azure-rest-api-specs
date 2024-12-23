Push-Location $PSScriptRoot

# npm install in management folder
Push-Location ../../
npm install
Pop-Location

# npm install at root location
Push-Location ..\..\..\..\..
npm install
Pop-Location

Pop-Location