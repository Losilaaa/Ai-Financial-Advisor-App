#!/bin/bash
echo "Testing Bedrock access in all EU regions..."
echo ""

for region in eu-west-1 eu-west-2 eu-west-3 eu-central-1 eu-north-1 eu-south-1; do
    echo "Testing $region..."
    result=$(aws bedrock get-foundation-model-availability \
        --region $region \
        --model-id amazon.nova-pro-v1:0 2>&1 | grep "authorizationStatus" || echo "Region not available")
    echo "$region: $result"
    echo ""
done
