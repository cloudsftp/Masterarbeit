picture=bif
png_DPI=600

$(picture).png: work.plt Makefile $(picture)_fm
	gnuplot work.plt
	fragmaster
	pdfcrop $(picture).pdf $(picture).pdf
	convert -rotate 90 -density $(png_DPI) -alpha off $(picture).pdf $(picture).png

clean:
	\rm -f *.eps *.pdf *~
	gzip *.tna

