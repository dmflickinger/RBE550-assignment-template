# Makefile for assignments
# Date: 2025
# Author: Daniel Montrallo Flickinger, PhD ; dflickinger@wpi.edu

LATEX_BUILD = xelatex -shell-escape -interaction=nonstopmode -file-line-error

all : document
document: $(assignment_name).tex
	$(MAKE) -C diagrams
	$(LATEX_BUILD) $(assignment_name)
	$(LATEX_BUILD) $(assignment_name)
	makeindex $(assignment_name)-url
	bibtex $(assignment_name)
	bibtex $(assignment_name)
	$(LATEX_BUILD) $(assignment_name)
	$(LATEX_BUILD) $(assignment_name)
