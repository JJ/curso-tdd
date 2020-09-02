# Calidad en un aplicación desde el diseño.


## Planteamiento

Un producto, en nuestro caso el software, debe estar diseñado y pensado
desde el principio para asegurar que funciona y que responde a todos
los requisitos funcionales y de otro tipo que se hayan planteado. Y
este proceso comienza ne la concepción, cuando se decide qué forma van
a tomar las diferentes capas del producto y cuál va a ser el interfaz
que va a ofrecer al exterior, así como el modo de modularizarlo. Y en
esto se incluye, también, cómo vamos a indicar que se ha producido un error.

Un buen diseño permite captar errores en tiempo de compilación, o en
todo caso dar pistas sobre qué es lo que falla.

## Al final de esta sesión

Los estudiantes habrán diseñado estructuras de datos, módulos y clases
que compilen correctamente y que eviten errores de código durante el
desarrollo de la aplicación o el uso de este código.

## Criterio de aceptación

La clase o funcionalidad debe estar diseñada, aunque sin código, y
debe compilar correctamente.

## Buenas prácticas en el diseño de código.

Durante el ciclo de vida del software, los programas van evolucionando
por muchas razones. Cambian las prácticas, cambian el software sobre
el que se han construido (bibliotecas, lenguajes), se encuentran
errores, cambia la comprensión del problema... Un programa debe
diseñarse de forma que no se rompa (totalmente) con este cambio.

Por ejemplo, la [programación defensiva](https://en.wikipedia.org/wiki/Defensive_programming) trata
de crear código más seguro pero también que sea difícil de *romper*
cuando siga evolucionando.

 En realidad la programación defensiva incluye todas las demás
 prácticas indicadas aquí, desde los principios de diseño, hasta la
 metodología SOLID, hasta otras, pero es más una filosofía que
 consiste en prevenir todos los casos, incluso los imposibles, en el
 diseño de la lógica de negocio o en los tests. Cosas como 

* ¿Funcionará si Internet no está conectada?
* ¿Qué pasa si no hay acceso a almacenamiento permanente?
* Si uso una constante en varios sitios, ¿qué pasa si varían las circunstancias?

Como la programación defensiva es más una filosofía, y una que
deberíamos practicar a lo largo del curso, hay técnicas específicas
que se suelen usar. Por
ejemplo,
[*clean code*](https://medium.com/@sheyiogundijo/clean-code-in-a-nutshell-ac7aa5f80a99) o
código limpio. Una serie de reglas nos invitarán a usar nombres
razonables para las variables, a no repetir código "que ya
modificaremos luego" o que debería ser parametrizado en una sola
pieza, pero lo más importante desde el punto de vista de la calidad
son las siguientes reglas sobre funciones y tipos de datos. 

* Las funciones solo deberían hacer una cosa. Esto es importante desde
el punto de vista de los tests unitarios: probar todas las opciones
posibles de una función que hace un montón de cosas hace que los tests
sean más complicados o incluso imposibles. Además, deberían tener un
número limitado de argumentos, y deberían ser pequeñas, idealmente
visibles en un solo pantallazo (aunque las pantallas de hoy en día
pueden ser muy largas). Una regla es que deberían tener entre 5 y 15
líneas. 
> Evidentemente, aquí también incluimos bloques de código (tales como
> lambdas y cuerpos de bucles) que deberían de ser naturalmente más pequeños, y métodos de clases.

* Los tipos de datos deberían usarse para lo que son. `False` es que
  no es verdadero, no que se ha producido un error dentro de una
  función. `-1` es el resultado de restar 1 a 0, no un índice
  imposible si no se encuentra algo dentro de una lista o cadena. 


### Ejemplo

Añadiendo una nueva clase de mayor nivel, `Project`, con este código:

```
has %!milestones = {};
has Str $!project-name;

submethod BUILD( :$!project-name) {}

method new-milestone( $milestone where $milestone.project-name eq
        $!project-name) {
    %!milestones{$milestone.milestone-id} = $milestone;
}

method milestones() { return %!milestones }

```

Nos *defendemos* usando por ejemplo un hash (`%`) para almacenar los
hitos, y también el nombre de proyecto, en un lenguaje en el que se
usa tipado gradual, va a ser una cadena siempre, eliminando posibles
ambigüedades con cualquier otro tipo de dato.

Llegados a este punto, ya tenemos la entidad con la que vamos a
trabajar. Un proyecto tiene hitos y estos tienen issues, y cuando
trabajemos, lo haremos de esta forma. Según nos lo pidan las historias
de usuario iremos evolucionando, y en ese momento podrá ser necesario
cambiar el modelo en función de lo que necesitemos. 

## A programar

A continuación, hay que ponerse a programar, lo que implica poner a
punto una serie de herramientas y una actitud; lo indicado por 
[Joel on software](https://dev.to/checkgit/the-joel-test-20-years-later-1kjk)
sigue siendo válido después de muchos años: usar siempre control de
fuentes, hacer el build (y finalmente el despliegue) en un solo
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

La mejor forma de empezar con estos issues es crear historias de
usuario razonables. Estas historias de usuario harán que evolucione el
modelo que tenemos de cada entidad y de cada clase que tengamos dentro
de una entidad.

### Ejemplos

En nuestro programa que tratará con los hitos, las acciones comenzarán
siempre con una petición que llegue desde GitHub. Por lo tanto,
podremos tener las siguientes historias de usuario.

* **HU0**: (Configuración) Cada proyecto deberá tener una cadena única
  que lo identifique.
* **HU1**: Cuando se cree un hito en un proyecto, ese hito deberá estar incluido en
  la estructura de datos del proyecto correspondiente.
* **HU2**: Cuando se cree un issue, se añadirá al hito
  correspondiente con estado "abierto". Si no está asignado a ningún hito, se emitirá un
  mensaje de error.
* **HU3**: Cuando se cierre un issue, se cambiará el estado del
  mismo. 
* **HU4**: Si se borra un issue, se eliminará de la estructura de
  datos que los contenga.
* **HU5**: Si se solicita el porcentaje de terminación del hito, se
  responderá con una cantidad entre 0 y 100.

Estas historias de usuario se pueden incluir directamente como hitos,
o agrupar algunas de ellas en un issue. Por ejemplo, en este caso
todas las relativas a issues se pueden incluir en el mismo hito.

A partir de estas historias de usuario, y de la metodología de diseño,
habrá que empezar a escribir el código. Como código no testeado es
código roto, mejor diseñar el API para empezar y más adelante añadir
el código y los tests correspondientes, como hemos visto en el caso
del ejemplo de Python anterior. Pero eso ya será en la
siguiente sesión.

Adicionalmente, una historia de usuario especificará qué hay que hacer
en caso de error. Recordad que el diseño de un módulo debe incluir
también diseño de las clases que se van a usar en caso de error.

* **HU6** Un hito sin issues estará en un estado incorrecto y la única
  operación permisible sobre el mismo es añadirle issues. Si se trata
  de hacer alguna operación sobre el mismo, se emitirá un error de
  tipo. 


## Diseñar los errores también

Los posibles errores y excepciones forman también parte del
vocabulario de una clase. Tener errores
específicos ayuda a que se puedan manejar mejor y es una práctica
*defensiva*: podemos usarla para especificar claramente qué problema
hay. En el diseño de una aplicación se deben tratar de prever todos
los posibles problemas que pueda haber, y crear y tirar excepciones
adecuadas en cada caso. En general, si prevés (dentro de tus historias
de usuario) que haya una situación en la que pueda haber algún estado
inválido, crea una excepción para que se pueda usar en tal situación. 

### Ejemplo

Raku permite la creación de [excepciones específicas](https://rakudocs.github.io/type/Exception). Generalmente
sigue la convención de que se denominan con una `X` seguida del nombre
de la clase a la que se apliquen. Por ejemplo, esta para nuestro
proyecto se llamará `X::Proyecto::NoIssue` y la aplicaremos para el
caso en que no haya ningún issue en un hito: 

```perl6
unit class X::Project::NoIssue is Exception;

method message() {
    "There are no issues"
}
```

Salvo el mensaje específico es prácticamente una declaración en la que se dice que es una excepción y poco más. Podemos modificar alguna de las clases anteriores para que la use:

```perl6
multi method issues() {
    if %!issues {return %!issues}
    else { X::Project::NoIssue.new.throw }
}
```

Si no hay ningún issue, devolver un hash vacío podría ser una solución
*a priori* válida. Sin embargo, eso solo retrasa el tratamiento de una
situación o ambigua o incorrecta al cliente de la clase. Las historias
de usuario pueden estar centradas, por ejemplo, en las estadísticas de
la clase (abiertos/cerrados), pero si no hay ningún issue, la historia
de usuario ni siquiera es aplicable, por lo que es razonable indicar
este hecho mediante una excepción, como estamos haciendo.

En Python, podríamos crear una excepción de esta forma:

```python
class NoIssueException(Exception):
    def __init__(self,*args,**kwargs):
        Exception.__init__(self,"Milestone sin issues")
```

(irá también el fichero `Project/core.py`).

¿Se podría resolver esto forzando directamente a que cuando se cree un
hito tenga que hacerse con algún issue? Atendiendo a las historias de
usuario, es posible que no: un evento de creación de un hito es un
hecho único sin acompañamiento de issues. Así que tratar esto con una
excepción es la mejor forma de defendernos ante los posibles cambios o
evoluciones en el futuro de la misma.



## Actividad

Este es el primer hito en el que vamos a escribir algo de código,
aunque sea sólo el API, es decir, las funciones o métodos, y las
clases, y como llamarlas. Se crearán, por tanto, los esqueletos de las
clases o módulos y se comprobarán que compilan.

En estas clases o módulos se seguirán las mejores prácticas del
lenguaje correspondiente, usando el *layout* de directorios que sea el
aconsejable y se entienda mejor por parte de las herramientas del
lenguaje.

Se añadirán desde el README.md principal enlaces al fichero o ficheros
que se han creado. 

## Entrega

Esta entrega se llevará a cabo, como el resto de las mismas, como un
pull request al fichero de [proyectos](../proyectos.md), tras añadir
en el *fork* propio el nombre del proyecto y un enlace al repo, así
como la versión.

Seguiremos usando 
[versionado semántico para las entregas](https://semver.org/), donde
el primer número será siempre el hito (comenzando por el hito
0). 
