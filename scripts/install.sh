#!/bin/bash

mkdir -p /usr/local/share/texlive/texmf-local/tex/latex/RBEassignment/fig

cp -f template/RBEassignment.cls /usr/share/texlive/texmf-local/tex/latex/RBE550assignment
cp -f template/fig/*.png /usr/share/texlive/texmf-local/tex/latex/RBE550assignment/fig/
