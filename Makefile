BUILD := build
DIFF_BUILD := $(BUILD)/diff

.PHONY: all clean force-build diff

all: $(BUILD)/dissertation.pdf $(BUILD)/propositions.pdf

force-build:

# Subdirectories of \include'd chapters; LaTeX writes their .aux files there
INCLUDE_DIRS := $(sort $(dir $(shell grep -ohE '\\include\{[^}]*\}' *.tex | sed -E 's/\\include\{(.*)\}/\1/')))

# texfot filters latexmk/LaTeX output down to relevant lines; exit status is kept
LATEXMK := texfot latexmk -lualatex

$(BUILD):
	mkdir -p $(BUILD) $(addprefix $(BUILD)/,$(INCLUDE_DIRS))

$(BUILD)/dissertation.pdf: force-build | $(BUILD)
	$(LATEXMK) -outdir=$(BUILD) dissertation

$(BUILD)/propositions.pdf: force-build | $(BUILD)
	$(LATEXMK) -outdir=$(BUILD) propositions

# Changes between a git revision and the working tree: make diff REV=<git-rev>
diff:
	@if [ -z "$(REV)" ]; then echo "usage: make diff REV=<git-rev>  (e.g. REV=HEAD~3 or REV=v1.0)" >&2; exit 2; fi
	mkdir -p $(DIFF_BUILD) $(addprefix $(DIFF_BUILD)/,$(INCLUDE_DIRS))
	# Code blocks are compared as whole units: no diff markup inside verbatim code,
	# and listings from revisions before the switch to piton are dropped.
	latexdiff-vc --git --flatten --force --config='PICTUREENV=(?:picture|DIFnomarkup|lstlisting|Piton)[\w\d*@]*' -r $(REV) dissertation.tex
	mv 'dissertation-diff$(REV).tex' dissertation-diff.tex
	$(LATEXMK) -outdir=$(DIFF_BUILD) dissertation-diff; status=$$?; \
		rm -f dissertation-diff.tex; exit $$status
	cp $(DIFF_BUILD)/dissertation-diff.pdf $(BUILD)/dissertation-diff.pdf

clean:
	rm -rf $(BUILD)
