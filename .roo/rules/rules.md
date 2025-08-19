## On Chat Begin
- Always use the `context7` MCP to load **GitHub Script documentation** at the start of every chat.
- Assume Context7 MCP is pre‑connected and ready.


- ALWAYS ALWAYS LOAD THE `Github Script` docs using context7 mcp.

## GitHub App Action Policy
- For all GitHub App–related operations (commenting, labelling, closing issues, etc.):
  - **Only** use:
    - GitHub REST API
    - GitHub CLI (`gh`) authenticated with the App token
- Never attempt these operations with GitHub Script in workflows — it will not work with the App token.

## Repo URL
- https://github.com/LousyBook94/LousyBot-GA