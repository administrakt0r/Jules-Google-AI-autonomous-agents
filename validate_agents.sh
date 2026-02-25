#!/bin/bash

AGENTS=(
  "SENTINEL" "BOLT" "ATLAS" "BUDDHA" "HUNTER" "PICASSO" "SHTEF"
  "DOCKER" "KUBERNETES" "DATABASE" "CICD" "MONITORING" "API"
  "MOBILE" "TESTING" "WEB3" "AIML" "IOT" "QUANTUM" "DOCS" "JULES"
)

echo "🔍 Starting Agent Validation..."

for agent in "${AGENTS[@]}"; do
  file="${agent}.md"
  echo "----------------------------------------"
  echo "🤖 Validating $agent agent..."

  # Check if agent file exists
  if [ ! -f "$file" ]; then
    echo "❌ Agent file $file not found"
    exit 1
  fi
  echo "✅ Agent file exists"

  # Check required sections
  required_sections=(
    "You are"
    "Your mission is to"
    "## Boundaries"
    "✅ **Always do:**"
    "⚠️ **Ask first:**"
    "🚫 **Never do:**"
  )

  for section in "${required_sections[@]}"; do
    if ! grep -Fq "$section" "$file"; then
      echo "❌ Missing required section: $section"
      exit 1
    fi
    echo "✅ Found section: $section"
  done

  # Check for emoji in agent name
  if ! grep -q "🤖\|🛡️\|⚡\|🌐\|🧘\|🔍\|🎨\|😎\|🐳\|☸️\|🗄️\|🔄\|📊\|🔌\|📱\|🧪\|⚛️\|📚\|🚀" "$file"; then
    echo "⚠️ Warning: Agent should have an emoji"
  else
    echo "✅ Agent has emoji"
  fi

  # Check file size
  file_size=$(wc -c < "$file")
  if [ $file_size -lt 1000 ]; then
    echo "⚠️ Warning: Agent file seems too small ($file_size bytes)"
  elif [ $file_size -gt 50000 ]; then
    echo "⚠️ Warning: Agent file seems too large ($file_size bytes)"
  else
    echo "✅ Agent file size is reasonable ($file_size bytes)"
  fi
done

echo "----------------------------------------"
echo "🎉 All agents validated successfully!"
