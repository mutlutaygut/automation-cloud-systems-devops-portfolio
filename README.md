# Automation Portfolio - Systems / Cloud / DevOps
![ps-ci](https://github.com/mutlutaygut/automation-cloud-systems-devops-portfolio/actions/workflows/powershell-ci.yml/badge.svg)
This repository has prepared to demonstrate a **practical baseline** for automation purposes in the cloud environment.

**Contents**
- `.github/workflows` — GitHub Actions pipeline (PSScriptAnalyzer, Pester, Intune/ARM validation, Terraform `validate`).
- `scripts` — PowerShell automation scripts (e.g., safe temp cleanup, validation scripts).
- `terraform` — Sample Infrastructure as Code with Terraform, checked with `fmt/init/validate`.
- `tests` — Pester tests for smoke-level validation.
- (Root) `oma-uris.csv`, `sample-policy.json`, `azure-storageAccount.*` — example Intune and ARM templates.  
 
## Quick Start

```powershell
# Safe dry-run
pwsh ./scripts/Clean-TempFiles.ps1 -WhatIf

# Run Pester tests (if needed locally)
# Install-Module Pester -Scope CurrentUser -Force
pwsh ./tests/Clean-TempFiles.Tests.ps1
`````
