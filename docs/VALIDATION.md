# Validation — 8 October 2026

| Check | Result |
|---|---|
| Terraform 1.12.2 fmt -check | Pass |
| Terraform init -backend=false -upgrade | Pass, AzureRM 4.81.0 selected and locked |
| Terraform validate | Pass |
| Ansible syntax, installed WSL Ansible core 2.16.3 | Pass; no target inventory supplied for syntax-only check |
| YAML lint 1.37.1 | Pass |
| Jenkinsfile Groovy 4 parser | Pass; not a Jenkins declarative pipeline runtime validation |
| Shell scripts sh -n | Pass |
| Output references and current source hygiene | Pass through scripts/check_project.py |
| Ignore rules for state, backups, provider directory, keys, environment and local backend | Pass |
| Reachable-history targeted security scan | No private-key markers; HEAD state credential fields empty; metadata exposure documented |
| Actual local page screenshots at 1440×1000 and 390×844 | Pass, no horizontal overflow |
| Git diff whitespace | Pass |
| Azure plan/apply, remote backend access, deployed SSH/HTTP | Not run: no configured Azure identity/backend; no billable resources created |
| Jenkins pipeline execution | Not run: no configured Jenkins runtime/credentials |
| Ansible target deployment/idempotence | Not run: no provisioned target |
| Exact pinned Ansible core 2.19.3 environment | Not locally executed: WSL venv bootstrap unavailable; CI installs pinned requirements |
| GitHub Actions run | Not executed remotely; workflow added |

Local screenshot evidence proves presentation only. The independent finish reviewer judged the two supplied page renders **ship**. Host-key trust on first use and plain HTTP remain clearly documented demo limitations. Source validation is not proof of a successful cloud deployment.
