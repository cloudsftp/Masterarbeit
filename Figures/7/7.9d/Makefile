picture=result
png_DPI=600

$(picture).png: plot.plt Makefile $(picture)_fm
	gnuplot plot.plt
	fragmaster
	pdfcrop $(picture).pdf $(picture).pdf
	convert -rotate 90 -density $(png_DPI) -alpha off $(picture).pdf $(picture).png

clean:
	\rm -f *.eps *.pdf *~
