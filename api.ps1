# API Test Script for Pollinations/OpenAI Compatible API
# This script tests the API endpoint to understand how to extract content

$apiKey = "key"
$baseUrl = "https://text.pollinations.ai/openai/chat/completions"
$model = "claude"

Write-Host "🧪 Testing API endpoint: $baseUrl" -ForegroundColor Green

# Test payload
$payload = @{
    model = $model
    messages = @(
        @{
            role = "user"
            content = "Hello! Can you tell me about GitHub Actions?"
        }
    )
    max_tokens = 100
} | ConvertTo-Json -Depth 10

$headers = @{
    "Content-Type" = "application/json"
    "Authorization" = "Bearer $apiKey"
}

Write-Host "📤 Sending request with payload:" -ForegroundColor Yellow
Write-Host $payload

try {
    $response = Invoke-RestMethod -Uri $baseUrl -Method Post -Headers $headers -Body $payload
    
    Write-Host "✅ Response received!" -ForegroundColor Green
    Write-Host "📋 Full response:" -ForegroundColor Cyan
    Write-Host ($response | ConvertTo-Json -Depth 10)
    
    # Extract the content from the response
    if ($response.choices -and $response.choices[0] -and $response.choices[0].message -and $response.choices[0].message.content) {
        $content = $response.choices[0].message.content
        Write-Host "🎯 Extracted content:" -ForegroundColor Magenta
        Write-Host $content
    } else {
        Write-Host "❌ Could not extract content from response" -ForegroundColor Red
    }
    
    # Test different models
    Write-Host "`n🔄 Testing with different models..." -ForegroundColor Yellow
    
    $models = @("gpt-3.5-turbo", "gpt-4", "claude-3-sonnet-20240229")
    
    foreach ($testModel in $models) {
        Write-Host "Testing model: $testModel" -ForegroundColor Cyan
        
        $testPayload = @{
            model = $testModel
            messages = @(
                @{
                    role = "user"
                    content = "Hello! Just testing the API."
                }
            )
            max_tokens = 50
        } | ConvertTo-Json -Depth 10
        
        try {
            $testResponse = Invoke-RestMethod -Uri $baseUrl -Method Post -Headers $headers -Body $testPayload
            if ($testResponse.choices -and $testResponse.choices[0] -and $testResponse.choices[0].message -and $testResponse.choices[0].message.content) {
                $content = $testResponse.choices[0].message.content
                Write-Host "✅ $testModel : $content" -ForegroundColor Green
            }
        } catch {
            Write-Host "❌ $testModel failed: $($_.Exception.Message)" -ForegroundColor Red
        }
    }
    
} catch {
    Write-Host "❌ Error occurred: $($_.Exception.Message)" -ForegroundColor Red
    Write-Host "Status Code: $($_.Exception.Response.StatusCode.Value__)" -ForegroundColor Red
    Write-Host "Response: $($_.Exception.Response.GetResponseStream())" -ForegroundColor Red
}

Write-Host "`n🎉 API testing complete!" -ForegroundColor Green