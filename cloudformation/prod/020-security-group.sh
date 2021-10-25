#!/bin/sh
aws cloudformation deploy \
    --template-file ../yaml/security-group.yml \
    --stack-name PRD-STACK-SECURITYGROUP \
    --parameter-overrides `cat parameters.txt` \
    --region ap-northeast-1 \
    --profile default
    