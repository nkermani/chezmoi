#!/bin/bash

diff=$(git diff --cached 2>/dev/null)
[[ -z "$diff" ]] && diff=$(git diff 2>/dev/null)
[[ -z "$diff" ]] && { echo "No changes to commit"; exit 1; }

COPILOT_TOKEN=$(cat ~/.config/github-copilot/apps.json 2>/dev/null | grep -o '"oauth_token":"[^"]*"' | cut -d'"' -f4)
[[ -z "$COPILOT_TOKEN" ]] && COPILOT_TOKEN=$(cat ~/.config/github-copilot/hosts.json 2>/dev/null | grep -o '"oauth_token":"[^"]*"' | cut -d'"' -f4)
[[ -z "$COPILOT_TOKEN" ]] && { echo "Copilot token not found"; exit 1; }

TOKEN_RESP=$(curl -s "https://api.github.com/copilot_internal/v2/token" \
  -H "Authorization: token $COPILOT_TOKEN" \
  -H "Editor-Version: vscode/1.90.0")

API_TOKEN=$(echo "$TOKEN_RESP" | jq -r '.token // empty')
API_ENDPOINT=$(echo "$TOKEN_RESP" | jq -r '.endpoints.api // "https://api.githubcopilot.com"')
[[ -z "$API_TOKEN" ]] && { echo "Failed to get API token"; exit 1; }

prompt="Generate a git commit message using Conventional Commits format.
Types: feat|fix|docs|style|refactor|perf|test|build|ci|chore
Output ONLY the commit message, nothing else.

$diff"

response=$(curl -s "${API_ENDPOINT}/chat/completions" \
  -H "Authorization: Bearer $API_TOKEN" \
  -H "Content-Type: application/json" \
  -H "Editor-Version: vscode/1.90.0" \
  -H "Copilot-Integration-Id: vscode-chat" \
  -d "$(jq -n --arg prompt "$prompt" '{
    "model": "gpt-4o",
    "messages": [{"role": "user", "content": $prompt}],
    "max_tokens": 100,
    "temperature": 0.3
  }')")

msg=$(echo "$response" | jq -r '.choices[0].message.content // empty' 2>/dev/null)

if [[ -n "$msg" ]]; then
    echo "Committing: $msg"
    git commit -m "$msg"
else
    echo "Failed to generate commit message"
    exit 1
fi
