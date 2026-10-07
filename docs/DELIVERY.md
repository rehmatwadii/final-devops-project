# Delivery report

## Problems discovered / bugs repaired

Terraform embedded a subscription identifier and a personal Windows key path. State files and a machine-specific public key were tracked. Inventory embedded a fixed IP. The README claimed web deployment while the playbook installed Jenkins; Jenkins called a missing playbook, used an undefined `public_ip` output and referenced an absent private key. No inbound web/SSH security rules were defined for the Standard public IP.

## Features improved

Portable validated variables; provider version constraints and refreshed lockfile; Ubuntu 24.04 VM; explicit network rules; consistent public_ip_address/admin_username outputs; Azure Storage remote backend; saved-plan approval in Jenkins; bounded SSH readiness; Nginx installation and page deployment with Ansible; local and public health verification. A lightweight responsive demo page and credentials-free source CI are included.

## Security issues fixed

Removed current-tree state, hardcoded identifiers/paths/IP and the committed public key. Ignored state backups, providers, keys, local variables and environment files. SSH is CIDR-restricted, VM passwords are disabled and Jenkins binds credentials. State is remote and separate from application resources. Historical exposure details and non-destructive remediation guidance are in [SECURITY.md](../SECURITY.md) and [audit findings](SECURITY-AUDIT.md). No populated credentials/private-key markers were detected by the targeted audit. History remains unchanged.

## Checks and results

Terraform fmt/init/validate, Ansible syntax, YAML lint, Groovy parsing, shell syntax, output-reference consistency, ignore checks and local page rendering passed. See [validation limits](VALIDATION.md). Azure provisioning, backend access, Jenkins execution and deployed Ansible idempotence require your cloud/runtime setup and were not tested. No infrastructure was applied or destroyed.

## GitHub presentation

- Description: **Azure VM provisioning and Nginx deployment automated with Terraform, Ansible and a reviewable Jenkins pipeline.**
- Topics: `azure`, `terraform`, `ansible`, `jenkins`, `devops`, `infrastructure-as-code`, `cicd`, `linux`, `nginx`, `portfolio-project`.
- Social preview concept: clear “Azure DevOps Automated Deployment” title with the actual GitHub → Jenkins → Terraform → Azure → Ansible → Nginx flow; avoid claims of a completed cloud run.

## Run commands

Configure the separate state backend, Azure identity, allowed CIDR and SSH public key using the README. Then `terraform -chdir=terraform init -backend-config=backend.hcl`, `plan -out=deploy.tfplan`, review and `apply deploy.tfplan`. Export VM_IP/VM_USER from the documented outputs, set SSH_KEY/WORKSPACE/ANSIBLE_CONFIG, then run `sh scripts/deploy.sh` and `sh scripts/verify.sh`. The complete copyable command sequence is in the README. Cleanup is deliberate and uses a reviewed destroy plan.

## Optional improvements

Real Azure smoke test, independently verified SSH host keys, TLS/domain configuration and a chosen source-code reuse license. Import or migrate private historical state before touching existing resources; review replacement plans carefully.

## Suggested commit messages

- `fix: align Terraform outputs and Jenkins web deployment workflow`
- `fix(security): remove tracked state and machine-specific infrastructure settings`
- `feat: provision restricted Azure VM and deploy Nginx with Ansible`
- `ci: validate infrastructure configuration without cloud credentials`
- `docs: document remote state, deployment evidence and historical exposure`

## Files changed / final structure

See the exact source tree in README. Major changed groups: Terraform configuration/variables/outputs/backend examples/lockfile, Jenkinsfile, deployment scripts, Ansible web playbook/config, application page, CI and docs. Removed old Jenkins installation playbook, fixed inventory, public key and state files. Full current Git change listing follows below.

```text
 M .gitignore
 M Jenkinsfile
 M README.md
 D ansible/index.html
 D ansible/install_jenkins.yml
 D ansible/inventory.ini
 D terraform.tfstate
 M terraform/.terraform.lock.hcl
 D terraform/devops_key.pub
 M terraform/main.tf
 D terraform/terraform.tfstate
 D terraform/terraform.tfstate.backup
?? .gitattributes
?? .github/workflows/ci.yml
?? .yamllint
?? CONTRIBUTING.md
?? SECURITY.md
?? ansible/ansible.cfg
?? ansible/files/default.conf
?? ansible/install_web.yml
?? app/index.html
?? docs/DELIVERY.md
?? docs/SCREENSHOTS.md
?? docs/SECURITY-AUDIT.md
?? docs/VALIDATION.md
?? docs/screenshots/local-demo.png
?? docs/screenshots/local-mobile.png
?? requirements-dev.txt
?? scripts/check_project.py
?? scripts/deploy.sh
?? scripts/plan.sh
?? scripts/verify.sh
?? terraform/backend.hcl.example
?? terraform/outputs.tf
?? terraform/terraform.tfvars.example
?? terraform/variables.tf
?? terraform/versions.tf
```
