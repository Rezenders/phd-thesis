
BUILD := build

.PHONY: all figs clean force-build

all: $(BUILD)/dissertation.pdf $(BUILD)/propositions.pdf $(BUILD)/dissertation_print.pdf

force-build:

# Subdirectories of \include'd chapters; LaTeX writes their .aux files there
INCLUDE_DIRS := $(sort $(dir $(shell grep -ohE '\\include\{[^}]*\}' *.tex | sed -E 's/\\include\{(.*)\}/\1/')))

$(BUILD):
	mkdir -p $(BUILD) $(addprefix $(BUILD)/,$(INCLUDE_DIRS))

figs: figs/development_model_without_papers.pdf figs/development_model_just_papers.pdf

figs/%.pdf: figs/%.svg
	rsvg-convert -f pdf -o $@ $<

$(BUILD)/dissertation.pdf: figs force-build | $(BUILD)
	latexmk -xelatex -outdir=$(BUILD) dissertation
	makeglossaries -d $(BUILD) dissertation

$(BUILD)/propositions.pdf: force-build | $(BUILD)
	latexmk -xelatex -outdir=$(BUILD) propositions

$(BUILD)/dissertation_print.pdf: $(BUILD)/dissertation.pdf
	gs -dNOPAUSE -dBATCH -sDEVICE=pdfwrite -dPDFSETTINGS=/prepress -dEmbedAllFonts=true -sOutputFile=$@ -f $<

clean:
	rm -rf $(BUILD)
