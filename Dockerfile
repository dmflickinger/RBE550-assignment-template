FROM fedora as intermediate
# Build an intermediate container to pull in RBE resources files

RUN dnf install -y git \
                   git-lfs \
    && dnf clean all

WORKDIR /src
RUN mkdir -p /src

RUN git clone https://github.com/dmflickinger/RBE550resources.git






FROM fedora




# Install packages (mainly texlive)
# =================================

RUN dnf install -y texlive-adjustbox \
                   texlive-background \
                   texlive-bibtex \
                   texlive-biblatex \
                   texlive-biblatex-ieee \
                   texlive-ccfonts \
                   texlive-changepage \
                   texlive-chktex \
                   texlive-comfortaa \
                   texlive-datetime \
                   texlive-datetime2 \
                   texlive-dot2texi \
                   texlive-draftwatermark \
                   texlive-droid \
                   texlive-electrum \
                   texlive-epigraph \
                   texlive-euro-ce \
                   texlive-fontawesome \
                   texlive-fontawesome5 \
                   texlive-collection-fontsrecommended \
                   texlive-fourier \
                   texlive-ifmtarg \
                   texlive-inconsolata \
                   texlive-kpfonts \
                   texlive-lastpage \
                   texlive-listing \
                   texlive-makecmds \
                   texlive-mathdots \
                   texlive-mathspec \
                   texlive-mdframed \
                   texlive-metafont \
                   texlive-minted \
                   texlive-mnsymbol \
                   texlive-multirow \
                   texlive-pdfcrop \
                   texlive-pgfgantt \
                   texlive-pgfopts \
                   texlive-pygmentex \
                   texlive-roboto \
                   texlive-sectsty \
                   texlive-siunitx \
                   texlive-smartdiagram \
                   texlive-sourcecodepro \
                   texlive-subfigmat \
                   texlive-svg \
                   texlive-titlesec \
                   texlive-titling \
                   texlive-tocloft \
                   texlive-todonotes \
                   texlive-wrapfig \
                   texlive-xifthen \
                   texlive-xtab \
                   texlive-xetex \
                   texlive-beamer \
                   texlive-nextpage \
                   texlive-fancybox \
                   texlive-algorithm2e \
                   texlive-progressbar \
                   graphviz \
                   make \
                   ossobuffo-jura-fonts \
                   python3-pygments \
                   python3-pygments-style-solarized \
                   which \
    && dnf clean all


RUN mkdir -p /source \
    && mkdir -p /output \
    && mkdir -p /bib \
    && mkdir -p /usr/local/share/LaTeX_templates/RBE550_assignment/fig

COPY fig/*.png /usr/local/share/LaTeX_templates/RBE550_assignment/fig/
COPY template/*.tex /usr/local/share/LaTeX_templates/RBE550_assignment/
COPY scripts/build.sh /usr/local/bin/

COPY --from=intermediate /src/RBE550resources/RBE_resources.bib /bib

WORKDIR /source

ENTRYPOINT [ "/usr/local/bin/build.sh" ]


VOLUME [ "/source" "/output" ]
