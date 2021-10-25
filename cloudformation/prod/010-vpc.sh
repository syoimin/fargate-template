#!/bin/sh
aws cloudformation deploy \
    --template-file ../yaml/vpc.yml \
    --stack-name PRD-STACK-VPC \
    --parameter-overrides `cat parameters.txt` \
    --region ap-northeast-1 \
    --profile default
    