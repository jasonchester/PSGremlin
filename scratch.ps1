[CmdletBinding()]
param(
    [Parameter(Mandatory=$true)]
    [string] $Hostname,
    [Parameter(Mandatory=$true)]    
    [pscredential] $Credential
    
)

Import-Module $PSScriptRoot/Publish/PSGremlin.dll

$server = @{
    Hostname = $Hostname
    Credential = $Credential
}


while (($command = Read-Host -Prompt '>') -NE ':Q')
{
    $command | Invoke-Gremlin @server
}