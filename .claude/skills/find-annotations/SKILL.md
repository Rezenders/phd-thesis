---
name: find-annotations
description: Use when you need an inventory of open inline annotations in the scientific manuscript before review, revision, or submission work.
---

# Find Annotations

Scan manuscript `.tex` files for open inline annotations and report them grouped by annotation type.

## Annotation Commands In This Repository

Customize this list from `AGENTS.md`, `.agents/context/terminology.md`, or the macro definitions in the manuscript project. Common examples:

- `\todo{...}`
- `<AUTHOR_COMMENT_MACRO>{...}`
- `\red{...}`
- `\hide{...}`

## Workflow

1. Run `rg -n` across `*.tex` files in `<PROJECT_ROOT>`.
2. Search for each annotation command above.
3. Identify macro definition files from `.agents/context/paper-model.md`; distinguish command definitions from actual annotation uses rather than assuming a fixed path.
4. Filter out matches from commented-out TeX lines whose content begins with optional whitespace followed by `%`.
5. Flag matches under `old/` separately because they are archival and are not part of the active manuscript unless the user explicitly says otherwise.
6. Group results by annotation type and report file, line, and extracted content.

Example command:

```bash
cd <PROJECT_ROOT>
rg -n --glob '*.tex' --glob '!<MACRO_DEFINITION_FILE>' \
  '\\todo\{|<AUTHOR_COMMENT_MACRO>\{|\\red\{|\\hide\{' \
  | rg -v '^[^:]+:[0-9]+:\s*%'
```

## Reporting Requirements

- Group `\todo`, `\red`, and `\hide` separately.
- Group author comment macros together, with per-author subsections when useful.
- Include the file path and line number for each match.
- Extract and summarize the annotation content inside `{...}` when practical.
- Report totals for active-manuscript annotations and affected files.
- Report `old/` matches separately and treat them as non-blocking by default.

If no annotations are found, report: `No open annotations found in the inspected scope.` This is not a verdict on other manuscript defects.

## Notes

- `\red{}` is blocking when it appears in active manuscript files because it appears in the rendered manuscript.
- `\hide{}` in active manuscript files may not appear in the PDF, but it still requires author review.
- Treat annotation macros as manuscript content to review, not inert comments.
