# Universal Autonomous Agent Policies

Portable, specialized AI-agent prompts for arbitrary codebases. Each prompt separates **Specialist Policy → Repository Adapter → Execution** and adapts only to capabilities it can verify.

## Architecture
Every agent must:
- inspect Git state and repository condition before acting;
- discover the actual languages, frameworks, managers, build/test/lint/type tools, CI/CD, data/API/infrastructure, architecture, conventions, docs, deployment model, and canonical validation commands;
- classify findings as `Detected`, `Not detected`, or `Unknown` rather than guessing;
- report `Not applicable` when its specialty is absent;
- prefer existing patterns and tools, then a small local solution, then a new dependency or architecture;
- gather evidence, assess impact/blast radius/reversibility/confidence, protect user changes, verify work, and converge on repeated runs.

The standard lifecycle is **ORIENT → DISCOVER → ADAPT → BASELINE → PRIORITIZE → IMPLEMENT → VERIFY → REVIEW → DOCUMENT**. `JULES.md` governs this contract and cross-agent boundaries.

## Agents

| Agent | Specialty | Prompt |
|---|---|---|
| Sentinel | Application and systems security | [SENTINEL.md](SENTINEL.md) |
| Security Auditor | Security assurance and evidence | [SECURITY-AUDITOR.md](SECURITY-AUDITOR.md) |
| Bolt | Performance and efficiency | [BOLT.md](BOLT.md) |
| Hunter | Defects and regressions | [HUNTER.md](HUNTER.md) |
| Testing | Test quality and confidence | [TESTING.md](TESTING.md) |
| Picasso | UX and accessibility | [PICASSO.md](PICASSO.md) |
| Buddha | Search and discoverability | [BUDDHA.md](BUDDHA.md) |
| Docs | Documentation | [DOCS.md](DOCS.md) |
| Atlas | General maintenance | [ATLAS.md](ATLAS.md) |
| Database | Data systems | [DATABASE.md](DATABASE.md) |
| API | Interfaces and contracts | [API.md](API.md) |
| Monitoring | Observability | [MONITORING.md](MONITORING.md) |
| CI/CD | Delivery automation | [CICD.md](CICD.md) |
| Docker | Container workflows | [DOCKER.md](DOCKER.md) |
| Kubernetes | Cluster orchestration | [KUBERNETES.md](KUBERNETES.md) |
| Terraform | Infrastructure as code | [TERRAFORM.md](TERRAFORM.md) |
| Mobile | Mobile systems | [MOBILE.md](MOBILE.md) |
| Web3 | Ledger and smart-contract systems | [WEB3.md](WEB3.md) |
| AIML | Machine-learning systems | [AIML.md](AIML.md) |
| IoT | Edge and device systems | [IOT.md](IOT.md) |
| Quantum | Quantum systems | [QUANTUM.md](QUANTUM.md) |
| Python | Python repositories | [PYTHON.md](PYTHON.md) |
| Rust | Rust repositories | [RUST.md](RUST.md) |
| Shtef | Framework adaptation | [SHTEF.md](SHTEF.md) |
| TODOist | Evidence-backed planning and audit output | [TODOist.md](TODOist.md) |
| Jules | Architecture governance | [JULES.md](JULES.md) |

## Use
Copy an individual prompt into an agent platform. It is intentionally stack-agnostic and should be used in the target repository, not curated against this repository. Choose specialists based on detected scope; absent specialties must remain no-op/report-only.

## Validation
Run `./validate_agents.sh` to validate every root prompt. The workflow in `.github/workflows/agents-test.yml` runs the same contract checks plus documentation and link checks. No prompt assumes `npm`, `pnpm`, `yarn`, a fixed build command, `.jules/`, or a particular framework.

See [docs/AGENT_ARCHITECTURE.md](docs/AGENT_ARCHITECTURE.md), [docs/BEST_PRACTICES.md](docs/BEST_PRACTICES.md), and [docs/INTEGRATION_GUIDE.md](docs/INTEGRATION_GUIDE.md) for the operating model.
