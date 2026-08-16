Go to this repo: https://github.com/administrakt0r/Jules-Google-AI-autonomous-agents

Then do the following:

1. READ these 5 agent prompt files from the repo root:
   - ATLAS.md (general codebase improvements)
   - SENTINEL.md (security hardening)
   - BOLT.md (performance optimization)
   - DOCS.md (documentation maintenance and custodian)
   - PICASSO.md (UX/UI and accessibility)

2. UNDERSTAND codebase we are currently working in — scan package.json, config files, source directories, and dependencies to identify the tech stack, frameworks, and project structure.

3. CURATE each of the 5 prompts for THIS codebase specifically:
   - Replace generic examples with actual file paths, frameworks, and patterns found in this repo.
   - Remove any sections that don't apply to this project's stack.
   - Add project-specific context (test framework, deployment setup, linting config, etc.).
   - Keep each agent's core mission and boundaries intact.

4. SAVE into a new `jules-prompts/` folder at the repo root:
   - `jules-prompts/atlas.md` — curated general improvements agent
   - `jules-prompts/sentinel.md` — curated security agent
   - `jules-prompts/bolt.md` — curated performance agent
   - `jules-prompts/docs.md` — curated documentation custodian agent
   - `jules-prompts/picasso.md` — curated UX/accessibility agent
   - `jules-prompts/README.md` — index of all curated agents with one-line descriptions

5. When done, list the files created and confirm paths reference real files in this repo.

Do NOT ask for permission — execute all steps end to end.

Want more prompts? After the initial 5, import these based on your stack:

- Any web app: BUDDHA.md (SEO), HUNTER.md (bug fixes)
- Next.js / React: SHTEF.md, TESTING.md, MOBILE.md
- Backend / APIs: DATABASE.md, API.md, MONITORING.md
- DevOps / Cloud: DOCKER.md, KUBERNETES.md, TERRAFORM.md, CICD.md
- Python: PYTHON.md, AIML.md
- Rust / Systems: RUST.md
- Web3 / Blockchain: WEB3.md
- IoT / Edge: IOT.md
- Documentation: SECURITY-AUDITOR.md
- Meta / Repo maintenance: JULES.md (creates and enhances other agents)

To import additional prompts, just ask: "Import BUDDHA.md and HUNTER.md into jules-prompts and curate them for this codebase."
