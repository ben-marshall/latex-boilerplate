# Main document
DOCUMENT = document

# Diff source document
DIFFSOURCE = thesis

# Diff result document
DIFFRESULT = thesis-diffdraft-4

# Build log variable
LOG = build.log

# Output directory
OUTPUT = build

# Reference file
REFERENCES = references.bib

.PHONY: clean document check considerate spell diction wordcount

all: $(OUTPUT) document

$(OUTPUT):
	mkdir -p $(OUTPUT)

document:
	pdflatex -output-directory $(OUTPUT) $(DOCUMENT).tex  > $(OUTPUT)/$(LOG)
	(cp $(REFERENCES) $(OUTPUT) && cd $(OUTPUT) && bibtex $(DOCUMENT).aux >> $(LOG))
	(cp $(REFERENCES) $(OUTPUT) && cd $(OUTPUT) && bibtex $(DOCUMENT).aux >> $(LOG))
	pdflatex -output-directory $(OUTPUT) $(DOCUMENT).tex >> $(OUTPUT)/$(LOG)
	pdflatex -output-directory $(OUTPUT) $(DOCUMENT).tex >> $(OUTPUT)/$(LOG)

diff:
	latexdiff-git --math-markup=0 --force -r draft-4 $(DIFFSOURCE).tex
	\pdflatex -shell-escape "$(DIFFRESULT).tex"
	\bibtex                 "$(DIFFRESULT).aux"
	\pdflatex -shell-escape "$(DIFFRESULT).tex"
	\pdflatex -shell-escape "$(DIFFRESULT).tex"

check: spell diction considerate wordcount 

considerate:
	alex $(DOCUMENT).tex

spell:
	ispell -dbritish-huge $(DOCUMENT).tex

diction:
	diction -s $(DOCUMENT).tex

wordcount:
	@echo "Word Count: `detex $(DOCUMENT).tex | wc -w`"

clean:
	rm -rf $(OUTPUT)/*
