picture=result
dpi=600

$(picture).png: plot.plt result_fm
	gnuplot plot.plt
	fragmaster
	pdfcrop $(picture).pdf $(picture).pdf
	convert -rotate 90 -density $(dpi) -alpha off "$(picture).pdf" "$(picture).png"

model_lib=../../model.so

cyclic_cobweb%.tna: config%.ant
	AnT $(model_lib) -i $<
