# LousyBot-GA

A robust GitHub Actions bot that automatically generates intelligent issue badges and provides comment cleanup functionality using AI-powered analysis.

## ✨ Features

### 🏷️ Smart Issue Badges
- **Automatic Analysis**: Uses AI to analyze issue content and generate relevant badges
- **Multi-dimensional Badges**: Creates badges for priority, type, complexity, and status
- **Label Suggestions**: Automatically suggests and applies appropriate GitHub labels
- **Robust Error Handling**: Gracefully handles API failures and malformed responses
- **Manual Triggers**: Support for on-demand badge generation via `@lousybot /badge`

### 🧹 Intelligent Comment Cleaner
- **Multiple Commands**: Supports `/clear`, `clear`, `/clean`, and `clean` commands
- **Smart Filtering**: Identifies and removes bot-generated comments and badge comments
- **Self-Cleaning**: Summary messages auto-delete to keep issues tidy
- **Comprehensive Cleanup**: Removes all @lousybot mentions and related comments

### 🔧 Technical Improvements
- **No More Double Comments**: Fixed duplicate comment generation
- **Proper JSON Parsing**: Robust handling of different AI response formats
- **GitHub App Support**: Full integration with GitHub Apps for enhanced permissions
- **Comprehensive Error Handling**: Detailed error reporting and graceful fallbacks
- **Configurable AI Models**: Support for multiple AI providers and models

## 🚀 Quick Start

1. **Copy workflows** to your `.github/workflows/` directory
2. **Add required secrets** to your repository settings
3. **Create an issue** to test automatic badge generation
4. **Use `@lousybot /clear`** to test comment cleanup

For detailed setup instructions, see [SETUP.md](SETUP.md).

## 📋 Requirements

### Required Secrets
- `LB_API_KEY` - Your AI service API key

### Optional Configuration
- `LB_MODEL` - AI model (default: `gpt-5-nano`)
- `LB_BASE_URL` - API endpoint (default: Pollinations AI)
- `APP_ID` - GitHub App ID (for enhanced permissions)
- `LB_PRIVATE_KEY` - GitHub App private key

## 🎯 Usage Examples

### Automatic Badge Generation
```
# Triggers automatically on:
- New issues created
- Issue edits
- Label changes
- Comments added
```

### Manual Badge Generation
```
@lousybot /badge
```

### Comment Cleanup
```
@lousybot /clear
@lousybot clear
@lousybot /clean
@lousybot clean
```

## 🔧 Supported AI Services

### Pollinations AI (Default)
- Free tier available
- Multiple models: `gpt-5-nano`, `gpt-3.5-turbo`, `gpt-4`
- No registration required for basic usage

### OpenAI Compatible APIs
- OpenAI API
- Custom endpoints
- Any OpenAI-compatible service

## 📊 Badge Types Generated

The AI analyzes issues and generates badges for:
- **Priority**: 🔥 High, 🟡 Medium, 🟢 Low
- **Type**: 🐛 Bug, ✨ Feature, 📚 Documentation, ❓ Question
- **Complexity**: 🧩 Complex, 🔧 Moderate, ⚡ Simple
- **Status**: 🛠️ Needs Investigation, 🔍 Needs Review, ✅ Ready

## 🛠️ What's Fixed

This version addresses all major issues from the original:

### ✅ Resolved Issues
- **ReferenceError: badges is not defined** - Fixed variable initialization
- **Double commenting** - Separated manual and automatic comment flows
- **Broken JSON parsing** - Robust JSON extraction and fallback handling
- **GitHub App integration** - Proper environment variable handling
- **Poor error handling** - Comprehensive try-catch blocks and error reporting
- **Malformed badge output** - Clean markdown formatting

### 🔄 Improvements
- **Better AI prompts** - More specific instructions for consistent output
- **Fallback mechanisms** - Default badges when AI fails
- **Self-cleaning comments** - Temporary messages auto-delete
- **Enhanced logging** - Detailed console output for debugging
- **Flexible command parsing** - Multiple cleanup command variations

## 📚 Documentation

- [SETUP.md](SETUP.md) - Comprehensive setup guide
- [Workflow Logs](../../actions) - Check execution details
- [Issues](../../issues) - Report bugs or request features

## 🧪 Testing

Test the API connection:
```powershell
.\api.ps1
```

Test workflows:
1. Create a test issue
2. Comment `@lousybot /badge` 
3. Comment `@lousybot /clear`

## 🔒 Security

- All sensitive data stored in GitHub Secrets
- Minimal required permissions
- No data stored or logged externally
- Regular security updates

## 🤝 Contributing

1. Fork the repository
2. Create a feature branch
3. Test your changes thoroughly
4. Submit a pull request

## 📄 License

MIT License - see [LICENSE](LICENSE) for details.

## 🆘 Support

- Check [SETUP.md](SETUP.md) for troubleshooting
- Review workflow logs in the Actions tab
- Create an issue for bugs or feature requests
- Check existing issues for common problems