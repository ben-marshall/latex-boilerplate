# Main document
DOCUMENT = document
# Diff source document
DIFFSOURCE = thesis
# Diff result document
DIFFRESULT = thesis-diffdraft-4

.PHONY: clean document check considerate spell diction wordcount

all: document

document:
	pdflatex $(DOCUMENT).tex  > build.log
	bibtex   $(DOCUMENT).aux >> build.log
	bibtex   $(DOCUMENT).aux >> build.log
	pdflatex $(DOCUMENT).tex >> build.log
	pdflatex $(DOCUMENT).tex >> build.log

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
	echo "Word Count: `detex $(DOCUMENT).tex | wc -w`"