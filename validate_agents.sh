#!/bin/bash

AGENTS=(SENTINEL BOLT ATLAS BUDDHA HUNTER PICASSO SHTEF DOCKER KUBERNETES DATABASE CICD MONITORING API MOBILE TESTING WEB3 AIML IOT QUANTUM DOCS PYTHON)

echo "Starting Agent Validation..."
echo "------------------------------"

ERRORS=0

for agent in "${AGENTS[@]}"; do
  echo "Validating ${agent}..."

  if [ ! -f "${agent}.md" ]; then
    echo "❌ Agent file ${agent}.md not found"
    ERRORS=$((ERRORS + 1))
    continue
  fi

  required_sections=(
    "You are"
    "Your mission is to"
    "## Boundaries"
    "✅ **Always do:**"
    "⚠️ **Ask first:**"
    "🚫 **Never do:**"
    "## Daily Process"
  )

  for section in "${required_sections[@]}"; do
    if ! grep -Fq "$section" "${agent}.md"; then
      echo "❌ ${agent}.md missing required section: $section"
      ERRORS=$((ERRORS + 1))
    fi
  done

  if ! grep -q "🤖\|🛡️\|⚡\|🌐\|🧘\|🔍\|🎨\|😎\|🐳\|☸️\|🗄️\|🔄\|📊\|🔌\|📱\|🧪\|⚛️\|📚\|🐍" "${agent}.md"; then
    echo "⚠️ Warning: ${agent}.md should have an emoji"
  fi
done

echo "------------------------------"
if [ $ERRORS -eq 0 ]; then
  echo "🎉 All active agents passed validation!"
  exit 0
else
  echo "❌ Validation failed with $ERRORS errors."
  exit 1
fi
