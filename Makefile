# Makefile for assignment
# Date: 2020
# Author: Daniel Montrallo Flickinger, PhD ; dflickinger@wpi.edu

assignment_name = RBE550_assignment_template


all : document
document: $(assignment_name).tex
#	$(MAKE) -C diagrams
	xelatex -shell-escape -interaction=nonstopmode -file-line-error $(assignment_name)
	xelatex -shell-escape -interaction=nonstopmode -file-line-error $(assignment_name)
	bibtex $(assignment_name)
	bibtex $(assignment_name)
	xelatex -shell-escape -interaction=nonstopmode -file-line-error $(assignment_name)
	xelatex -shell-escape -interaction=nonstopmode -file-line-error $(assignment_name)


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
