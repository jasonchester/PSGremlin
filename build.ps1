#!/usr/bin/env pwsh

Push-Location $PSScriptRoot/src
dotnet publish -o ../publish
Pop-Location