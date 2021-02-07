ALL: doc proyectos

doc: temas/*.md
	pandoc --pdf-engine=xelatex --variable mainfont="Open Sans" --variable monofont=DejaVuSansMono temas/*.md -o temas.pdf

proyectos: proyectos/*.md
	pandoc proyectos/*.md -o proyectos.pdf
