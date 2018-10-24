#!/usr/bin/env pwsh

Publish-Module -NuGetApiKey $env:PSGALLERYAPIKEY -Path $PSScriptRoot/publish/PSGremlin 