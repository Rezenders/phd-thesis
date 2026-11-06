---
name: full-manuscript-audit
description: Use before submission or after a major revision to audit scientific content and consistency across the active manuscript without editing files.
---

# Full Manuscript Audit

For role execution and tool fallbacks, follow `.agents/HARNESS.md`.
This diagnostic audit covers manuscript content; `pre-submission` adds current
build and structural validation. It may reuse verified current results from this
report under its evidence-reuse rules.

## Scope

Use the section map in `.agents/context/paper-model.md`. Resolve the active entry
and dependencies before auditing if the map is incomplete. Record the active files,
relevant context and annotation definitions, and content snapshots/hashes, including
uncommitted inputs, so later checks can establish currency. Do not claim full
coverage when the active manuscript cannot be established.

## Workflow

1. Run `find-annotations` over the active manuscript.
2. Use `.agents/agents/consistency-auditor.md` across that manuscript, following
   the role's mandate and report requirements.
3. Use `.agents/agents/scientific-paper-reviewer.md` on each section, following
   its scientific-content mandate. Report critical and major defects; omit minor
   style notes. If prose diagnosis is explicitly requested, use
   `.agents/agents/prose-reviewer.md` separately and label its findings.
4. If implementation-dependent claims exist, use
   `.agents/agents/paper-implementation-checker.md` on high-risk claims from the
   claim ledger, evaluation evidence, and manuscript. Record the exact claims and
   code/data/configuration evidence inspected, including content snapshots/hashes.
   Report unavailable verification as UNVERIFIED; if no such claims exist, mark
   NOT APPLICABLE. Do not imply that a spot-check verifies every implementation claim.
5. Deduplicate findings without discarding their evidence or uncertainty. Return
   the unified report below. Do not write an audit artifact unless requested.

## Report

```text
## Full Manuscript Audit

### Coverage and Provenance
<report identity; active files and snapshots; context/annotation configuration;
checks performed or unavailable; reviewed claims and implementation evidence>

### Open Annotations
<count and locations>

### Critical Issues
<submission-blocking findings with evidence>

### Major Issues
<supported defects requiring author attention>

### Per-Section Verdicts
| Section | Verdict |
|---|---|
| <section> | READY / NEEDS REVISION / MAJOR ISSUES / UNVERIFIED |

### Reusable Check Results
<annotation, consistency, and implementation results separately, with coverage,
findings, unresolved questions, and provenance; not just the overall verdict>

### Overall Verdict
GO / CONDITIONAL GO / NO-GO
<content-audit verdict only; disclose remaining submission checks>
```

## Constraints

- Do not edit files or propose replacement prose.
- Do not return GO with unresolved critical/major defects or unverified required
  coverage. CONDITIONAL GO must name the conditions; it is not submission approval.
- Use `write-to-intent` or `technical-paragraph-rewrite` for author-approved fixes.
