# Main document
DOCUMENT = document

# Output directory
OUTPUT = build

# Reference file
REFERENCES = references.bib

.PHONY: clean document check considerate spell diction wordcount publish

all: $(OUTPUT) document

$(OUTPUT):
	mkdir -p $(OUTPUT)

publish: check document

document:
	pdflatex -output-directory $(OUTPUT) $(DOCUMENT).tex 
	bibtex $(DOCUMENT).aux
	pdflatex -output-directory $(OUTPUT) $(DOCUMENT).tex 
	pdflatex -output-directory $(OUTPUT) $(DOCUMENT).tex 

diff:
	@echo "Usage: make diff base=<commit / tag>"
	git latexdiff -b --main $(DOCUMENT).tex --latexpand $(DOCUMENT).tex $(base) HEAD

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
