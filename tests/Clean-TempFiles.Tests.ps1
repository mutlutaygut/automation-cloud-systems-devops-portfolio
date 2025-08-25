# Basic behavior test for the cleanup script.
# Ensures dry-run works without throwing.

Describe 'Clean-TempFiles.ps1' {
    It 'Runs with -WhatIf without throwing' {
        { & "$PSScriptRoot/../scripts/Clean-TempFiles.ps1" -WhatIf } | Should -Not -Throw
    }
}
