## On Chat Begin
- ⚠️ MANDATORY: MUST use the `context7` MCP to load **GitHub Script documentation** at the start of every chat.
- Assume Context7 MCP is pre‑connected and ready.
- Failure to load GitHub Script docs will result in chat termination.

## Documentation Update Policy
- After ANY changes to the codebase or workflows:
  1. Update README.md with new features, changes, or requirements
  2. Update SETUP.md with modified setup steps or configuration
  3. Verify all documentation is synchronized

## GitHub App Action Policy
- For all GitHub App–related operations (commenting, labelling, closing issues, etc.):
  - **Only** use:
    - GitHub REST API
    - GitHub CLI (`gh`) authenticated with the App token
- Never attempt these operations with GitHub Script in workflows — it will not work with the App token.

## Repo URL
- https://github.com/LousyBook94/LousyBot-GA