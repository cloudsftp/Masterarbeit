#!/bin/bash

gnuplot plot.plt

fragmaster
pdfcrop result.pdf result.pdf
convert -rotate 90 -density 600 -alpha off result.pdf result.png
