picture=schema
png_DPI=600

$(picture).png: $(picture).tex Makefile
	pdflatex $(picture).tex
	pdfcrop $(picture).pdf $(picture).pdf
	pdftoppm -png -r $(png_DPI) $(picture).pdf > $(picture).png

