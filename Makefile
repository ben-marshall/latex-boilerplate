
all: document 

.PHONY: clean document

document:
	pdflatex document.tex  > build.log
	bibtex   document.aux >> build.log
	pdflatex document.tex >> build.log
	bibtex   document.aux >> build.log
	pdflatex document.tex >> build.log

changes:
	latexdiff-git --math-markup=0 --force -r draft-4 thesis.tex
	\pdflatex -shell-escape "thesis-diffdraft-4.tex" 
	\bibtex                 "thesis-diffdraft-4.aux"
	\pdflatex -shell-escape "thesis-diffdraft-4.tex" 
	\pdflatex -shell-escape "thesis-diffdraft-4.tex" 

spell:
	ispell -dbritish-huge report.tex

wordcount:
	detex document.tex | wc -w
