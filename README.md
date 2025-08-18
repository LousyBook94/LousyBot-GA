# LousyBot-GA

A GitHub Action bot that generates issue badges and cleans up comments using the Pollinations AI API.

## Features

### 🏷️ Issue Badges
- Automatically analyzes GitHub issues and generates relevant badges
- Triggers on issue creation, editing, labeling, and unlabeling
- Uses AI to understand issue content and suggest appropriate badges

### 🧹 Issue Cleaner
- Cleans up comments containing `@lousybot clear` command
- Deletes all bot messages and messages mentioning @lousybot
- Provides confirmation when cleanup is complete

## Setup

### Required GitHub Secrets

Configure the following secrets in your repository settings (Settings > Secrets and variables > Actions):

1. **LB_API_KEY** - Your API key for the Pollinations/OpenAI compatible service
2. **LB_MODEL** - (Optional) Model to use for AI generation (default: "claude")
3. **LB_BASE_URL** - (Optional) Base URL for the API (default: "https://text.pollinations.ai/openai/chat/completions")

### GitHub App Integration (Optional)

For enhanced functionality, you can register a GitHub App:

1. Go to GitHub Developer settings
2. Create a new GitHub App
3. Configure the following permissions:
   - Issues: Read & Write
   - Pull requests: Read & Write
4. Install the app to your repository
5. Use the app's installation ID and private key in your secrets

## Usage

### Issue Badges
The issue-badges workflow automatically triggers when:
- A new issue is created
- An existing issue is edited
- Labels are added or removed to an issue

The bot will analyze the issue content and post a comment with generated badges.

### Issue Cleaner
To clean up comments, simply post a comment containing:
```
@lousybot clear
```

The bot will then:
1. Delete all comments made by the bot
2. Delete all comments mentioning @lousybot
3. Post a confirmation message

## Testing

### API Testing
Use the provided `api.ps1` script to test the API endpoint:

```powershell
.\api.ps1
```

This will test different models and show you how to extract content from the API response.

## Configuration Examples

### Basic Configuration
```yaml
# GitHub Secrets
LB_API_KEY: your-api-key-here
LB_MODEL: claude
LB_BASE_URL: https://text.pollinations.ai/openai/chat/completions
```

### Advanced Configuration with GitHub App
```yaml
# GitHub Secrets
LB_API_KEY: your-api-key-here
LB_MODEL: gpt-4
LB_BASE_URL: https://text.pollinations.ai/openai/chat/completions
APP_ID: your-app-id
APP_PRIVATE_KEY: your-private-key
```

## Troubleshooting

### Common Issues

1. **API Key Issues**
   - Ensure LB_API_KEY is properly configured
   - Check that the API key has access to the specified model

2. **Permission Issues**
   - Ensure the workflow has proper permissions (issues: write, pull-requests: write)
   - Check if you're using a GitHub App with correct permissions

3. **Workflow Not Triggering**
   - Verify the workflow triggers are correct
   - Check that the repository has Actions enabled

## License

This project is open source and available under the MIT License.