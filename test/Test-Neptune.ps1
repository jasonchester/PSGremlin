
[CmdletBinding()]
param ()

# Import-Module $(Join-Path $PSScriptRoot "../Publish/Gremlin.Net.dll")
Import-Module $(Join-Path $PSScriptRoot "../Publish/PSGremlin.dll")

Get-Command -Module PSGremlin

$queries = @(
    "g.V().has('tenantId','acehardware')", "g.E().has('tenantId','acehardware')"
)

$queries | Invoke-Gremlin -Hostname "localhost" -Port 8182 -EnableSsl $false | ConvertTo-Json -Depth 5
