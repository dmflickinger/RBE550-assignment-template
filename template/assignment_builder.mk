# Makefile for assignments
# Date: 2025
# Author: Daniel Montrallo Flickinger, PhD ; dflickinger@wpi.edu

LATEX_BUILD = xelatex -shell-escape -interaction=nonstopmode -file-line-error

all : document
document: $(assignment_name).tex
	find . -name "Makefile" -exec sh -c 'cd "$(dirname "$0")" && make' {} \;
	$(LATEX_BUILD) $(assignment_name)
	$(LATEX_BUILD) $(assignment_name)
	makeindex $(assignment_name)-url
	bibtex $(assignment_name)
	bibtex $(assignment_name)
	$(LATEX_BUILD) $(assignment_name)
	$(LATEX_BUILD) $(assignment_name)


install: document
	cp -f $(assignment_name).pdf /output/

clean :
	rm -f $(assignment_name).pdf
	rm -f *.out
	rm -f *.log
	rm -f *.aux
	rm -f *.toc
	rm -f *.lof
	rm -f *.bbl
	rm -f *.blg
	rm -f *.vrb
	rm -f *.nav
	rm -f *.snm
	rm -f *.idx
	rm -f *.mst
	rm -f *.ilg
	rm -f *.ind
