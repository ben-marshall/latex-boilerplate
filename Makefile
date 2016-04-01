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

.PHONY: clean document check considerate spell diction wordcount

$(OUTPUT):
	mkdir -p $(OUTPUT)

all: $(OUTPUT) document

document:
	pdflatex -output-directory $(OUTPUT) $(DOCUMENT).tex  > $(OUTPUT)/$(LOG)
	bibtex   $(OUTPUT)/$(DOCUMENT).aux >> $(OUTPUT)/$(LOG)
	bibtex   $(OUTPUT)/$(DOCUMENT).aux >> $(OUTPUT)/$(LOG)
	pdflatex -output-directory $(OUTPUT) $(DOCUMENT).tex >> $(OUTPUT)/$(LOG)
	pdflatex -output-directory $(OUTPUT) $(DOCUMENT).tex >> $(OUTPUT)/$(LOG)


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
