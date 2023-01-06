picture=bif
png_DPI=600

$(picture).png: work.plt Makefile $(picture)_fm
	gnuplot work.plt
	fragmaster
#	psnup -l $(picture).eps $(picture)_90.eps
	pdfcrop $(picture).pdf $(picture).pdf
	convert -rotate 90 -density $(png_DPI) -alpha off $(picture).pdf $(picture).png

clean:
	\rm -f *.eps *.pdf *~
	gzip *.tna


eps: $(picture).pdf
	/usr/bin/pdfjam --suffix rotated90 --angle '270' --fitpaper 'true' --rotateoversize 'true' -- $(picture).pdf -
	pdf2ps $(picture)-rotated90.pdf 
	ps2eps $(picture)-rotated90.ps
	mv -f $(picture)-rotated90.eps $(picture).eps 
	\rm -f *rotated90*make 
