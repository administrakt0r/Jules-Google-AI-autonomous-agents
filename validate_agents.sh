#!/bin/bash
# validate_agents.sh - Local validation script for AI Agents

AGENTS=("SENTINEL" "BOLT" "ATLAS" "BUDDHA" "HUNTER" "PICASSO" "SHTEF" "DOCKER" "KUBERNETES" "TERRAFORM" "DATABASE" "CICD" "MONITORING" "API" "MOBILE" "TESTING" "WEB3" "AIML" "IOT" "QUANTUM" "DOCS")

REQUIRED_SECTIONS=("You are" "Your mission is to" "## Boundaries" "✅ **Always do:**" "⚠️ **Ask first:**" "🚫 **Never do:**")
EMOJI_PATTERN="🤖|🛡️|⚡|🌐|🧘|🔍|🎨|😎|🐳|☸️|🏗️|🗄️|🔄|📊|🔌|📱|🧪|⚛️|📚"

echo "🚀 Starting Agent Validation..."
FAILED=0

for agent in "${AGENTS[@]}"; do
    FILE="${agent}.md"
    echo "----------------------------------------"
    echo "🤖 Validating $agent ($FILE)..."

    # Check existence
    if [ ! -f "$FILE" ]; then
        echo "❌ File not found!"
        FAILED=1
        continue
    fi
    echo "✅ File exists"

    # Check sections
    for section in "${REQUIRED_SECTIONS[@]}"; do
        if ! grep -Fq "$section" "$FILE"; then
            echo "❌ Missing section: '$section'"
            FAILED=1
        fi
    done

    # Check Emoji
    if ! grep -Eq "$EMOJI_PATTERN" "$FILE"; then
         echo "⚠️ Warning: No valid emoji found in content (Expected one of: $EMOJI_PATTERN)"
         # Not failing for emoji warning to match workflow, but script output suggests warning.
    else
         echo "✅ Emoji found"
    fi

    # Check Size
    SIZE=$(wc -c < "$FILE")
    if [ "$SIZE" -lt 1000 ]; then
        echo "⚠️ Warning: File size too small ($SIZE bytes)"
    elif [ "$SIZE" -gt 50000 ]; then
        echo "⚠️ Warning: File size too large ($SIZE bytes)"
    else
        echo "✅ File size OK ($SIZE bytes)"
    fi
done

echo "----------------------------------------"
if [ $FAILED -eq 0 ]; then
    echo "🎉 All agents passed validation!"
    exit 0
else
    echo "❌ Some validations failed."
    exit 1
fi
