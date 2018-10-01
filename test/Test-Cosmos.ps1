
[CmdletBinding()]
param (
    [PSCredential] $creds = (Get-Credential "/dbs/dev01/colls/ldm")
)


Import-Module $(Join-Path $PSScriptRoot "../Publish/PSGremlin.dll")
Get-Command -Module PSGremlin

$queries = @(
    "g.V().has('tenantId','ditchwitch')", "g.E().has('tenantId','ditchwitch')"
)

$queries | Invoke-Gremlin -Hostname "dev01-graph01.gremlin.cosmosdb.azure.com" -Credential $creds -EnableSsl $true | ConvertTo-Json -Depth 5
