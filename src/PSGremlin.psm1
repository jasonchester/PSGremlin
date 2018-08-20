# For future use
# Load your target version of the assembly
$dep = [System.Reflection.Assembly]::LoadFrom("$PSScriptRoot\System.Reflection.TypeExtensions.dll")
$onAssemblyResolveEventHandler = [System.ResolveEventHandler] {
  param($sender, $e)
  # You can make this condition more or less version specific as suits your requirements
  if ($e.Name.StartsWith("System.Reflection.TypeExtensions")) {
    return $dep
  }
  foreach($assembly in [System.AppDomain]::CurrentDomain.GetAssemblies()) {
    if ($assembly.FullName -eq $e.Name) {
      return $assembly
    }
  }
  return $null
}
[System.AppDomain]::CurrentDomain.add_AssemblyResolve($onAssemblyResolveEventHandler)

# Rest of your script....

# # Detach the event handler (not detaching can lead to stack overflow issues when closing PS)
# [System.AppDomain]::CurrentDomain.remove_AssemblyResolve($onAssemblyResolveEventHandler)