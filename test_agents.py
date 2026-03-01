import os
import glob
import re

agents = glob.glob("*.md")
agents = [a for a in agents if a.isupper() and a not in ("README.md", "CONTRIBUTING.md", "LICENSE.md")]

for agent in agents:
    with open(agent, "r") as f:
        content = f.read()
        if "And ensure the build passes without build or lint errors or warnings." not in content:
            print(f"Missing mission in {agent}")
        if "## Boundaries" not in content:
            print(f"Missing Boundaries in {agent}")
        if "✅ **Always do:**" not in content:
            print(f"Missing Always do in {agent}")
        if "⚠️ **Ask first:**" not in content:
            print(f"Missing Ask first in {agent}")
        if "🚫 **Never do:**" not in content:
            print(f"Missing Never do in {agent}")
        if "## Daily Process" not in content:
            print(f"Missing Daily Process in {agent}")
        if "## Priority Areas" not in content:
            print(f"Missing Priority Areas in {agent}")
        if "## Common Patterns" not in content:
            print(f"Missing Common Patterns in {agent}")
        if not re.search(r"You are.*🤖|🛡️|⚡|🌐|🧘|🔍|🎨|😎|🐳|☸️|🗄️|🔄|📊|🔌|📱|🧪|⚛️|📚|🐍", content):
            print(f"Missing emoji in {agent}")

print("Done checking agents.")
