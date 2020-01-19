function Add-GcloudToProfile {
    <#
    .SYNOPSIS
    Add the import module command to your profile

    .DESCRIPTION
    Add the import module command to your profile

    It will be added to your current active profile if one is found. If not it will be added to
    the CurrentUserCurrentHost profile

    If your current profile is one of the AllUsers profiles but you are not running an elevated
    console then an error will be thrown

    .EXAMPLE
    Add-GcloudToProfile

    .LINK
    https://gcloudtabcomplete.readthedocs.io/en/master/functions/Add-GcloudToProfile

    .LINK
    https://github.com/sk82jack/GcloudTabComplete/blob/master/GcloudTabComplete/Public/Add-GcloudToProfile.ps1
    #>
    [CmdletBinding(SupportsShouldProcess)]
    param()

    $ProfileLocations = $profile.psobject.properties.name -ne 'Length'

    foreach ($Location in $ProfileLocations) {
        if (Test-Path $profile.$Location) {
            if ($Location -match 'AllUsers') {
                $CurrentPrincipal = [Security.Principal.WindowsPrincipal]::new([Security.Principal.WindowsIdentity]::GetCurrent())
                $IsAdmin = $currentPrincipal.IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)
                if (-not $IsAdmin) {
                    throw 'You must run this function in an elevated console to write to your current profile'
                }
            }
            $CurrentProfile = $profile.$Location
            break
        }
    }

    if (-not $CurrentProfile) {
        $CurrentProfile = $profile.CurrentUserCurrentHost
    }

    $ImportCommand = 'Import-Module -Name GcloudTabComplete'

    $CurrentProfileContent = Get-Content -Path $CurrentProfile
    if (-not [string]::IsNullOrEmpty($CurrentProfileContent[-1])) {
        $ImportCommand = [Environment]::NewLine + $ImportCommand
    }

    if ($PSCmdlet.ShouldProcess($CurrentProfile, "Add '$ImportCommand' to profile")) {
        Add-Content -LiteralPath $CurrentProfile -Value $ImportCommand
    }
}
