# Main document
DOCUMENT = document

OUTPUT = .

# Build log variable
LOG = build.log

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
	pdflatex -output-directory $(OUTPUT) $(DOCUMENT).tex  > $(OUTPUT)/$(LOG)
	(cp $(REFERENCES) $(OUTPUT) && cd $(OUTPUT) && bibtex $(DOCUMENT).aux >> $(LOG))
	(cp $(REFERENCES) $(OUTPUT) && cd $(OUTPUT) && bibtex $(DOCUMENT).aux >> $(LOG))
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

clean:
	rm -rf $(OUTPUT)/*
