# TODOs

## Planta

2. Abstract appears twice: it is in both the chapter-opening abstract box and \section{Abstract}. The old file filled the box, while SUAVE and ROSA put it in the section. Delete one if you prefer.
4. "Electronic supplement" wording: two sentences in the evaluation still mention it. That is the verbatim text, and the material is now sections 4.13–4.15 of the same chapter.
5. Layout quirks:
   - About 12 overfull boxes, mostly wide equations and figures. The thesis page is narrower than the ACM manuscript, and the old chapter had overflows of the same size.
   - The long chapter title wraps onto two lines in the page header. This was already the case before. A short title, \chapter[short]{…}, would fix it but also changes the table of contents.
6. Building locally: xelatex isn't on your PATH, so I built with /usr/local/texlive/2026/bin/x86_64-linux.
