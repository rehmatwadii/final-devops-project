#!/bin/sh
set -eu
set +x
rm -f known_hosts
for attempt in $(seq 1 30); do
    ssh-keyscan -T 5 -H "$VM_IP" > known_hosts 2>/dev/null || true
    if test -s known_hosts && ssh -i "$SSH_KEY" -o BatchMode=yes -o ConnectTimeout=5 -o StrictHostKeyChecking=yes -o UserKnownHostsFile="$WORKSPACE/known_hosts" "$VM_USER@$VM_IP" true; then
        break
    fi
    sleep 10
done
ssh -i "$SSH_KEY" -o BatchMode=yes -o ConnectTimeout=5 -o StrictHostKeyChecking=yes -o UserKnownHostsFile="$WORKSPACE/known_hosts" "$VM_USER@$VM_IP" true
ansible-playbook -i "$VM_IP," -u "$VM_USER" --private-key "$SSH_KEY" --ssh-common-args="-o StrictHostKeyChecking=yes -o UserKnownHostsFile=$WORKSPACE/known_hosts" ansible/install_web.yml
