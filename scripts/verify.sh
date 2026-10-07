#!/bin/sh
set -eu
test "$(curl --fail --silent --show-error --retry 5 --retry-connrefused --connect-timeout 5 --max-time 15 "http://$VM_IP/health")" = ok
curl --fail --silent --show-error --connect-timeout 5 --max-time 15 "http://$VM_IP/" > /tmp/devops-page-$$.html
trap 'rm -f /tmp/devops-page-$$.html' EXIT
grep -q 'Azure DevOps Automated Deployment' /tmp/devops-page-$$.html
