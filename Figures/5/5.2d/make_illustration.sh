#!/bin/bash

python model.py --start 0 --end 6.28 --resolution 30000 --E0 15 --hi 0.128 --mu 0.5 > model1.dat
python model.py --start 0 --end 6.28 --resolution 30000 --E0 16.4 --hi 0.2 --mu 0.5 > model2.dat

gnuplot illustration.plt

fragmaster
pdfcrop illustration.pdf illustration.pdf
convert -rotate 90 -density 600 -alpha off illustration.pdf illustration.png
