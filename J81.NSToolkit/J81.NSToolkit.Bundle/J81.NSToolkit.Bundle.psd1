#
# Module manifest for module 'J81.NSToolkit.Bundle'
#

@{

    RootModule        = 'J81.NSToolkit.Bundle.psm1'
    ModuleVersion     = '2402.222.2'
    GUID              = '29fdcc5a-cc37-4cc0-88af-d03e3fd4e23c'
    Author            = 'John Billekens'
    CompanyName       = 'J81-Blog'
    Copyright         = '(c) 2026 John Billekens. All rights reserved.'
    Description       = 'Bundle module that installs all J81.NSToolkit modules.'
    PowerShellVersion = '5.0'

    RequiredModules   = @(
        @{ ModuleName = 'J81.NSToolkit'; ModuleVersion = '2402.222.2' }
        @{ ModuleName = 'J81.NSToolkit.Config'; ModuleVersion = '2401.3122.0' }
        @{ ModuleName = 'J81.NSToolkit.Stats'; ModuleVersion = '2401.3122.0' }
    )

    FunctionsToExport = @()
    CmdletsToExport   = @()
    VariablesToExport = @()
    AliasesToExport   = @()

    PrivateData       = @{
        RepositorySourceLocation = 'https://github.com/j81blog/J81.NSToolkit/'
        PSData                   = @{
            Tags         = @('J81-Blog', 'NetScaler', 'Citrix', 'ADC', 'Nitro', 'Bundle')
            LicenseUri   = 'https://github.com/j81blog/J81.NSToolkit/blob/master/LICENSE'
            ProjectUri   = 'https://github.com/j81blog/J81.NSToolkit/'
            ReleaseNotes = 'https://github.com/j81blog/J81.NSToolkit/blob/master/CHANGELOG.md'
        }
    }
}
