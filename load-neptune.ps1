[CmdletBinding()]
param()

$gps = @{
    Hostname = 'localhost'
    Port = 8182
    EnableSsl = $false
}

Import-Module $PSScriptRoot/Publish/PSGremlin.dll

# "g.V().drop()" | Invoke-Gremlin @gps

# $vqs = Get-Content -Path $HOME/_dev/LDM/scripts/acehardware/prod01/acehardware-V.gremlin

# $vqs | Split-Pipeline -Variable 'gps' -Module $PSScriptRoot/Publish/PSGremlin.dll -Script { process { $_ | Invoke-Gremlin @gps }}

#VERBOSE: Split-Pipeline:
# Item count = 78313
# Part count = 8
# Pipe count = 8
# Wait count = 6
# Max queue  = 78313
# Total time = 00:15:20.8266970
# Items /sec = 85.0464047742526


$eqs = Get-Content -Path $HOME/_dev/LDM/scripts/acehardware/prod01/acehardware-E.gremlin

$eqs | Split-Pipeline -Variable 'gps' -Module $PSScriptRoot/Publish/PSGremlin.dll -Script { process { $_ | Invoke-Gremlin @gps }}