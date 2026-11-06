---
name: section-review
description: Use when a full scientific manuscript section needs scientific review and manuscript-wide consistency auditing without editing files.
---

# Section Review

For role execution and tool fallbacks, follow `.agents/HARNESS.md`; role files do not imply executable subagents.

## Overview

This is a review-only workflow for a complete section. It combines scientific critique with consistency auditing and returns one prioritized, evidence-backed report.

Follow `AGENTS.md` for manuscript policy and the role mandates in `.agents/agents/`.

## When To Use

- After writing or substantially rewriting a full section
- Before handing a section to a co-author
- Before higher-risk submission checks
- When a section may have drifted from the rest of the manuscript

## Inputs Required

Provide:
1. Target section file and section heading
2. The full target section text
3. The neighboring section context immediately before and after when available
4. Optional focus concerns, such as claim accuracy, comparison framing, or terminology drift

## Local Agents To Use

- `.agents/agents/scientific-paper-reviewer.md`
- `.agents/agents/consistency-auditor.md`
- `.agents/agents/prose-reviewer.md` when expression-level clarity or economy is requested
- `.agents/agents/paper-implementation-checker.md` when the section is implementation-heavy or makes detailed technical claims

## Workflow

### Phase 0 - Optional Implementation Verification

For implementation-dependent sections, use `paper-implementation-checker` on the highest-risk claims, following its mandate.

Use this branch when technical correctness is the primary risk. Summarize any `DIVERGES` or `CANNOT_VERIFY` findings before the broader review phases.

### Phase 1 - Scientific Review

Use `scientific-paper-reviewer` on the target section and neighboring context.

Follow the role's scientific-content mandate and report requirements. Flag critical
issues first. When prose diagnosis is requested, use `prose-reviewer` as a separate,
read-only pass; do not assign expression-level criteria to the scientific reviewer.

### Phase 2 - Consistency Audit

Use `consistency-auditor` on the same section.

Follow the role's consistency mandate and report requirements, checking the target
against relevant manuscript definitions and claims.

### Phase 3 - Unified Report

Combine the requested passes into one report. Include prose findings separately
only when that pass was requested:

```text
## Section Review: <Section Name>

### Scientific Quality
<grouped findings with file:line evidence>

### Manuscript Consistency
<grouped findings with file:line evidence>

### Prose Diagnosis
<only when requested; findings from prose-reviewer>

### Implementation Verification
<only when Phase 0 was used; summarize the highest-risk findings with evidence>

### Priority Actions
1. <highest-priority issue, why it matters, and where it appears>
2. <next issue, why it matters, and where it appears>

### Verdict
READY | NEEDS REVISION | MAJOR ISSUES
```

Prioritize technical-correctness issues ahead of consistency and style issues. If neighboring sections were not provided, state that cross-section alignment could only be assessed partially.

## Optional grammar focus

When the author requests focused grammar diagnosis, use
`.agents/skills/scientific-grammar-review/SKILL.md` on the relevant passage with
context. Do not add a grammar pass by default. Merge duplicate diagnoses and
preserve this workflow's report, scope, and human findings gate. Return structural
recommendations separately; do not supply a rewritten passage or pass unapproved
findings to the writer.

## Constraints

- Do not edit files.
- Do not propose full rewrites inline; move rewrite work to `technical-paragraph-rewrite` or `write-to-intent`.
- Report evidence-backed findings only.
