# Test API configuration using PowerShell
Write-Host "🧪 Testing API Configuration..." -ForegroundColor Green
Write-Host "================================" -ForegroundColor Green

# API Configuration
$baseUrl = "https://text.pollinations.ai/openai/chat/completions"
$model = "claude"
$apiKey = "emPlF1WBJjz8a6pA"

Write-Host "Base URL: $baseUrl" -ForegroundColor Yellow
Write-Host "Model: $model" -ForegroundColor Yellow
Write-Host "API Key: $apiKey" -ForegroundColor Yellow

# Prepare the request body
$body = @{
    model = $model
    messages = @(
        @{
            role = "user"
            content = "Hello! This is a test message from LousyBot."
        }
    )
    max_tokens = 50
    temperature = 0.7
} | ConvertTo-Json -Depth 10

Write-Host "`n🚀 Making test API request..." -ForegroundColor Green
Write-Host "================================" -ForegroundColor Green

# Make the API request
try {
    $response = Invoke-RestMethod -Uri $baseUrl -Method POST -Headers @{
        "Content-Type" = "application/json"
        "Authorization" = "Bearer $apiKey"
    } -Body $body
    
    Write-Host "`n✅ API test successful!" -ForegroundColor Green
    Write-Host "Response:" -ForegroundColor Cyan
    Write-Host ($response | ConvertTo-Json -Depth 10) -ForegroundColor White
    
    # Extract and display the message content
    if ($response.choices -and $response.choices[0] -and $response.choices[0].message) {
        Write-Host "`n🤖 Bot Response:" -ForegroundColor Cyan
        Write-Host $response.choices[0].message.content -ForegroundColor White
    }
    
    exit 0
}
catch {
    Write-Host "`n❌ API test failed!" -ForegroundColor Red
    Write-Host "Error: $($_.Exception.Message)" -ForegroundColor Red
    
    # Try to get the detailed error response
    try {
        $errorResponse = $_.Exception.Response.GetResponseStream()
        $reader = New-Object System.IO.StreamReader($errorResponse)
        $errorBody = $reader.ReadToEnd()
        Write-Host "`n📋 Detailed Error Response:" -ForegroundColor Yellow
        Write-Host $errorBody -ForegroundColor White
    } catch {
        Write-Host "`n📋 Could not get detailed error response." -ForegroundColor Yellow
    }
    
    # Check if it's a 502 error
    if ($_.Exception.Response.StatusCode.value__ -eq 502) {
        Write-Host "`n🚨 The API service is currently down (502 Bad Gateway)." -ForegroundColor Yellow
        Write-Host "This is likely a temporary issue with the Pollinations service." -ForegroundColor Yellow
        Write-Host "Please try again later." -ForegroundColor Yellow
    }
    
    exit 1
}