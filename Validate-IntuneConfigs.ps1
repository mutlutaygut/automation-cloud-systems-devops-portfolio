# Validates basic structure of intune configs (JSON + CSV)
$ErrorActionPreference = 'Stop'

$root = (Join-Path $PSScriptRoot '..' | Resolve-Path).Path
$intuneDir = Join-Path $root 'intune'
if (-not (Test-Path $intuneDir)) { Write-Host "No 'intune' directory; skipping."; exit 0 }

$fail = 0

# JSON validity
Get-ChildItem $intuneDir -Recurse -Filter *.json -File | ForEach-Object {
  try { Get-Content $_.FullName -Raw | ConvertFrom-Json | Out-Null }
  catch {
    Write-Error "Invalid JSON: $($_.Name) — $($_.Exception.Message)"
    $fail++
  }
}

# CSV headers + non-empty check
$required = 'Name','OMA-URI','DataType','Value'
Get-ChildItem $intuneDir -Recurse -Filter *.csv -File | ForEach-Object {
  $csv = Import-Csv $_.FullName
  $headers = ($csv | Get-Member -MemberType NoteProperty | Select-Object -ExpandProperty Name)
  $missing = $required | Where-Object { $_ -notin $headers }
  if ($missing) {
    Write-Error "CSV missing headers in $($_.Name): $($missing -join ', ')"
    $fail++
  } else {
    foreach ($row in $csv) {
      foreach ($h in $required) {
        if ([string]::IsNullOrWhiteSpace($row.$h)) {
          Write-Error "CSV empty '$h' in $($_.Name)"
          $fail++; break
        }
      }
    }
  }
}

if ($fail -gt 0) { exit 1 } else { Write-Host "Intune configs validated."; }
