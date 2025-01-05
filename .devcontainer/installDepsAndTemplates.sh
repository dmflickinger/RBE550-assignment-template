#!/bin/bash
# Install dependencies and template files

# Install dependencies
# --------------------

export DEBIAN_FRONTEND=noninteractive
apt-get update 
apt-get install -y $(cat .devcontainer/dependencies.txt) 

# Install resources (bibliography)
# --------------------------------

rm -rf bib
git clone https://github.com/dmflickinger/RBE550resources.git bib

# Install assignments template (from local directory)
# ---------------------------------------------------


mkdir -p $(kpsewhich -var-value=TEXMFLOCAL)/tex/latex/RBEassignment/fig
cp -f template/RBEassignment.cls $(kpsewhich -var-value=TEXMFLOCAL)/tex/latex/RBEassignment/
cp -f template/fig/*.png $(kpsewhich -var-value=TEXMFLOCAL)/tex/latex/RBEassignment/fig/


# Also get PGF-pie
# ----------------

CTAN_MIRROR=https://ctan.math.illinois.edu/graphics/pgf/contrib
ZIP_FILE=pgf-pie.zip

mkdir -p $(kpsewhich -var-value=TEXMFLOCAL)/tex/latex/generic

curl ${CTAN_MIRROR}/${ZIP_FILE} -o $(kpsewhich -var-value=TEXMFLOCAL)/
tex/latex/generic/${ZIP_FILE}

unzip $(kpsewhich -var-value=TEXMFLOCAL)/tex/latex/generic/${ZIP_FILE} -x pgf-pie/demo/*

mv pgf-pie $(kpsewhich -var-value=TEXMFLOCAL)/tex/latex/generic/
rm -f $(kpsewhich -var-value=TEXMFLOCAL)/tex/latex/generic/${ZIP_FILE}

# Register the RBE assignment class with texlive
# ----------------------------------------------

tlmgr conf texmf TEXMFLOCAL $(kpsewhich -var-value=TEXMFLOCAL)
mktexlsr $(kpsewhich -var-value=TEXMFLOCAL)


sed -i -e 's/# en_US.UTF-8 UTF-8/en_US.UTF-8 UTF-8/' /etc/locale.gen
dpkg-reconfigure --frontend=noninteractive locales
update-locale LANG=en_US.UTF-8
