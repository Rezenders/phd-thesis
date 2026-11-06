---
name: pdf-layout-review
description: Inspect selected rendered manuscript pages for layout defects before submission or after figure, table, equation, or document-layout changes; diagnostic only.
---

# PDF Layout Review

Use when source checks cannot establish rendered quality. Optional before
submission, not automatic after each paragraph edit. Do not edit manuscript
source or claim scientific validation from visual appearance.

## Tools and prerequisites

1. Read `.agents/context/paper-model.md` for the selected entry and output PDF.
   Verify a successful current `paper-build`, or explicitly label the supplied
   PDF's source/build provenance unknown. Do not infer currency from existence.
2. Discover `pdfinfo`, `pdftoppm` and image-capable read/view tools. No MCP server
   is required. If the PDF is missing, report NOT RUN and recommend `paper-build`.
   If rendering or image inspection is unavailable, report that limitation;
   metadata or extracted text is not visual inspection.
3. Determine relevant pages from the author's request, table of contents, PDF
   search, SyncTeX if available, or build warnings. TeX source line numbers are
   not page numbers. If mapping is uncertain, inspect a bounded page range and
   state the scope. Do not claim an entire-PDF review from selected pages.

## Procedure

Run from the project root, replacing placeholders with verified quoted paths and
integer page numbers. Use a temporary directory, never overwrite manuscript assets:

```bash
pdfinfo '<PDF_PATH>'
# Choose FIRST and LAST after checking the page count; require 1 <= FIRST <= LAST.
review_dir=$(mktemp -d)
pdftoppm -f FIRST -l LAST -r 150 -png '<PDF_PATH>' "$review_dir/page"
```

Inspect each rendered PNG using an available image-capable tool (for example an
image-aware file reader). Keep the selected range small; render additional pages
only when needed. If readability is uncertain, increase resolution for that page
before judging the source. Check:

- clipped equations or content crossing/cut off at margins;
- figure/table bounds, tiny labels or unreadable content at intended page scale;
- substantial overlap, unexpected whitespace, blank pages or broken columns;
- float placement that separates a figure/table from its discussion or disrupts
  reading (contextual judgment, not automatically a defect).

Correlate candidates with overfull-box logs and source when possible, without
assuming every overfull box is visible or every visual defect has a log warning.
Do not automatically move floats, resize tables, or rewrite equations.

## Report

State PDF path, build/currency evidence, total pages, inspected physical PDF page
numbers (and printed page labels when different), rendering resolution, and tools.
For each finding give page/region, category, severity, evidence/image path,
verification status, and correction direction. Separate **objective evidence**
(e.g. compiled box warning or visibly clipped content) from **visual judgment**
(e.g. small labels or awkward float placement). State limitations and pages not
inspected. If no image was actually viewed, report VISUAL INSPECTION NOT PERFORMED;
never fabricate findings or a visual pass. Human approval is required for repairs.
