ALL: doc

doc: proyectos/*.md
	pandoc proyectos/*.md -o proyecto.pdf
