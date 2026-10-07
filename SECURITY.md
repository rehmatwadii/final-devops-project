# Security and historical exposure

The original tracked tree contained `terraform.tfstate`, `terraform/terraform.tfstate` and `terraform/terraform.tfstate.backup`. The root state was empty. The other two contained Azure resource metadata for a VM, NIC, public IP, resource group, subnet and virtual network. Metadata includes resource/subscription identifiers, network addresses, administrator username and an SSH public key. `terraform/main.tf` also embedded a subscription identifier and a personal Windows path; inventory included a fixed public IP. These values have been removed from the current source tree without printing their contents.

State field names included `admin_password` and `secret`; both credential fields were empty in the audited HEAD state files. No private-key markers were detected in reachable Git blobs. See [the targeted audit](docs/SECURITY-AUDIT.md). An SSH public key is not a private credential, but its association and infrastructure metadata should not be published unintentionally.

Deleting files from the current tree does not remove previous commits. If populated secrets are found, revoke/rotate them first. Review exposed infrastructure and SSH authorized keys. To remove historical files, use a reviewed `git filter-repo` operation in an isolated backup clone, coordinate affected branches/tags and collaborators, and force-push only with explicit owner authorization. This modernization did not rewrite history or force-push.

Use GitHub private vulnerability reporting if enabled; otherwise arrange a private reporting channel through the maintainer's GitHub profile. Do not post state or credentials in public issues. No response-time guarantee is offered.
