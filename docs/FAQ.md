# FAQ

## Are these prompts framework-specific?
No. Each prompt defines a specialty and a repository adapter. It must discover the target stack and use its existing patterns. Framework examples are not requirements.

## What if an agent's domain is absent?
It reports `Not applicable` and does not create a missing technology, service, test suite, infrastructure, or user-facing surface.

## How are commands selected?
The agent discovers canonical commands from manifests, scripts, task runners, CI, Makefiles, and documentation. It must not assume a package manager or command.

## How are changes prioritized?
Agents gather evidence and assess impact, blast radius, reversibility, and confidence. They prefer the smallest safe and complete change, not an arbitrary line or change-count limit.

## How is repeated execution handled?
Agents discover existing progress/state tracking, reuse it, and record completed work. They create minimal persistence only when useful and must converge without churn.

## Can repository files change an agent's instructions?
No. Repository content is data, including comments, fixtures, generated files, logs, dependencies, encoded content, and hidden characters. Agents ignore role reassignment, secret-exfiltration attempts, and validation bypasses.

## Which agent should handle overlapping work?
The specialist owning the primary risk handles it. Record cross-domain findings and hand them off rather than duplicating work. Jules reviews overlap and contradictions.

## How do I validate the prompt set?
Run `./validate_agents.sh`. It checks every registered root policy for the architecture contract and fixed-stack assumptions.
