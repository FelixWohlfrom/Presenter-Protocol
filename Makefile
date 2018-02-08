# Converts tex files to pdf and github markdown

# Read all texfiles as reference document
SRC_FILES      = $(wildcard *.tex)
SRC_FILE_NAMES = $(patsubst %.tex,%,$(SRC_FILES))

# Build all files as pdf and github markdown
all: $(SRC_FILE_NAMES)
	@echo "done"

# Build pdf and md file for each tex file
.SECONDARY: # Avoid deletion of final files by make
%: %.pdf %.md
	@echo "Built pdf and markdown"

# Build github flavored markdown from tex file
# Requires pandoc and pandoc-citeproc
%.md: %.tex
	pandoc --standalone --output $@ --read latex --write markdown_github \
		--table-of-contents --filter pandoc-citeproc --bibliography \
		$(basename $<).bib $<
	@echo Built $@

# Build pdf from tex file
# Requires pdflatex and bibtex
%.pdf: %.tex
	pdflatex $<
	bibtex $(basename $<)
	pdflatex $<
	pdflatex $<
	# Cleanup temporary files
	rm -f *.aux *.bbl *.bcf *.blg *-blx.bib *.log *.out *.xml *.toc *.gz
	@echo Built $@

# Cleanup generated files
clean:
	rm -f *.pdf
	mv README.md README.md.keep
	rm -f *.md
	mv README.md.keep README.md
