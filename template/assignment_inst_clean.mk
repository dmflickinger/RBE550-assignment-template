# Makefile for assignments - install and clean targets
# Date: 2025
# Author: Daniel Montrallo Flickinger, PhD ; dflickinger@wpi.edu


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