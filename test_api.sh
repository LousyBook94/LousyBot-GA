#!/bin/bash

# Test API configuration script
# This script tests the API endpoint to ensure it works before deploying to GitHub Actions

echo "🧪 Testing API Configuration..."
echo "================================"

# Read configuration from .github/lousybot-config.yml
if [ -f ".github/lousybot-config.yml" ]; then
    echo "📋 Reading configuration from .github/lousybot-config.yml..."
    
    # Extract values using grep and sed
    LB_BASE_URL=$(grep "LB_BASE_URL:" .github/lousybot-config.yml | sed 's/LB_BASE_URL: *//')
    LB_MODEL=$(grep "LB_MODEL:" .github/lousybot-config.yml | sed 's/LB_MODEL: *//')
    LB_API_KEY=$(grep "LB_API_KEY:" .github/lousybot-config.yml | sed 's/LB_API_KEY: *//')
    
    echo "LB_BASE_URL: $LB_BASE_URL"
    echo "LB_MODEL: $LB_MODEL"
    echo "LB_API_KEY length: ${#LB_API_KEY}"
else
    echo "❌ Configuration file not found: .github/lousybot-config.yml"
    echo "Please create this file with your API configuration:"
    echo "LB_BASE_URL: https://text.pollinations.ai/openai/chat/completions"
    echo "LB_MODEL: claude"
    echo "LB_API_KEY: your-api-key-here"
    exit 1
fi

# Test API request
echo ""
echo "🚀 Making test API request..."
echo "================================"

# Make the API request using curl
response=$(curl -s -w "\nHTTP_STATUS:%{http_code}" \
  -X POST "$LB_BASE_URL" \
  -H "Content-Type: application/json" \
  -H "Authorization: Bearer $LB_API_KEY" \
  -d "{
    \"model\": \"$LB_MODEL\",
    \"messages\": [
      {
        \"role\": \"user\",
        \"content\": \"Hello! This is a test message from LousyBot.\"
      }
    ],
    \"max_tokens\": 50,
    \"temperature\": 0.7
  }")

# Extract HTTP status code
http_status=$(echo "$response" | grep -o 'HTTP_STATUS:[0-9]*' | cut -d: -f2)
response_body=$(echo "$response" | sed -e 's/HTTP_STATUS:[0-9]*$//')

echo ""
echo "📊 Response Details:"
echo "HTTP Status: $http_status"
echo "Response Body:"
echo "$response_body" | jq '.' 2>/dev/null || echo "$response_body"

# Check if the request was successful
if [ "$http_status" = "200" ]; then
    echo ""
    echo "✅ API test successful!"
    echo "The API configuration is working correctly."
    exit 0
else
    echo ""
    echo "❌ API test failed!"
    echo "HTTP Status: $http_status"
    echo "Please check your API configuration."
    exit 1
fi