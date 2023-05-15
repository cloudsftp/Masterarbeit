#!/bin/bash

#AnT "../../model.so" -i "configB.ant"
#AnT "../../model.so" -i "configA1.ant"
#AnT "../../model.so" -i "configA2.ant"

gnuplot "plot.plt"

fragmaster
pdfcrop "result.pdf" "result.pdf"
convert -rotate 90 -density 600 -alpha off "result.pdf" "result.png"

imv "result.png"  -f

