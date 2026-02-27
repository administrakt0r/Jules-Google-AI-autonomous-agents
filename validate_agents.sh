#!/bin/bash
# validate_agents.sh - Local validation script for autonomous agents

set -e

# Define required sections
required_sections=(
  "You are"
  "Your mission is to"
  "## Boundaries"
  "✅ **Always do:**"
  "⚠️ **Ask first:**"
  "🚫 **Never do:**"
)

# List of agents (manually updated or dynamically found)
# We'll use dynamic finding to match the workflow's flexibility, but restrict to ALLCAPS .md files
# that are known agents based on the workflow matrix.
# For simplicity, let's find all .md files that look like agents (uppercase) in the current directory.
agents=$(find . -maxdepth 1 -name "[A-Z]*.md" | sed 's|./||' | grep -v "README.md" | grep -v "CONTRIBUTING.md" | grep -v "LICENSE" | grep -v "CODE_OF_CONDUCT.md" | grep -v "SUPPORT.md")

# Initialize failure flag
failed=0

echo "🤖 Validating Agent Prompts..."
echo "=============================="

for agent_file in $agents; do
    agent_name=$(basename "$agent_file" .md)
    echo "🔍 Checking $agent_name..."

    # Check required sections
    for section in "${required_sections[@]}"; do
        if ! grep -Fq "$section" "$agent_file"; then
            echo "  ❌ Missing required section: '$section'"
            failed=1
        else
            echo "  ✅ Found section: '$section'"
        fi
    done

    # Check for emoji in agent name (or file content near top)
    # The workflow checks for specific emojis in the file content.
    if ! grep -q "🤖\|🛡️\|⚡\|🌐\|🧘\|🔍\|🎨\|😎\|🐳\|☸️\|🗄️\|🔄\|📊\|🔌\|📱\|🧪\|⚛️\|📚\|🐍" "$agent_file"; then
        echo "  ⚠️ Warning: Agent should have an emoji"
    else
        echo "  ✅ Agent has emoji"
    fi

    # Check file size
    file_size=$(wc -c < "$agent_file")
    if [ $file_size -lt 1000 ]; then
        echo "  ⚠️ Warning: Agent file seems too small ($file_size bytes)"
    elif [ $file_size -gt 50000 ]; then
        echo "  ⚠️ Warning: Agent file seems too large ($file_size bytes)"
    else
        echo "  ✅ Agent file size is reasonable ($file_size bytes)"
    fi

    echo ""
done

if [ $failed -eq 0 ]; then
    echo "🎉 All agents passed validation!"
    exit 0
else
    echo "❌ Some agents failed validation."
    exit 1
fi
