picture=result
png_DPI=600

$(picture).png: plot.plt Makefile $(picture)_fm \
	Data/0/symbolic_regions.tna Data/1/symbolic_regions.tna \
	Data/2/symbolic_regions.tna Data/3/symbolic_regions.tna
	
	gnuplot plot.plt
	fragmaster
	pdfcrop $(picture).pdf $(picture).pdf
	convert -rotate 90 -density $(png_DPI) -alpha off $(picture).pdf $(picture).png

clean:
	\rm -f *.eps *.pdf *~
	gzip *.tna

