# PowerShell script to test the Pollinations.ai API

$apiKey = "YOUR_API_KEY"
$url = "https://text.pollinations.ai/openai/chat/completions"

$headers = @{
    "Authorization" = "Bearer $apiKey"
    "Content-Type"  = "application/json"
}

$body = @{
    "model" = "claude"
    "messages" = @(
        @{
            "role" = "system"
            "content" = "You are a helpful assistant."
        },
        @{
            "role" = "user"
            "content" = "Hello! Who are you?"
        }
    )
} | ConvertTo-Json

Invoke-RestMethod -Uri $url -Method Post -Headers $headers -Body $body -ContentType "application/json"
