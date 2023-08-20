picture=result
png_DPI=600

$(picture).png: plot.plt Makefile $(picture)_fm cyclic_cobweb_B1.tna cyclic_cobweb_B2.tna
	gnuplot plot.plt
	fragmaster
	pdfcrop $(picture).pdf $(picture).pdf
	convert -rotate 90 -density $(png_DPI) -alpha off $(picture).pdf $(picture).png

cyclic_cobweb_%.tna: config_%.ant
	AnT ../../model.so -i $<

clean:
	\rm -f *.eps *.pdf *~
