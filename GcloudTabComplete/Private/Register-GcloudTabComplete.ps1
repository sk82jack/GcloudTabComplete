function Register-GcloudTabComplete {
    [CmdletBinding()]
    param ()

    $Script:GcloudParamCache = @{}

    $GcloudSB = {
        param($WordToComplete, $CommandAst, $CursorPosition)

        if ($WordToComplete -match '^--') {
            $ParentArgs = '--'
        }
        else {
            $ParentArgs = ($CommandAst.Extent.Text -replace "gcloud(.exe)?|\b$WordToComplete\b").Trim()
        }

        if ($Script:GcloudParamCache[$ParentArgs]) {
            $AutoCompletOptions = $Script:GcloudParamCache[$ParentArgs]
        }
        else {
            if ($WordToComplete -match '^--') {
                $GcloudArgs = 'help'
            }
            else {
                $GcloudArgs = $ParentArgs.split()
            }

            if ($GcloudArgs) {
                $GcloudError = & gcloud $GcloudArgs 2>&1
            }
            else {
                $GcloudError = & gcloud 2>&1
            }

            if ($WordToComplete -match '^--') {
                $AutoCompletOptions = $GcloudError -match '^\s{5}--' -replace '^\s{5}(--[\w-]+).*', '$1'
            }
            else {
                if ($PSVersionTable.PSVersion -lt '6.0.0') {
                    $GcloudError = $GcloudError[1] -split '\r\n'
                }
                $AutoCompletOptions = $GcloudError -match '^\s{6}\b' -replace '^\s{6}\b([\w-]+).*', '$1' | Sort-Object
            }

            $Script:GcloudParamCache[$ParentArgs] = $AutoCompletOptions
        }

        $AutoCompletOptions | Where-Object {$_ -like "$WordToComplete*"}
    }

    Register-ArgumentCompleter -Native -CommandName 'gcloud' -ScriptBlock $GcloudSB
}
