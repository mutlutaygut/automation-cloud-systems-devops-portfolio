# Simple offline checks for Azure ARM templates (no login required)
$ErrorActionPreference = 'Stop'
$root = (Join-Path $PSScriptRoot '..' | Resolve-Path).Path
$azureDir = Join-Path $root 'azure'
if (-not (Test-Path $azureDir)) { Write-Host "No 'azure' directory; skipping."; exit 0 }

$fail = 0

# validate template files
Get-ChildItem $azureDir -Recurse -Filter *.template.json -File | ForEach-Object {
  try {
    $j = Get-Content $_.FullName -Raw | ConvertFrom-Json -ErrorAction Stop
    if (-not $j.'$schema' -or ($j.'$schema' -notmatch 'deploymentTemplate')) {
      Write-Error "Not a template schema: $($_.Name)"; $fail++
    }
    if (-not $j.contentVersion) { Write-Error "Missing contentVersion: $($_.Name)"; $fail++ }
    if (-not $j.resources -or $j.resources.Count -eq 0) { Write-Error "No resources: $($_.Name)"; $fail++ }
    foreach ($r in $j.resources) {
      foreach ($req in 'type','apiVersion','name') {
        if (-not $r.$req) { Write-Error "Resource missing '$req' in $($_.Name)"; $fail++ }
      }
      if ($r.type -eq 'Microsoft.Storage/storageAccounts') {
        if (-not $r.sku.name) { Write-Error "Storage account missing sku.name in $($_.Name)"; $fail++ }
      }
    }
  } catch {
    Write-Error "Invalid JSON in $($_.Name): $($_.Exception.Message)"; $fail++
  }
}

# validate parameters files (basic structure)
Get-ChildItem $azureDir -Recurse -Filter *.parameters.json -File | ForEach-Object {
  try {
    $p = Get-Content $_.FullName -Raw | ConvertFrom-Json -ErrorAction Stop
    if (-not $p.parameters) { Write-Error "Parameters file missing 'parameters': $($_.Name)"; $fail++ }
  } catch { Write-Error "Invalid JSON in $($_.Name): $($_.Exception.Message)"; $fail++ }
}

if ($fail -gt 0) { exit 1 } else { Write-Host "Azure ARM templates validated."; }
