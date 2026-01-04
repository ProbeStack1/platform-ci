#!/bin/bash
set -e

/scripts/audit-log.sh
/scripts/org-enforcement.sh

run() {
  name=$1
  flag=$2
  cmd=$3

  if [[ "${!flag}" == "true" ]]; then
    echo "⏭ Skipping $name"
  else
    echo "▶ $name"
    eval "$cmd"
  fi
}

run "ApigeeLint" SKIP_APIGEELINT "/scripts/apigee-lint.sh"
run "JSON Lint" SKIP_JSONLINT "/scripts/json-lint.sh"
run "Fortify" SKIP_FORTIFY "/scripts/fortify.sh || true"
run "Sonar" SKIP_SONAR "/scripts/sonar.sh"

if [[ "$SKIP_DEPLOY" != "true" ]]; then
  /scripts/policy.sh
  /scripts/apigee-deploy.sh
fi

