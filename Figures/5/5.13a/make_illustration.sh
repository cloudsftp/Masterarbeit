#!/bin/bash

gnuplot illustration.plt

fragmaster
pdfcrop illustration.pdf illustration.pdf
convert -rotate 90 -density 600 -alpha off illustration.pdf illustration.png
