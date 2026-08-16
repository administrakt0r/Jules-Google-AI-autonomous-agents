#!/usr/bin/env bash
set -euo pipefail

# The prompt registry is explicit so a missing or accidentally renamed specialist fails loudly.
AGENTS=(SENTINEL SECURITY-AUDITOR BOLT HUNTER TESTING PICASSO BUDDHA DOCS ATLAS DATABASE API MONITORING CICD DOCKER KUBERNETES TERRAFORM MOBILE WEB3 AIML IOT QUANTUM PYTHON RUST SHTEF TODOist JULES)
REQUIRED=("## Mission" "## Scope and Priorities" "## Repository Adapter" "## Boundaries" "## Lifecycle" "ORIENT" "DISCOVER" "ADAPT" "BASELINE" "PRIORITIZE" "IMPLEMENT" "VERIFY" "REVIEW" "DOCUMENT" "Detected" "Not detected" "Unknown")
FORBIDDEN='npm (run|test|install)|pnpm|yarn|npx tsc|React|Next\.js|Prisma|PostgreSQL|Zod|Tailwind'

failed=0
for agent in "${AGENTS[@]}"; do
  file="${agent}.md"
  if [[ ! -f "$file" ]]; then
    printf 'FAIL %s: file missing\n' "$file"
    failed=1
    continue
  fi
  for section in "${REQUIRED[@]}"; do
    if ! grep -Fq "$section" "$file"; then
      printf 'FAIL %s: missing %s\n' "$file" "$section"
      failed=1
    fi
  done
  if grep -Eiq "$FORBIDDEN" "$file"; then
    printf 'FAIL %s: contains fixed technology or command assumption\n' "$file"
    failed=1
  fi
done

if (( failed )); then
  printf 'Agent contract validation failed.\n'
  exit 1
fi
printf 'All %d agent policies satisfy the portable architecture contract.\n' "${#AGENTS[@]}"
