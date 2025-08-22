param([switch]$WhatIf)

# Purpose: Clean up temporary files to free disk space.
# Safe demo: supports -WhatIf to avoid accidental deletion.

$targets = @(
    "$env:TEMP\*",
    "$env:SystemRoot\Temp\*"
)

foreach ($t in $targets) {
    Write-Host "Cleaning: $t"
    if ($WhatIf) {
        Remove-Item $t -Recurse -Force -ErrorAction SilentlyContinue -WhatIf
    } else {
        Remove-Item $t -Recurse -Force -ErrorAction SilentlyContinue
    }
}
