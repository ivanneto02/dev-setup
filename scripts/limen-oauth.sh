#!/usr/bin/env bash
# Bounded Limen spawn on the one permitted ChatGPT OAuth route; no paid API fallback.
set -euo pipefail
if [[ $# -ne 3 || ( $1 != worker && $1 != reviewer ) ]]; then
  echo 'Usage: limen-oauth.sh worker|reviewer LABEL TASK' >&2
  exit 2
fi
role=$1 label=$2 task=$3
[[ -n $label && -n $task ]] || { echo 'Label and task are required.' >&2; exit 2; }
if [[ -n ${OPENAI_API_KEY-} || -n ${OPENAI_BASE_URL-} ]]; then
  echo 'Refusing OpenAI API key or alternate endpoint environment.' >&2; exit 1
fi
command -v pi >/dev/null && command -v limen >/dev/null && command -v node >/dev/null || {
  echo 'Pi, Limen and Node are required.' >&2; exit 1
}
root=$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd -P)
agent_dir=${PI_CODING_AGENT_DIR:-$HOME/.pi/agent}
# A provider override can silently redirect even a correctly named model.
for file in "$agent_dir/models.json" "$root/.pi/models.json"; do
  [[ -f $file ]] || continue
  if ! node -e 'const f=require(process.argv[1]); if (f.providers && Object.hasOwn(f.providers,"openai")) process.exit(1)' "$file"; then
    echo "Refusing OpenAI provider override or invalid model catalog: $file" >&2; exit 1
  fi
done
if ! pi auth check --provider openai --model gpt-6-sol --json --no-refresh |
     node -e 'let s="";process.stdin.on("data",c=>s+=c);process.stdin.on("end",()=>{try {const a=JSON.parse(s);process.exit(a.status==="ready"&&a.provider==="openai"&&a.authType==="oauth"?0:1)}catch{process.exit(1)}})'; then
  echo 'Refusing worker: openai/gpt-6-sol OAuth route is not ready.' >&2; exit 1
fi
thinking=medium
[[ $role = reviewer ]] && thinking=high
LIMEN_MAX_TOOL_CALLS=50 LIMEN_PREFLIGHT=auth limen spawn --engine pi \
  --provider openai --model gpt-6-sol --thinking "$thinking" \
  --timeout 10m --detached --label "$label" "$task"
