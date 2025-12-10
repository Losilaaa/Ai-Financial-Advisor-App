#!/bin/bash
echo "Checking Nova Pro access in eu-west-1..."
aws bedrock get-foundation-model-availability --region eu-west-1 --model-id amazon.nova-pro-v1:0 | grep -A2 "authorizationStatus"
