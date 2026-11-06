# Harness Adapter Notes

This repository keeps reusable scientific-writing workflows in `.agents/` so they can be shared across Codex, Claude Code, Pi, and other agent harnesses with minimal adaptation.

## Canonical Source

- `.agents/agents/` contains reusable diagnostic and drafting agent instructions.
- `.agents/skills/` contains task workflows.
- `.agents/context/` contains project-specific scientific context, templates, and guardrails.
- Harness-specific directories such as `.claude/` and `.pi/` are adapters only. They should be generated mirrors or small configuration layers, not independent workflow forks. Avoid symlinks in Overleaf-compatible repositories.

Avoid duplicated divergent definitions. When workflow policy changes, update `.agents/` first and regenerate harness adapters.

## Adapter Rules

- Preserve harness-specific settings, trust files, and model configuration.
- Prefer generated mirrors from `.agents/agents` and `.agents/skills` into harness-specific directories when a harness requires those paths.
- Do not hand-edit generated mirrors. Update `.agents/` first, then regenerate adapters.
- Do not use symlinks for repositories synchronized with Overleaf.
- Do not store scientific facts in harness prompts. Store them in `.agents/context/` and load only the files needed for the task.

## Discovery, tools, and portable role execution

- Pi discovers project `.agents/skills/` directly (including nested resources),
  from the working directory through repository ancestors. No `.pi/skills/`
  mirror is needed. Use `/skill:paper-build`, `/skill:latex-structure-audit`, or
  `/skill:pdf-layout-review`; `/reload` refreshes changed skills. Verify local
  discovery if using an older Pi version or restricted resource settings.
- Current Codex discovers `.agents/skills/` directly; no skill mirror is needed.
- Claude Code uses generated `.claude/skills/` directories; invoke `/paper-build`,
  `/latex-structure-audit`, or `/pdf-layout-review`. The installer generates
  these project skills. Preserve existing harness and LSP settings.
- A Markdown role under `.agents/agents/` is an instruction file, **not proof of
  an executable subagent**. Mirroring it does not guarantee registration. For
  every workflow that says use/invoke an agent: discover supported delegation,
  and use a dedicated subagent only when available, authorized and appropriate.
  Supply the canonical role, bounded source/context and read-only review scope.
  Otherwise read the role into the current agent and perform each review
  sequentially with the same criteria. Label this a sequential role-based review,
  never an independent or parallel review. Do not add permanent LaTeX agents.
- Discover available LSP operations rather than hardcoding harness tool names.
  Prefer TexLab definitions, references, document symbols and diagnostics where
  supported; fall back to repository search and build logs. Compilation remains
  primary. Neither LSP nor subagents are prerequisites for these skills.
- Repository paths such as `scripts/latex_diagnostics.py` and `.agents/context/`
  resolve from the project root; bundled `references/...` paths resolve from the
  loaded skill directory. Run build commands from the configured working directory.
- Image viewing is a separate capability: PDF rendering without actually viewing
  the image is not a visual review. Report unavailable checks explicitly.

Follow `.agents/latex-safe-editing.md` before and after approved manuscript edits.

These execution conventions apply to all shared skills. They do not change
passage contracts, diagnostic-only review, human selection of findings, or the
single controlled-revision limit.

## Progressive Disclosure

Keep permanent instructions compact:

1. Root policy files (`AGENTS.md`, `CLAUDE.md`, etc.) define repository-wide safety, editing, and validation rules.
2. Skill files define task workflows.
3. Agent files define focused roles.
4. Context files define project-specific scientific facts and guardrails.

Load detailed context only when relevant. For example, a terminology audit should load `terminology.md`; an evidence-bounded result rewrite should also load `evaluation-claims.md`, `claim-ledger.md`, and `do-not-say.md`.

## Experimental Comparability

To compare harness or model behavior, keep the shared workflow stable:

- same passage contract;
- same context files and claim guardrails;
- same draft/review/revision limits;
- same validation commands;
- same output formats where practical.

Record deviations in the task notes so output differences can be attributed to the harness, model, context loaded, or workflow variant rather than accidental instruction drift.
