#!/bin/bash

python model.py --start 0 --end 6.28 --resolution 30000 --E0 15.9 --hi 0.11 --mu 0.5 > model1.dat
python model.py --start 0 --end 6.28 --resolution 30000 --E0 17.07 --hi 0.182 --mu 0.5 > model2.dat
python model.py --start 0 --end 6.28 --resolution 30000 --E0 18.5 --hi 0.27 --mu 0.5 > model3.dat

gnuplot illustration.plt

fragmaster
pdfcrop illustration.pdf illustration.pdf
convert -rotate 90 -density 600 -alpha off illustration.pdf illustration.png
