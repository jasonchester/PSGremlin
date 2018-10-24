#!/usr/bin/env pwsh

Push-Location $PSScriptRoot/src
dotnet publish -o ../publish/PSGremlin
Pop-Location