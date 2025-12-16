#!/bin/bash
# Install assignments template (from local directory)
# ---------------------------------------------------


mkdir -p $(kpsewhich -var-value=TEXMFLOCAL)/tex/latex/RBEassignment/fig
cp -f template/RBEassignment.cls $(kpsewhich -var-value=TEXMFLOCAL)/tex/latex/RBEassignment/
cp -f template/fig/*.png $(kpsewhich -var-value=TEXMFLOCAL)/tex/latex/RBEassignment/fig/

# Register the RBE assignment class with texlive
# ----------------------------------------------

tlmgr conf texmf TEXMFLOCAL $(kpsewhich -var-value=TEXMFLOCAL)
mktexlsr $(kpsewhich -var-value=TEXMFLOCAL)

# Copy the Makefile to a central location
MK_PATH=/usr/local/share/RBEassignment
mkdir -p ${MK_PATH}
cp -f template/assignment_diagrams.mk ${MK_PATH}
cp -f template/assignment_inst_clean.mk ${MK_PATH}
cp -f template/assignment_nobib.mk ${MK_PATH}
cp -f template/assignment.mk ${MK_PATH}
