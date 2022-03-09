ALL: doc proyectos

doc: temas/*.md
	cd temas; pandoc --pdf-engine=xelatex --variable mainfont="Open Sans" --variable monofont=DejaVuSansMono  \
	git.md ágil.md aplicaciones.md servicios.md \
	diseño.md organizando.md a-programar.md gestores-tareas.md \
	hacia-tests-unitarios.md tests-unitarios-organización.md tests-unitarios.md \
	CI.md inversión.md cobertura.md integración.md qa.md \
	-o temas.pdf

proyectos: proyectos/*.md
	pandoc proyectos/*.md -o proyectos.pdf
