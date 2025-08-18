# LousyBot GA - Secrets and Setup Configuration

## Required GitHub Secrets

To use the LousyBot GA workflows, you need to configure the following secrets in your repository:

### 1. API Configuration Secrets

These secrets are used for the Pollinations/OpenAI compatible API:

- **`LB_MODEL`** - The model to use (e.g., "claude", "gpt-3.5-turbo", etc.)
- **`LB_BASE_URL`** - The base URL for the API (e.g., "https://text.pollinations.ai/openai/chat/completions")
- **`LB_API_KEY`** - Your API key for the service (e.g., "123...")

### 2. GitHub App Integration (Optional)

For enhanced functionality and better rate limits, you can create a GitHub App:

1. Go to your GitHub repository Settings → Developer settings → GitHub Apps
2. Click "New GitHub App"
3. Fill in the required information:
   - **App name**: "LousyBot GA"
   - **Homepage URL**: Your repository URL
   - **Webhook URL**: (Optional) For advanced features
4. Under "Repository permissions":
   - Issues: Read & write
   - Pull requests: Read & write
   - Metadata: Read
5. Under "Subscribe to events":
   - Issues
   - Issue comments
   - Pull requests
   - Pull request comments
6. Install the app to your repository
7. Note the App ID and Private Key, and store them as secrets:
   - **GITHUB_APP_ID** - Your GitHub App ID
   - **GITHUB_APP_PRIVATE_KEY** - Your GitHub App Private Key (multiline secret)

## Setup Instructions

### Method 1: Repository Secrets (Recommended for most users)

1. Go to your repository on GitHub
2. Click on **Settings** → **Secrets and variables** → **Actions**
3. Click **New repository secret**
4. Add each of the required secrets:
   - `LB_MODEL`
   - `LB_BASE_URL` 
   - `LB_API_KEY`
   - (Optional) `GITHUB_APP_ID`
   - (Optional) `GITHUB_APP_PRIVATE_KEY`

### Method 2: Environment Secrets (For organizations)

1. Go to your organization settings
2. Navigate to **Secrets and variables** → **Actions**
3. Create environment secrets for repositories that need access

## Workflow Triggers

### Issue Badge Assignment Workflow

Triggers on:
- Issue creation (`issues: opened`)
- Issue editing (`issues: edited`)
- Label changes (`issues: labeled, unlabeled`)
- Comment creation (`issue_comment: created`)
- Comment editing (`issue_comment: edited`)

### Issue Cleaner Workflow

Triggers on:
- Comment containing "@lousybot clear" (`issue_comment: created, edited`)
- Issue editing (`issues: edited`)

## Usage Examples

### Issue Badge Assignment

1. Create an issue with content mentioning "badge", "status", "priority", or "label"
2. The bot will automatically analyze the content and suggest appropriate badges
3. The bot will post a comment with the badge suggestion and add relevant labels

### Issue Cleaner

1. Post a comment with "@lousybot /clear" (or "@lousybot clear")
2. The bot will delete all messages containing @lousybot references and bot messages
3. The bot will post a cleanup summary comment showing the command used

## Troubleshooting

### Common Issues

1. **API returns 402 Payment Required**
   - Check if your API key is valid and has sufficient credits/balance
   - Verify the API key is correctly set in the secrets

2. **Workflow fails with permission errors**
   - Ensure the workflow has the correct permissions in the job definition
   - Check if you need to use a GitHub App for better permissions

3. **Bot doesn't respond to commands**
   - Verify the workflow triggers are correctly configured
   - Check the Actions logs for any errors
   - Ensure the comment format matches exactly ("@lousybot /clear" or "@lousybot clear")

### Debugging

1. Enable debug logging in workflows by adding `ACTIONS_STEP_DEBUG: true` as a secret
2. Check the workflow run logs for detailed error messages
3. Test the API connection locally using the provided `api.ps1` script

## Security Notes

- Never commit API keys or secrets to your repository
- Use GitHub Apps for production deployments (better security and rate limits)
- Regularly rotate your API keys and GitHub App credentials
- Monitor your API usage to avoid unexpected charges

## Rate Limits

- The Pollinations API may have rate limits depending on your plan
- GitHub Actions have their own rate limits (1000 requests/hour for authenticated requests)
- Consider using GitHub App installation tokens for higher rate limits in enterprise environments