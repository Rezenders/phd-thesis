# PhD thesis: Knowledge-based Self-adaptive Robotic Systems

LaTeX sources of the thesis. Based on the TU Delft dissertation template
(https://github.com/Inventitech/phd-thesis-template).

## Building

Requires TeX Live (2026 or newer) with LuaLaTeX, latexmk, biber and makeglossaries.

```sh
make                  # build/dissertation.pdf and build/propositions.pdf
make diff REV=<rev>   # build/dissertation-diff.pdf: changes since a git revision (latexdiff-vc)
make clean
```

The engine (LuaLaTeX), output directory and glossary rule are set in `.latexmkrc`,
so plain `latexmk dissertation` (and VimTeX) build the same way.

GitHub Actions builds both PDFs on every push (`.github/workflows/build.yml`);
download them from the run's artifacts.
