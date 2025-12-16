# Makefile for assignments
# Date: 2025
# Author: Daniel Montrallo Flickinger, PhD ; dflickinger@wpi.edu

LATEX_BUILD = xelatex -shell-escape -interaction=nonstopmode -file-line-error

all : document
document: $(assignment_name).tex
	$(LATEX_BUILD) $(assignment_name)
	$(LATEX_BUILD) $(assignment_name)
	makeindex $(assignment_name)-url
	$(LATEX_BUILD) $(assignment_name)
