@{
    # If authoring a script module, the RootModule is the name of your .psm1 file
    RootModule = 'PSGremlin.psm1'

    Author = 'Jason Chester'

    # CompanyName = 'Contoso Inc.'

    ModuleVersion = '0.5.1'

    # Use the New-Guid command to generate a GUID, and copy/paste into the next line
    GUID = 'c2f815db-7826-46a0-995d-f53813df9a5f'

    Copyright = '2018 Jason Chester'

    Description = 'Execute gremlin commands with the Gremlin.Net Driver. Works with Cosmos DB and AWS Neptune.'

    NestedModules = @('PSGremlin.dll')

    # Minimum PowerShell version supported by this module (optional, recommended)
    PowerShellVersion = '5.1'

    # Which PowerShell Editions does this module work with? (Core, Desktop)
    CompatiblePSEditions = @('Desktop', 'Core')

    # Which PowerShell functions are exported from your module? (eg. Get-CoolObject)
    FunctionsToExport = @('')

    # Which PowerShell aliases are exported from your module? (eg. gco)
    AliasesToExport = @('')

    # Which PowerShell variables are exported from your module? (eg. Fruits, Vegetables)
    VariablesToExport = @('')

    # PowerShell Gallery: Define your module's metadata
    PrivateData = @{
        PSData = @{
            # What keywords represent your PowerShell module? (eg. cloud, tools, framework, vendor)
            Tags = @('Gremlin', 'Graph', 'tinkerpop', 'CosmosDB', 'Neptune')

            # What software license is your code being released under? (see https://opensource.org/licenses)
            LicenseUri = 'https://github.com/jasonchester/PSGremlin/blob/master/LICENSE'

            # What is the URL to your project's website?
            ProjectUri = 'https://github.com/jasonchester/PSGremlin'

            # What is the URI to a custom icon file for your project? (optional)
            IconUri = 'https://raw.githubusercontent.com/jasonchester/PSGremlin/master/docs/psgremlin-logo.png'

            # What new features, bug fixes, or deprecated features, are part of this release?
            ReleaseNotes = @'
            # 2018-10-22 - Initial Release v 0.5
'@
        }
    }

    # If your module supports updateable help, what is the URI to the help archive? (optional)
    # HelpInfoURI = ''
}