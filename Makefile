
output:
	tectonic main.tex

all: code output

code:
	cat ./code/t*.sql > code.tex
	sed -i "s/--- //g" code.tex
	sed -i '1 i\\\begin{enumerate}' code.tex
	printf '\\end{enumerate}\n' >> code.tex

minted:
	tectonic main.tex -Z shell-escape-cwd=${PWD}

clean:
	rm -f main.aux main.log main.pyg main.xdv main.out

.PHONY: clean code

