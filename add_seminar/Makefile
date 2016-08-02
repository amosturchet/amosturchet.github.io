.PHONY: all clean spellcheck 2pg

all: test clean

test: *.txt *.tex *.py
	python make_letter.py
	cp ${ARGS}.txt ${ARGS}.tex
	pdflatex ${ARGS}.tex;
	cp ${ARGS}.pdf ../${ARGS}.pdf
	open ${ARGS}.pdf
clean:
	rm *.aux *.log *.out
