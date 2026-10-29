#!/usr/bin/env bash
# Mocked auth and launcher only; no model request or real Limen job.
set -euo pipefail
root=$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd -P)
tmp=$(mktemp -d)
trap 'rm -rf "$tmp"' EXIT
mkdir -p "$tmp/bin" "$tmp/agent"
printf '#!/bin/sh\nprintf "%%s\\n" "$MOCK_AUTH"\n' > "$tmp/bin/pi"
printf '#!/bin/sh\nprintf "%%s\\n" "$@" > "$MOCK_CALL"\n' > "$tmp/bin/limen"
chmod +x "$tmp/bin/pi" "$tmp/bin/limen"
export PATH="$tmp/bin:$PATH" PI_CODING_AGENT_DIR="$tmp/agent" MOCK_CALL="$tmp/call"
export MOCK_AUTH='{"status":"ready","provider":"openai","authType":"oauth"}'
"$root/scripts/limen-oauth.sh" worker 'trial' 'edit docs' >/dev/null
[[ $(grep -A1 -- '--thinking' "$tmp/call" | tail -1) = medium ]]
[[ $(grep -A1 -- '--provider' "$tmp/call" | tail -1) = openai ]]
"$root/scripts/limen-oauth.sh" reviewer 'review' 'check diff' >/dev/null
[[ $(grep -A1 -- '--thinking' "$tmp/call" | tail -1) = high ]]
rm "$tmp/call"
export MOCK_AUTH='{"status":"ready","provider":"openai","authType":"api_key"}'
if "$root/scripts/limen-oauth.sh" worker trial edit >/dev/null 2>&1; then echo 'API key route allowed' >&2; exit 1; fi
[[ ! -f $tmp/call ]]
export MOCK_AUTH='{"status":"ready","provider":"openai","authType":"oauth"}'
OPENAI_API_KEY=secret "$root/scripts/limen-oauth.sh" worker trial edit >/dev/null 2>&1 && { echo 'API key environment allowed' >&2; exit 1; }
[[ ! -f $tmp/call ]]
printf '{"providers":{"openai":{"baseUrl":"https://example.invalid"}}}\n' > "$tmp/agent/models.json"
if "$root/scripts/limen-oauth.sh" worker trial edit >/dev/null 2>&1; then echo 'provider override allowed' >&2; exit 1; fi
[[ ! -f $tmp/call ]]
printf 'Mocked OAuth route and fail-closed cases: passed\n'
