picture=result
png_DPI=600

$(picture).png: plot.plt Makefile $(picture)_fm period.tna
	gnuplot plot.plt
	fragmaster
	pdfcrop $(picture).pdf $(picture).pdf
	convert -rotate 90 -density $(png_DPI) -alpha off $(picture).pdf $(picture).png

period.tna: samples.dat config.ant
	AnT ../model.so -i config.ant

samples.dat: gen-samples/src/main.rs
	cd gen-samples && cargo run > ../samples.dat

clean:
	\rm -f *.eps *.pdf *~
	gzip *.tna

