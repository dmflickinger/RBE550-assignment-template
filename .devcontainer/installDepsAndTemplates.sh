#!/bin/bash
# Install dependencies and template files

# Install dependencies
# --------------------

export DEBIAN_FRONTEND=noninteractive
apt-get update 
apt-get install -y $(cat .devcontainer/dependencies.txt) 

# Install fonts
# -------------

LOCAL_FONT_DIR=/usr/share/fonts/googlefonts
REPO_URL="https://github.com/googlefonts/orbitron-vf/raw/refs/heads/master/fonts/ttf/"

mkdir -p $LOCAL_FONT_DIR

curl -fLo $LOCAL_FONT_DIR/Orbitron-Regular.ttf "$REPO_URL/Orbitron-Regular.ttf"
curl -fLo $LOCAL_FONT_DIR/Orbitron-Medium.ttf "$REPO_URL/Orbitron-Medium.ttf"
curl -fLo $LOCAL_FONT_DIR/Orbitron-Bold.ttf "$REPO_URL/Orbitron-Bold.ttf"
curl -fLo $LOCAL_FONT_DIR/Orbitron-Black.ttf "$REPO_URL/Orbitron-Black.ttf"

fc-cache -fv


# Install resources (bibliography)
# --------------------------------

rm -rf /bib
git clone https://github.com/dmflickinger/RBE550resources.git /bib

# Install assignments template (from local directory)
# ---------------------------------------------------


mkdir -p $(kpsewhich -var-value=TEXMFLOCAL)/tex/latex/RBEassignment/fig
cp -f template/RBEassignment.cls $(kpsewhich -var-value=TEXMFLOCAL)/tex/latex/RBEassignment/
cp -f template/fig/*.png $(kpsewhich -var-value=TEXMFLOCAL)/tex/latex/RBEassignment/fig/



# Register the RBE assignment class with texlive
# ----------------------------------------------

tlmgr conf texmf TEXMFLOCAL $(kpsewhich -var-value=TEXMFLOCAL)
mktexlsr $(kpsewhich -var-value=TEXMFLOCAL)


sed -i -e 's/# en_US.UTF-8 UTF-8/en_US.UTF-8 UTF-8/' /etc/locale.gen
dpkg-reconfigure --frontend=noninteractive locales
update-locale LANG=en_US.UTF-8


# Copy the Makefile to a central location
mkdir -p /usr/local/share/RBEassignment
cp -f template/assignment_builder.mk /usr/local/share/RBEassignment/

