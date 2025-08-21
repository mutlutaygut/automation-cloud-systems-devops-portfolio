# Automation Portfolio - Systems / Cloud / DevOps
![ps-ci](https://github.com/mutlutaygut/automation-cloud-systems-devops-portfolio/actions/workflows/powershell-ci.yml/badge.svg)
This repository demonstrates a **practical baseline** for automation-focused engineering:
- **Systems:** Windows endpoint hygiene & repeatable maintenance
- **Cloud-ready:** Structure intended to extend with Intune, Azure automation and Terraform (IaC)
- **DevOps:** CI/CD pipeline to keep scripts testable and reliable

> Goal: Show hands-on understanding of **PowerShell automation** reinforced by a **CI pipeline**.  
> Outcome: A foundation you can expand with device policies (Intune), cloud tagging/ops (Azure), and IaC (Terraform).

---

## Current contents

1) **PowerShell automation**
   - `scripts/Clean-TempFiles.ps1`  
     Safe cleanup for temp directories with `-WhatIf` support.

2) **CI/CD (GitHub Actions)**
   - `/.github/workflows/powershell-ci.yml`  
     Runs on every push/PR. Installs **PSScriptAnalyzer**, runs **static analysis**, then executes the script with `-WhatIf`.

3) **Basic test (Pester)**
   - `tests/Clean-TempFiles.Tests.ps1`  
     Ensures the cleanup script runs without throwing when using `-WhatIf`.

---

## Why this matters (common scenario)

- **Operational hygiene**: Regular temp cleanup reduces incidents related to disk pressure and improves stability.
- **Repeatability**: A pipeline ensures the script is always linted/tested before usage or promotion.
- **Extensibility**: This baseline is designed to be extended:
  - `/intune` → endpoint & policy configs (e.g., update rings, OneDrive KFM)
  - `/azure` → automation scripts (tagging, policy) and runbooks
  - `/cloud` → Terraform templates for cloud resources
  - `/ci-cd` → additional pipelines, packaging and release workflows

---

## Local quick start

```powershell
# Safe dry-run
pwsh ./scripts/Clean-TempFiles.ps1 -WhatIf

# Run Pester tests (if needed locally)
# Install-Module Pester -Scope CurrentUser -Force
pwsh ./tests/Clean-TempFiles.Tests.ps1

---

## Roadmap (next drops)

- Add user provisioning and device configuration scripts (PowerShell)
- Add Intune policy examples (OMA-URI/Update rings)
- Add Azure tagging automation and a minimal Terraform template
- Expand CI to run Pester by default and add a Python mini-automation with pytest


