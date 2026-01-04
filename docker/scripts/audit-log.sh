#!/bin/bash
LOG=/workspace/audit.log
echo "$(date -u) | ACTOR=$GITHUB_ACTOR | REPO=$GITHUB_REPOSITORY | ENV=$APIGEE_ENV | SHA=$GITHUB_SHA" | tee -a $LOG
