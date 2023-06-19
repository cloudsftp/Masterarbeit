picture=adding
png_DPI=600

$(picture).png: $(picture).tex Makefile
	pdflatex $(picture).tex
	pdfcrop $(picture).pdf $(picture).pdf
#	convert -rotate 90 -density $(png_DPI) $(picture).pdf $(picture).png

