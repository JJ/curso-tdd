# Haciendo buenas revisiones de código


## Planteamiento

En un entorno de desarrollo ágil, es imprescindible hacer buenas revisiones de
código para, por un lado, asegurarse de la calidad del software y, por otro
lado, que se mantenga el buen espíritu de equipo. Como en todo empeño en este
área, hace falta contar con buenas prácticas.

## Al final de esta sesión

El estudiante entenderá cuales osn las prácticas habituales en revisión de
código, algo del vocabulario y, sobre todo, cómo leer el código del resto del
equipo.


## Criterio de aceptación

Que todos los miembros del equipo hayan realizado, al menos, una revisión de
código ajeno.

## El porqué y el cómo de las revisiones de código

Una de las prácticas comúnmente aceptadas en entornos de desarrollo ágil es el
trabajar siempre en ramas, e incorporar sólo a la rama principal siempre que se
cumplan una serie de requisitos. Una parte importante de esos requisitos se
pueden comprobar automáticamente, pero hay otra serie de características del
código que, por lo pronto y si la AI no lo impide, se hacen mejor por parte de
un ser humano.

Lo que se revisa y las posibles modificaciones que se sugieren pueden ser cosas
como:
* Aplicación de buenas prácticas de un manual de estilo de la organización, que
  pueden ir desde el número de columnas de cada línea hasta los nombres de las
  variables. Las características generales de los nombres se pueden comprobar
  fácilmente (si son CamelCase o snake_case, por ejemplo), pero que describan
  correctamente usando los prefijos y sufijos adecuados, es bastante más
  complicado.
* Buenas prácticas que afectan a diferentes ficheros, o diferentes partes de un
  fichero, por ejemplo repeticiones de código (que no estén a continuación una
  de otra), uso de alguna dependencia desaconsejada (o de alguna dependencia
  cuando se desaconseja cualquier tipo de dependencia).
* Por supuesto, ajuste del código (y las pruebas) a las decisiones ya tomadas
  por el equipo, desde las ADR hasta el issue/ticket específico con el que se
  esté trabajando.


## Actividad

Esta sesión correspondería al hito número 6.


## Entrega

