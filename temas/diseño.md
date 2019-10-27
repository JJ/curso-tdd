# Diseño de una aplicación


## Planteamiento

En general, la calidad es un proceso, y no simplemente una
característica que se añade en un momento determinado al producto. El
producto, en nuestro caso el software, debe estar diseñado y pensado
desde el principio para asegurar que funciona y que responde a todos
los requisitos funcionales y de otro tipo que se hayan planteado.

Por eso, en un curso principalmente dedicado al diseño de tests se
debe partir del planteamiento de la propia 
aplicación o biblioteca, porque se realizan pruebas sobre las
especificaciones de la aplicación, no se puede quedar en la sintaxis y
una enumeración de los frameworks disponibles.

## Al final de esta sesión

Los estudiantes sabrán como plantear una aplicación a partir de sus
especificaciones y comenzar la implementación de forma que probar estas
especificaciones sea sencilla y directa. También sabrán como plasmar
en plataformas de desarrollo colaborativo estos requisitos para llevar
a cabo el desarrollo de la aplicación. 

## Criterio de aceptación

El proyecto tendrá una serie de hitos e issues creados

* Todos los issues estarán en un hito
* Todos los commits se referirán a un issue.
* Los issues se habrán cerrado siempre con un commit.

## Diseño dirigido por dominio

Una vez decidido el foco principal del proyecto, el diseño debe
descender hasta un nivel en el que pueda ser abordable mediante la
programación del mismo. "Divide y vencerás" nos permite trabajar con
entidades que son autónomas entre sí, y que se pueden programar y
testear de forma independiente. Una de las técnicas más conocidas es
el [diseño dirigido por el dominio](https://en.wikipedia.org/wiki/Domain-driven_design) 

Aunque, como todas las tecnologías de programación, es compleja en
vocabulario y metodología, lo principal es que se deben de crear
modelos del dominio del problema limitados en su contexto, de forma
que sea sencillo dividir el proceso de implementación en equipos, cada
uno de ellos responsables de una parte del diseño. La integración
continua (y los tests correspondientes), permitirán que se asegure la
calidad del producto resultante.

Los dos conceptos principales, desde el punto de vista de la
programación, son el de *entidad* y el de *objeto-valor*. Una entidad
mantiene su identidad a lo largo del ciclo de vida; in objeto-valor es
simplemente un valor asignado a un atributo. Los *agregados*
integrarán y encapsularán una serie de objetos, creando un API común
para todos ellos.


## 12 Factor

## SOLID.

## Buenas prácticas en el diseño de código.

Durante el ciclo de vida del software, los programas van evolucionando
por muchas razones. Cambian las prácticas, cambian el software sobre
el que se han construido (bibliotecas, lenguajes), se encuentran
errores, cambia la comprensión del problema... Un programa debe
diseñarse de forma que no se rompa (totalmente) con este cambio.

Por ejemplo, la [programación defensiva](https://en.wikipedia.org/wiki/Defensive_programming) trata
de crear código más seguro.

 En realidad la programación defensiva incluye todas las demás prácticas indicadas aquí, desde los principios de diseño, hasta la metodología SOLID, hasta otras, pero es más una filosofía que consiste en prevenir todos los casos, incluso los imposibles, en el diseño de la lógica de negocio o en los tests. Cosas como

* ¿Funcionará si Internet no está conectada?
* ¿Qué pasa si no hay acceso a almacenamiento permanente?
* Si uso una constante en varios sitios, ¿qué pasa si varían las circunstancias?

Como la programación defensiva es más una filosofía, y una que deberíamos practicar a lo largo del curso, hay técnicas específicas que se suelen usar. Por ejemplo, [*clean code*](https://medium.com/@sheyiogundijo/clean-code-in-a-nutshell-ac7aa5f80a99) o código limpio. Una serie de reglas nos invitarán a usar nombres razonables para las variables, a no repetir código "que ya modificaremos luego" o que debería ser parametrizado en una sola pieza, pero lo más importante desde el punto de vista de la calidad son las siguientes reglas sobre funciones y tipos de datos.

* Las funciones solo deberían hacer una cosa. Esto es importante desde el punto de vista de los tests unitarios: probar todas las opciones posibles de una función que hace un montón de cosas hace que los tests sean más complicados o incluso imposibles. Además, deberían tener un número limitado de argumentos, y deberían ser pequeñas, idealmente visibles en un solo pantallazo (aunque las pantallas de hoy en día pueden ser muy largas). Una regla es que deberían tener entre 5 y 15 líneas.
> Evidentemente, aquí también incluimos bloques de código, que deberían de ser naturalmente más pequeños, y métodos de clases.

* Los tipos de datos deberían usarse para lo que son. `False` es que no es verdadero, no que se ha producido un error dentro de una función. `-1` es el resultado de restar 1 a 0, no un índice imposible si no se encuentra algo dentro de una lista o cadena. 

## A programar

A continuación, hay que ponerse a programar, lo que implica poner a
punto una serie de herramientas y una actitud; lo indicado por 
[Joel on
software](https://dev.to/checkgit/the-joel-test-20-years-later-1kjk)
sigue siendo válido después de muchos años: usar siempre control de
fuentes, hacer el build (y eventualmente el despliegue) en un solo
paso, priorizar arreglar los bugs. 

Pero en todo caso, lo más importante es la planificación que se va a
llevar a cabo antes de aprobar. Los sistemas de control de fuentes
modernos incluyen un sistema de organización del trabajo usando
*issues* e *hitos*. Los issues son órdenes de trabajo, los hitos los
agrupan creando un punto de control de forma que no se puede ir hacia
adelante hasta que no se terminen todos los issues de un hito. Lo más
importante desde el punto de vista de la organización del trabajo es
que cuando se trabaje, esté claro en qué contexto se hace y se haga
contra un issue, refiriéndose a él en el commit (preferiblemente en la
primera línea del mismo). Todos los issues, a su vez, deben estar en
un hito. 

## Actividad

Esencialmente, en esta primera fase se llevarán a cabo las actividades
de diseño para el resto del curso.

1. Elegir un proyecto o un equipo o las dos cosas a la vez, y crear un
   repositorio 
   [usando esta plantilla](https://github.com/JJ/curso-qa-template). 
   1. Solicitar el acceso a la beta de [GitHub Actions](https://github.com/features/actions) para que se pueda
      usar en el repo.
	  
2. Elaborar una cantidad aceptable de historias de usuario y crear a
   partir de ellas una serie de issues en GitHub. Los hitos deberán
   estar relacionados con estas historias de usuario.
   
3. Describir en el README.md el microservicio que se va a crear,
   explicando las tecnologías que se van a usar en el mismo.
