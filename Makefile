# Main document
DOCUMENT = document
# Diff source document
DIFFSOURCE = thesis
# Diff result document
DIFFRESULT = thesis-diffdraft-4
# Build log variable
LOG = build.log

.PHONY: clean document check considerate spell diction wordcount

all: document

document:
	pdflatex $(DOCUMENT).tex  > $(LOG)
	bibtex   $(DOCUMENT).aux >> $(LOG)
	bibtex   $(DOCUMENT).aux >> $(LOG)
	pdflatex $(DOCUMENT).tex >> $(LOG)
	pdflatex $(DOCUMENT).tex >> $(LOG)

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