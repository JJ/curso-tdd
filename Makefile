ALL: doc proyectos

doc: temas/*.md
	pandoc --pdf-engine=xelatex --variable mainfont="Open Sans" --variable monofont=DejaVuSansMono  \
	temas/git.md temas/ágil.md temas/aplicaciones.md temas/servicios.md \
	temas/diseño.md temas/organizando.md temas/a-programar.md temas/gestores-tareas.md \
	temas/hacia-tests-unitarios.md temas/tests-unitarios-organización.md temas/tests-unitarios.md \
	temas/CI.md temas/inversión.md temas/cobertura.md temas/integración.md temas/qa.md \
	-o temas.pdf

proyectos: proyectos/*.md
	pandoc proyectos/*.md -o proyectos.pdf
