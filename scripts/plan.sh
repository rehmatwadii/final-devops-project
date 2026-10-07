#!/bin/sh
set -eu
set +x
export TF_VAR_ssh_public_key="$(cat "$PUBLIC_KEY")"
terraform -chdir=terraform plan -out=deploy.tfplan
