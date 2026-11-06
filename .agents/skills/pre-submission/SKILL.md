---
name: pre-submission
description: Use when preparing a scientific manuscript for submission and you need a structured go or no-go checklist.
---

# Pre-Submission Checklist

For role execution and tool fallbacks, follow `.agents/HARNESS.md`.
This workflow is diagnostic only; do not edit manuscript files.

## Required Checks

1. Run `paper-build` for the current manuscript and toolchain.
2. Run `latex-structure-audit` in full mode, reusing the current build report.
3. Run `find-annotations` across the active manuscript.
4. Use `.agents/agents/consistency-auditor.md` on the active manuscript, following
   its mandate and report requirements.
5. If implementation-dependent claims exist, use
   `.agents/agents/paper-implementation-checker.md` on 3–5 highest-risk claims
   selected from the claim ledger, evaluation evidence, and manuscript. If the
   role or implementation evidence is unavailable, report UNVERIFIED, not PASS.
   If no implementation-dependent claims exist, report NOT APPLICABLE with reason.

## Reuse Current Audit Results

Checks 3–5 may reuse results from a supplied `full-manuscript-audit` report only
when their coverage and currency can be verified. This is evidence reuse, not an
automatic cache or permission to infer a pass from an earlier overall verdict.

For each reused check, require:
- report identity and the check's actual findings and unresolved questions;
- active-file coverage, annotation configuration, relevant context, and reviewed
  claim IDs/passages matching this submission check;
- matching content snapshots/hashes for those inputs, including uncommitted work;
- for implementation checks, matching code/data evidence and relevant configuration.

A commit ID alone does not cover dirty/untracked inputs. If provenance or coverage
is missing, rerun the check. If only part changed, recheck the affected scope and
its dependencies, retaining verified unaffected coverage; if that boundary cannot
be established, rerun the full check. Never reuse an unverified result as a pass or
clear unresolved findings without evidence. Build and full structural checks remain
current-run requirements. Identify each reused or rerun check in the final report.

## Optional PDF Layout Check

Offer `pdf-layout-review` for selected rendered equations, figures, tables, and
float placement. Report pages actually viewed and inspection limitations. If
declined or unavailable, mark SKIPPED, not PASS. A required venue/author layout
check that was not performed, or unresolved significant layout defects, blocks GO.

## Verdict Rules

- Do not return GO if a required check fails or remains unverified.
- Report build/lint unavailability and unresolved diagnostics explicitly.
- Open editorial annotations in active files block submission; follow
  `find-annotations` and project annotation definitions. Hidden annotations require
  author review. Report archival matches separately unless explicitly in scope.
- Keep original findings/statuses when reusing evidence. Optional unavailable
  checks are disclosed, not counted as passed.

## Final Report

```text
## Pre-Submission Report

| Check | Status | Evidence / scope / reused or rerun |
|---|---|---|
| Build | PASS / FAIL / UNVERIFIED | |
| Lint | PASS / FAIL / UNVERIFIED / NOT APPLICABLE | |
| LaTeX structure | PASS / FAIL / UNVERIFIED | |
| PDF layout (optional) | PASS / FAIL / SKIPPED | pages viewed and limitations |
| Annotations | PASS / FAIL / UNVERIFIED | count and locations |
| Consistency | PASS / FAIL / UNVERIFIED | |
| Implementation | PASS / FAIL / UNVERIFIED / NOT APPLICABLE | claim coverage |

### Blocking findings and unresolved checks
<evidence-backed findings>

### Verdict: GO / NO-GO
```
