#!/bin/bash
agents=(SENTINEL BOLT ATLAS BUDDHA HUNTER PICASSO SHTEF DOCKER KUBERNETES TERRAFORM DATABASE CICD MONITORING API MOBILE TESTING WEB3 AIML IOT QUANTUM DOCS PYTHON JULES)

for agent in "${agents[@]}"; do
  echo "Validating $agent..."
  if [ ! -f "${agent}.md" ]; then
    echo "❌ Agent file ${agent}.md not found"
    continue
  fi

  required_sections=(
    "You are"
    "Your mission is to"
    "## Boundaries"
    "✅ \*\*Always do:\*\*"
    "⚠️ \*\*Ask first:\*\*"
    "🚫 \*\*Never do:\*\*"
    "## Daily Process"
    "## Priority Areas"
    "## Common Patterns"
  )

  for section in "${required_sections[@]}"; do
    if ! grep -q "$section" "${agent}.md"; then
      echo "❌ Missing required section: $section in ${agent}.md"
    fi
  done

  if ! grep -q "Your mission is to" "${agent}.md" || ! grep -q "And ensure the build passes without build or lint errors or warnings" "${agent}.md"; then
    echo "❌ Missing build assurance in ${agent}.md"
  fi

done
