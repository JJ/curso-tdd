# Resolviendo problemas usando aplicaciones informáticas.


## Planteamiento

La gama de posibles "productos" que se pueden generar para resolver un
problema informático es muy amplia, casi tanto como la variedad de
dispositivos y sistemas sobre los que se puede desplegar. En este
(breve) tema veremos todas las posibilidades que hay, y qué nos puede
hacer elegir una u otra.

## Al final de esta sesión

Se conocerán diferentes posibilidades para publicar aplicaciones
informáticas, y se tendrán elementos de juicio para elegir una u otra.

## Criterio de aceptación

El equipo tendrá que decidirse por un problema que resolver, y decidir
qué forma va a tomar esa solución.

## La informática trata de resolver problemas usando sistemas informáticos

Esto, que puede parecer obvio, queda en el olvido totalmente en un
sistema de enseñanza de la informática compartimentalizado en el que
para empezar sólo se enfocan partes de un problema, y para seguir sólo
se explican herramientas específicas, exigiéndose saber cómo funcionan
esas herramientas antes que ayudar a resolver el problema de esa
forma. Con una asignatura que, por ejemplo, desarrolla un paradigma de
programación y que, a continuación, usa dos lenguajes de programación,
el foco de la misma se desplaza de los conceptos y técnicas generales
de programación a aprender la sintaxis de esos dos lenguajes. El foco
principal, que debería de ser la resolución de problemas, queda
totalmente olvidado.

Cuando se llega a los últimos cursos de informática, todo lo que sabe
hacere el estudiante medio es "voy a hacer un programa del tipo (o dos
tipos) que he aprendido que use el lenguaje X y framework Y", donde
tanto X como Y están entre la gama muy estrecha que se ha definido en
los cursos anteriores, o ni siquiera eso, en los cursos anteriores y
*no se odia*.

En ingeniería informática, sin embargo, se debe de estar dispuesto a
resolver cualqueir problema que se presente, usando soluciones de
software, y en algunos casos también de hardware. Estas soluciones se
diseñarán en forma de capas de abstracción que faciliten su evolución,
pero también, por supuesto, sus pruebas. Una vez más, la calidad es un
proceso y no algo que se añade al producto; el asegurar la calidad de
un producto debe partir desde las herramientas usadas (como `git`, que
se vio en el primer tema) hasta la metodología de diseño o la
arquitectura general que se va a usar.

En este capítulo vamos a tratar de hacer una pequeña panorámica de la
arquitectura de una aplicación informática, con "aplicación" siendo un
término vago que abarca todo producto informático que pueda ser
publicado. Empezamos por lo más bajo, el módulo.

## Módulos

Todos los lenguajes de programación son modulares, es decir, permiten
dividir una aplicación en diferentes partes, cada una de las cuales
provee una funcionalidad específica y consiste, en sí, una capa de
abstracción (un lenguaje) sobre la funcionalidad que incluye.

Diferentes paradigmas de programación llamarán a estos módulos de
forma diferente. En programación dirigida a objetos habrá interfaces,
roles o clases; en lenguajes procedurales o funcionales se les llamará
módulos o paquetes, pero en cualquier caso siempre habrá dos
componentes principales

* Una estructura de datos, que no será explícita en el caso de los
  lenguajes dirigidos a objetos (sino atributos en una clase), o sí en
  en caso de lenguajes procedurales.
  
* Un API o interfaz de aplicación, que servirá para abstraer esa
  estructura de datos y poder hacer cosas específicas con ellas.
  
Modelizar esta estructura de datos de forma que se corresponda al
dominio del problema es una de las tareas más importantes en el diseño
de una aplicación; pero desde nuestro punto de vista lo importante es
que este módulo, en sí, puede ser una *aplicación*, porque resuelva el
problema (de forma limitada, claro). Un módulo se puede publicar en
los repositorios del lenguaje si cumple las normas para el mismo.

> Evidentemente, un sólo módulo rara vez es una solución, en muchos
> casos habrá que crear toda una jerarquía o grupo interdependiente de
> los mismos, pero al final, habrá siempre un módulo en la capa más
> alta de abstracción que sea la solución al problema.




## Actividad

En esta fase se decidirá el proyecto entre los que se han planteado, o
de forma totalmente original. El proyecto en sí y qué va a ser (entre
los tipos de aplicaciones mostradas antes) se añadirá al README; 


## Entrega

Esta entrega se llevará a cabo, como el resto de las mismas, como un
pull request al fichero de [proyectos](../proyectos.md), tras añadir
en el *fork* propio el nombre del proyecto y un enlace al repo, así
como la versión. Recordad que se usa versionado semántico.

