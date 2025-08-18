# LousyBot-GA Setup Guide

This guide will help you set up LousyBot-GA in your repository to automatically generate issue badges and clean up comments.

## Quick Start

1. **Copy the workflow files** to your repository's `.github/workflows/` directory
2. **Configure the required secrets** in your repository settings
3. **Test the setup** by creating an issue or using manual commands

## Required Configuration

### GitHub Repository Secrets

Navigate to your repository's **Settings > Secrets and variables > Actions** and add these secrets:

#### Required Secrets

| Secret Name | Description | Example |
|-------------|-------------|---------|
| `LB_API_KEY` | API key for the AI service | `your-api-key-here` |

#### Optional Secrets

| Secret Name | Description | Default Value |
|-------------|-------------|---------------|
| `LB_MODEL` | AI model to use | `claude` |
| `LB_BASE_URL` | API endpoint URL | `https://text.pollinations.ai/openai/chat/completions` |

### GitHub App Integration (Optional but Recommended)

For enhanced functionality, you can create a GitHub App:

#### Step 1: Create GitHub App

1. Go to **GitHub Settings > Developer settings > GitHub Apps**
2. Click **New GitHub App**
3. Fill in the basic information:
   - **App name**: `LousyBot-YourRepo` (must be unique)
   - **Homepage URL**: Your repository URL
   - **Webhook URL**: Leave blank or use a placeholder

#### Step 2: Configure Permissions

Set these **Repository permissions**:
- **Issues**: Read & Write
- **Pull requests**: Read & Write
- **Contents**: Read
- **Metadata**: Read

#### Step 3: Configure Events

Subscribe to these events:
- **Issues**
- **Issue comments**

#### Step 4: Install the App

1. After creating the app, go to **Install App**
2. Install it on your repository
3. Note the **Installation ID** from the URL

#### Step 5: Add App Secrets

Add these additional secrets to your repository:

| Secret Name | Description | Where to Find |
|-------------|-------------|---------------|
| `LB_PRIVATE_KEY` | GitHub App private key | Download from app settings |

And add this **Repository Variable**:

| Variable Name | Description | Where to Find |
|---------------|-------------|---------------|
| `APP_ID` | GitHub App ID | App settings page |

## Features

### 🏷️ Issue Badges

**Automatic Triggers:**
- New issue created
- Issue edited
- Labels added/removed
- Issue comments added

**Manual Trigger:**
Comment `@lousybot /badge` on any issue

**What it does:**
- Analyzes issue content using AI
- Generates relevant badges (priority, type, complexity, status)
- Suggests and applies GitHub labels
- Creates/updates a badge comment

### 🧹 Comment Cleaner

**Manual Trigger:**
Comment any of these on an issue:
- `@lousybot /clear`
- `@lousybot clear`
- `@lousybot /clean`
- `@lousybot clean`

**What it does:**
- Deletes all bot-generated comments
- Removes comments mentioning @lousybot
- Cleans up badge comments
- Shows cleanup summary (self-deletes after 10 seconds)

## Testing Your Setup

### Test 1: Create an Issue
1. Create a new issue in your repository
2. Wait 30-60 seconds
3. Check for a badge comment from `github-actions[bot]`

### Test 2: Manual Badge Generation
1. Comment `@lousybot /badge` on any issue
2. Wait 30-60 seconds
3. Check for a new badge comment

### Test 3: Comment Cleanup
1. Comment `@lousybot /clear` on any issue
2. Wait 30-60 seconds
3. All bot comments should be deleted

## Troubleshooting

### Common Issues

#### ❌ "LB_API_KEY secret is required"
**Solution:** Add the `LB_API_KEY` secret to your repository settings.

#### ❌ "API request failed: 401 Unauthorized"
**Solution:** Check that your API key is valid and has the correct permissions.

#### ❌ Workflows not triggering
**Solutions:**
- Ensure GitHub Actions are enabled in repository settings
- Check that workflow files are in `.github/workflows/`
- Verify the workflow syntax is correct

## Security Considerations

### API Keys
- Never commit API keys to your repository
- Use GitHub Secrets for all sensitive information
- Regularly rotate your API keys

### Workflow Permissions
- Workflows use minimal required permissions
- `contents: read` for repository access
- `issues: write` for creating/updating comments
- `pull-requests: write` for PR comments

## License

This project is open source and available under the MIT License.
