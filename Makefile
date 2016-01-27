
all: document 

.PHONY: clean document

document:
	pdflatex document.tex  > build.log
	bibtex   document.aux >> build.log
	pdflatex document.tex >> build.log
	bibtex   document.aux >> build.log
	pdflatex document.tex >> build.log

diff:
	latexdiff-git --math-markup=0 --force -r draft-4 thesis.tex
	\pdflatex -shell-escape "thesis-diffdraft-4.tex" 
	\bibtex                 "thesis-diffdraft-4.aux"
	\pdflatex -shell-escape "thesis-diffdraft-4.tex" 
	\pdflatex -shell-escape "thesis-diffdraft-4.tex" 

check: spell diction considerate wordcount 

considerate:
	alex document.tex

spell:
	ispell -dbritish-huge document.tex

diction:
	diction -s document.tex

wordcount:
	echo "Word Count: `detex document.tex | wc -w`"
