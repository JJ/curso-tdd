# Tareas para el curso de programación ágil

## fatpack

> Crea el fichero de test a partir de la fuente

~~~sh
fatpack pack src/proyecto.t > t/proyecto.t
~~~

## asistencia

> Genera el csv de asistencia a partir de los ficheros (fuera del repo)

~~~sh
raku ejemplos/raku/scripts/asistencia.raku > data/asistencia.csv
~~~

## doc

> Genera un solo fichero con todos los temas (via Makefile)

~~~sh
make doc
~~~
