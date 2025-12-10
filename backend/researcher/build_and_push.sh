#!/bin/bash
set -e

echo "Building and pushing Docker image for researcher..."
echo "=================================================="

REGION="eu-west-2"
ACCOUNT_ID="613211803470"
ECR_REPO="alex-researcher"
ECR_URL="${ACCOUNT_ID}.dkr.ecr.${REGION}.amazonaws.com/${ECR_REPO}"

echo "Region: $REGION"
echo "ECR URL: $ECR_URL"

# Login to ECR
echo ""
echo "Logging in to ECR..."
aws ecr get-login-password --region $REGION | docker login --username AWS --password-stdin $ECR_URL

# Build for linux/amd64 (App Runner requirement)
echo ""
echo "Building Docker image..."
docker build --platform linux/amd64 -t $ECR_REPO:latest .

# Tag for ECR
echo ""
echo "Tagging image..."
docker tag $ECR_REPO:latest $ECR_URL:latest

# Push to ECR
echo ""
echo "Pushing to ECR..."
docker push $ECR_URL:latest

echo ""
echo "✅ Docker image pushed successfully!"
echo "Next: Run 'terraform apply' again to create the App Runner service"
