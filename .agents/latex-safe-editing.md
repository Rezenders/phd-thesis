# LaTeX-safe editing

Before editing, inspect the target and search for related terminology, definitions,
and claims. Identify the exact passage and enclosing LaTeX environment. Record
protected macros and their arguments, citation/reference keys, labels, equations,
environment boundaries, and input paths; distinguish explicitly authorized
structural changes from constructs that must remain unchanged. Preserve neighbors
and comments. Use minimal diffs; never automatically format whole `.tex` files.

After an approved edit, inspect the actual diff against this inventory. Report
scientific/semantic changes separately from LaTeX structural changes. Validate
affected files and relevant dependencies using available LSP diagnostics or source
checks; use incremental `latex-structure-audit` when warranted. Run `paper-build`
when validity may be affected or after substantive edits, using the configured
build and lint commands in `.agents/context/paper-model.md`. Report build errors,
undefined references, missing citations, newly introduced warnings, checks not run,
unexpected protected-construct changes and unresolved diagnostics. Do not silently
repair equations or keys outside the authorized scope. Minor wording edits do not
require a full-manuscript audit. This procedure does not bypass passage contracts
or human findings gates.
