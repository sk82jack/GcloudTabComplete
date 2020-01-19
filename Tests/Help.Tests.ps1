if (-not $env:BHPSModuleManifest) {
    Set-BuildEnvironment
}
Import-Module -Name $env:BHPSModuleManifest -Force
Describe "Help tests for $env:BHProjectName" -Tags Build {
    $functions = Get-Command -Module $env:BHProjectName -CommandType Function
    foreach ($Function in $Functions) {
        $help = Get-Help $Function.name
        Context $help.name {
            it "Has a HelpUri" {
                $Function.HelpUri | Should Not BeNullOrEmpty
            }
            It "Has related Links" {
                $help.relatedLinks.navigationLink.uri.count | Should BeGreaterThan 0
            }
            it "Has a description" {
                $help.description | Should Not BeNullOrEmpty
            }
            it "Has an example" {
                $help.examples | Should Not BeNullOrEmpty
            }
            foreach ($parameter in $help.parameters.parameter) {
                if ($parameter -notmatch 'whatif|confirm') {
                    it "Has a Parameter description for '$($parameter.name)'" {
                        $parameter.Description.text | Should Not BeNullOrEmpty
                    }
                }
            }
        }
    }
}
