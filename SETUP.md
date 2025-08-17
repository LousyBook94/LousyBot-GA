# LousyBot Setup Guide

## Overview
LousyBot is an AI-powered GitHub assistant that can automatically assign badges to issues and respond to user mentions with intelligent, multi-step actions.

## Required Secrets

### 1. API Configuration
These secrets are required for both workflows:

- `LB_BASE_URL`: The base URL for the AI API (default: https://text.pollinations.ai/openai/chat/completions)
- `LB_MODEL`: The AI model to use (default: gpt-5-nano)
- `LB_API_KEY`: API key for the AI service

### 2. GitHub App Configuration (Recommended)
For better authentication and rate limits:

- `LB_APP_ID`: Your GitHub App ID
- `LB_PRIVATE_KEY`: Your GitHub App private key (multi-line, use `-----BEGIN RSA PRIVATE KEY-----` format)
- `LB_INSTALLATION_ID`: The installation ID for your GitHub App

## Setup Steps

### 1. Get LousyBot Files
Clone or download this repository and copy the `.github` folder to your repository:

```bash
# Clone the LousyBot repository
git clone https://github.com/LousyBook94/LousyBot-GA.git
cd LousyBot-GA

# Copy the .github folder to your repository
cp -r .github/ /path/to/your-repository/

# Generate bot logo (optional)
python logo.py
```

This will create:
- `.github/workflows/issue-badges.yml` - Automatic badge assignment
- `.github/workflows/issue-responder.yml` - Issue responder with @lousybot mentions
- `.github/lousybot-config.yml` - Configuration file
- `logo.png` and `logo_pfp.png` - Bot logos for profile pictures

### 2. Create GitHub App
1. Go to your GitHub organization/user settings
2. Navigate to "Developer settings" > "GitHub Apps"
3. Click "New GitHub App"
4. Fill in the app details:
   - App name: "LousyBot"
   - Homepage URL: Your repository URL
   - Webhook URL: Leave empty for now
   - Webhook secret: Leave empty
5. Under "Repository permissions":
   - Issues: "Read & write"
   - Pull requests: "Read & write"
   - Contents: "Read"
6. Under "Subscribe to events":
   - Issues: "Selected events" > Check all
   - Issue comments: "Selected events" > Check all
7. Click "Create GitHub App"

### 2. Install GitHub App
1. After creating the app, click "Install App"
2. Select the repositories where you want to install LousyBot
3. Click "Install"

### 3. Get Installation ID
1. Go back to your GitHub App settings
2. Note the App ID
3. In the left sidebar, click "Installations"
4. Find your installation and note the Installation ID

### 4. Configure Secrets
Add the following secrets to your repository:

```bash
# API Configuration
echo "LB_BASE_URL=https://text.pollinations.ai/openai/chat/completions" | gh secret set LB_BASE_URL
echo "LB_MODEL=gpt-5-nano" | gh secret set LB_MODEL
echo "LB_API_KEY=your_api_key_here" | gh secret set LB_API_KEY

# GitHub App Configuration (if using)
echo "LB_APP_ID=your_app_id_here" | gh secret set LB_APP_ID
echo "LB_PRIVATE_KEY=-----BEGIN RSA PRIVATE KEY-----..." | gh secret set LB_PRIVATE_KEY
echo "LB_INSTALLATION_ID=your_installation_id_here" | gh secret set LB_INSTALLATION_ID
```

### 5. Alternative: Using Personal Access Token
If you prefer not to use a GitHub App, you can use a Personal Access Token:

```bash
echo "LB_GITHUB_TOKEN=your_personal_access_token" | gh secret set LB_GITHUB_TOKEN
```

## Workflow Features

### Issue Badge Assignment
- Automatically analyzes new/edited issues
- Assigns appropriate badges based on content
- Provides detailed explanations for badge assignments
- Special handling for negative badges (wontfix, duplicate, invalid)

### Issue Responder
- Detects `@lousybot` mentions in issues and comments
- Provides intelligent, context-aware responses
- Supports multi-step actions:
  - `read_file <path>` - Read file contents
  - `read_issue <number>` - Read another issue for context
  - `list_files` - List repository files
  - `search_files <pattern>` - Search for files
  - `analyze_code <path>` - Analyze code
  - `suggest_fix <description>` - Suggest fixes
- Shows "Processing..." indicator while working
- Maintains conversation context across multiple steps

## Testing

### Test Badge Assignment
1. Create a new issue with title like "Bug in login functionality"
2. LousyBot should automatically assign appropriate badges
3. Check the comments for badge assignment explanations

### Test Issue Responder
1. Create an issue or comment with `@lousybot Can you help me understand the codebase?`
2. LousyBot should respond and potentially take actions to analyze the repository
3. Watch for the "Processing..." indicator and subsequent multi-step responses

## Troubleshooting

### Common Issues

1. **Workflow not triggering**
   - Ensure secrets are correctly configured
   - Check that workflows are enabled in the repository
   - Verify the workflow syntax is correct

2. **API calls failing**
   - Check that `LB_API_KEY` is valid
   - Verify `LB_BASE_URL` is accessible
   - Ensure API quota hasn't been exceeded

3. **GitHub App authentication issues**
   - Verify App ID and Installation ID are correct
   - Check that the private key is properly formatted
   - Ensure the app has the correct permissions

### Debug Mode
To enable debug logging, add the following to your workflow files:

```yaml
env:
  LOG_LEVEL: debug
```

## Configuration Customization

You can modify the behavior by editing `.github/lousybot-config.yml`:

- Adjust response lengths and timeouts
- Change supported file types
- Modify temperature and token settings
- Configure available actions

## Support

For issues or questions:
1. Check the troubleshooting section
2. Review the workflow logs in the Actions tab
3. Ensure all secrets are properly configured