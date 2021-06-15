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

Generalmente, una revisión de código se va a hacer de forma asíncrona, como
  comentarios en un repositorio. GitHub (y GitLab) permiten añadir comentarios
  en la línea que se ha añadido, o en general en cualquier línea alredor del
  mismo. Con el contexto correcto, es más fácil entender qué es lo que se desea,
  aunque también se puede añadir como comentario general una priorización de los
  diferentes cambios sugeridos, por ejemplo.

En general, y sobre todo en entornos empresariales, todo PR estará listo para
pasar. Si ha pasado todos los tests y se presentan defectos importantes, el
problema no es del PR, es del sistema de calidad: no hay tests de calidad de
código suficientes, no están claros los estándares que se siguen o simplemente
no está claro qué es lo que hay que hacer. En entornos open source es bastante
común esto, sin embargo; a veces no hay hoja de ruta, se solicita incorporar una
nueva característica, o simplemente es una colaboración espontánea. En estos
casos se aconseja que se cree una [plantilla de pull
request](https://docs.github.com/es/communities/using-templates-to-encourage-useful-issues-and-pull-requests/creating-a-pull-request-template-for-your-repository),
un fichero Markdown en el repositorio que tiene pre-rellenos una serie de
requisitos.

Esta plantilla nunca viene mal, incluso en entornos empresariales. Por ejemplo,
que quede claro con qué épica/issue se está trabajando (incluso aunque sea
externo a GitHub), y permite a quien revisa estar en el marco correcto para
poder evaluar el trabajo.

En cuanto a cuanta gente debe revisar el código, cuanta más mejor, como es
natural, aunque poner muchas personas puede acabar por paralizar la
incorporación de código. Una persona mínimo, pero dos personas son ideales, 



## Actividad

Esta sesión correspondería al hito número 6.


## Entrega

