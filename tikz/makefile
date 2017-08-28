TARGETS:=$(patsubst %.tex,%.png, $(filter-out preview.tex, $(wildcard *.tex)))

all: $(TARGETS)

%.png: %.pdf
	convert -flatten -density 600 $< $@

%.pdf: %.tex preview.tex
	pdflatex -jobname $* "\input{preview.tex}"
