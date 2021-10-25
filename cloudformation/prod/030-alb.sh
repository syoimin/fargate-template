#!/bin/sh
aws cloudformation deploy \
    --template-file ../yaml/alb.yml \
    --stack-name PRD-STACK-ALB \
    --parameter-overrides `cat parameters.txt` \
    --region ap-northeast-1 \
    --profile default
    