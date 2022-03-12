#!/bin/bash

podman run -it --rm -v .:/source -v ./output:/output -v ../../RBE550_resources:/bib rbe550assignment_template
