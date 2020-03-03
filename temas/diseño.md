# Calidad en un aplicación desde el diseño.


## Planteamiento

En nuestro contexto, se define [la calidad del software](https://en.wikipedia.org/wiki/Software_quality) como la capacidad del mismo se seguir (o exceder) las especificaciones y las expectativas de los usuarios del mismo. 

En general, la calidad es un proceso, y no simplemente una
característica que se añade en un momento determinado al producto. Por eso el
producto, en nuestro caso el software, debe estar diseñado y pensado
desde el principio para asegurar que funciona y que responde a todos
los requisitos funcionales y de otro tipo que se hayan planteado.

Por eso, en un curso principalmente dedicado al diseño de tests se
debe partir del planteamiento de la propia 
aplicación, componente o biblioteca, porque se realizan pruebas sobre las
especificaciones de la aplicación, y no se puede quedar en la sintaxis y
una enumeración de los frameworks disponibles para hacer tests.

## Al final de esta sesión

Los estudiantes sabrán como plantear una arquitectura básica de aplicación a partir de sus
especificaciones y comenzar la implementación de forma que hacer pruebas sobre  esas
especificaciones sea sencillo y directo. También sabrán como plasmar
en plataformas de desarrollo colaborativo estos requisitos para llevar
a cabo el desarrollo de la aplicación.

## Criterio de aceptación

El proyecto tendrá una serie de hitos e issues creados

* Todos los issues estarán en un hito
* Todos los commits se referirán a un issue.
* Los issues se habrán cerrado siempre con un commit.
* Deberá haber documentos de una o varias historias de usuario en un
  directorio `HU`.

Con esto se probará que se están siguiendo los principios de diseño desarrollando a partir de casos de uso.

## Diseño dirigido por dominio

Una vez decidido el foco principal del proyecto, el diseño debe
descender hasta un nivel en el que pueda ser abordable mediante la
programación del mismo. "Divide y vencerás" nos permite trabajar con
entidades que son autónomas entre sí, y que se pueden programar y
testear de forma independiente. Una de las técnicas más conocidas es
el [diseño dirigido por el dominio](https://en.wikipedia.org/wiki/Domain-driven_design).

Aunque, como todas las tecnologías de programación, es compleja en
vocabulario y metodología, lo principal es que se deben de crear
modelos de partes del dominio del problema limitados en su contexto, de forma
que sea sencillo dividir el proceso de implementación en equipos, cada
uno de ellos responsables de una parte del diseño. La integración
continua (y los tests correspondientes), permitirán que se asegure la
calidad del producto resultante.

Los dos conceptos principales, desde el punto de vista de la
programación, son el de *entidad* y el de *objeto-valor*. Una entidad
mantiene su identidad a lo largo del ciclo de vida; un objeto-valor es
simplemente un valor asignado a un atributo. Los *agregados*
integrarán y encapsularán una serie de objetos, creando un API común
para todos ellos.

Eventualmente, una entidad se convertirá en un módulo cuando se vaya a
implementar en el lenguaje de progrmación en el que decidamos
hacerlo. Todos los lenguajes de programación modernos son modulares,
con módulos agrupando funcionalidad relacionada, pero dependiendo del
lenguaje, una entidad y un objeto valor será una clase, un rol, un
módulo o paquete, o simplemente un fichero con una serie de funciones
y convenciones para ser llamadas juntas. La mayoría de los módulos
generan un *espacio de nombres*, que refleja también la jerarquía de
los mismos; este espacio de nombres a veces se refleja en el nombre
del módulo, a veces en el camino donde está almacenado.

> Por ejemplo, en Raku un módulo llamado My::Project estará almacenado
> en `lib/My/Project.pm6' y podrá tener otros módulos llamados
> My::Project::Issue que estará almacenado en
> `lib/My/Project/Issue.pm6`. En el caso de Python, un módulo que se
> llame Project estará definido en `Project/core.py` (y en el
> directorio `Project` tendrá que haber un fichero `__init__.py`. El
> otro fichero mencionado estará en `Project/Issue.py`. 

Este tipo de consideraciones tendremos que tenerlas en cuenta a la
hora de diseñar los ficheros en los que se va a almacenar nuestra
aplicación o proyecto; los nombres de los ficheros y la estructura de
directorios debe seguir las buenas prácticas habituales y reflejar la
estructura del mismo.

El primer paso para entender cuales son las diferentes entidades y
objetos-valor en nuestro problema es crear una serie de *casos de uso*
o *historias de usuario* que nos aquilaten el dominio del problema y
nos permitan trabajar con él. 

### Ejemplo

> Una aplicación nos va a permitir controlar el avance de los
> diferentes proyectos de este curso. Mediante un *hook* de GitHub,
> todos los proyectos informarán a un sitio central de sus
> actividades. Nos interesará sobre todo saber en qué hito está cada
> proyecto y en qué estado de consecución está cada uno de esos
> hitos. El objetivo es, por ejemplo, mantener un *leaderboard* en
> tiempo real que liste los proyectos por consecución, o mantener una
> historia del mismo. 

Vamos a ver qué historias de usuario saldrán de aquí:

* El usuario querrá estar informado en todo momento del estado de cada uno de los proyectos.

Realmente el resto son temas de presentación. Lo importante es que
tenemos una entidad, el *proyecto*. Cada proyecto tiene identidad
propia, es decir que será un solo objeto que irá mutando de estado a lo largo del tiempo. El *agregado* integrará en un solo API acceso al estado de todos los proyectos, y el resto (hitos e *issues*) serán objetos-valor, sin ningún tipo de existencia fuera del contexto de un proyecto. Tendremos, por lo tanto, una sola entidad, la clase `Proyecto`. Los objetos valor, `Hito` e `Issue` también serán clases, pero no existen si no es dentro del contexto de un proyecto, por lo que los mantendremos así.

¿Cumple esta entidad nuestra historia de usuario? En principio sí,
pero evidentemente se puede evolucionar durante el desarrollo de la
aplicación esta historia. Lo importante es que, inicialmente, lo cumpla.

Por ejemplo, un `Issue` puede ser así:

```raku
enum IssueState <Open Closed>;

unit class Project::Issue;

has IssueState $!state = Open;
has Str $!project-name;
has UInt $!issue-id;

method close() { $!state = Closed }
method reopen() { $!state = Open }
method state( --> IssueState ) { return $!state }
```

Frente a todas las operaciones posibles, usamos solo las que debemos para este objeto en particular.

> Todo el código de este curso irá en el subdirectorio
> [`code`](../code) de este repositorio. En este caso en el subdirectorio `raku`. 

En general, tendremos varias entidades en cada uno de los proyectos. En particular, los proyectos planteados aquí se podrán resolver con una sola.

Estamos hablando de TDD y estamos poniendo código antes de
 especificar los tests. Si seguimos una metodología TDD estricta,
 deberíamos especificar los tests antes del mismo. Este código, de
hecho, debería fallar antes de que se escriban los tests. Así que
vamos a aprovecharlo para introducir código de otro lenguaje, Python
(en el subdirectorio [`ejemplos/python`](../ejemplos/python) escrito
con este tipo de ideas en mente. El código muestra solamente las
funciones que deseamos que esta entidad siga:

```
class Project:

    def newMilestone(self, milestone):
        pass;

    def milestones(self):
        pass

    def percentageCompleted(self):
        pass

    def completionSummary(self):
        pass

    def data(self):
        pass

    def projectName(self):
        pass
```
                                         
En ese ejemplo las funciones sólo hacen `pass`. Los tests, por fuerza,
no pasarán.


## 12 Factor

La metodología de los [12 factores](https://12factor.net/es/) se puede
usar a continuación de la fase de diseño, para plantear toda la
instrumentación necesaria para llevar a cabo el proyecto. Este tipo de
metodología, además, está adaptada al uso de aplicaciones nativas en
la nube porque en ella se propone desarrollar simultáneamente la
infraestructura, el código y los tests. Desde el punto de vista de la
calidad, dos de esos factores, guardar la configuración en el entorno
y declarar y aislar las dependencias contribuyen a que la aplicación
sea más fácil de testear y desarrollar. Esto lo podemos hacer antes de
aplicar otra metodología de diseño, que veremos a continuación.

### Ejemplo

En el caso de nuestra aplicación, por lo pronto, no tenemos más
dependencia que el lenguaje de programación que vamos a usar,
Raku. Más adelante tendremos que especificar el resto de las
dependencias, pero mientras tanto, en el fichero `META6.json`, que es
el fichero de metadatos para distribuciones en Raku, bibliotecas o
aplicaciones, se
especifican todos los módulos de los que esta aplicación va a
depender. 

Las dependencias las especificaremos siempre usando código (y bajo
control de versiones), y por tanto distinguiremos entre varios tipos

* El lenguaje y versión del mismo con el que vayamos a trabajar. Esto se especifica en los metadatos del proyecto (en el fichero correspondiente) o de alguna otra forma, como ficheros específicos. En nuestro caso usamos `META6.json`, y declaramos la versión de Raku (6.*) que vamos a usar.

* Dependencias externas. Lo mejor es usar una herramienta de
  construcción para que, con un simple `make install`, se puedan
  instalar todas. Usar un Dockerfile o una receta Ansible también
  ayudará; también existe un sistema general de especificación de
  dependencias para cualquier lenguaje
  llamado [Nix](https://nixos.org/nix/). 

* Dependencias del propio lenguaje. En este caso, un fichero de
  metadatos será suficiente para especificarlo. 

## SOLID

Los principios [SOLID](https://es.wikipedia.org/wiki/SOLID)
constituyen también una metodología de desarrollo de software que
encaja bien con las metodologías usadas en las fases anteriores. Pero
desde nuestro punto de vista nos interesan dos especialmente, para el
diseño completo de la arquitectura de la aplicación:

* [Principio de la responsabilidad única](https://en.wikipedia.org/wiki/Single_responsibility_principle): las *entidades* de las que hablamos anteriormente tienen un contexto autónomo, y por tanto las programaremos en una clase, grupo de clases y eventualmente microservicio que se encargue exclusivamente de una sola entidad. Este principio se resume en que "debería haber una sola razón para cambiar una entidad": diferentes razones, diferentes responsabilidades.

* [Principio de la inversión de dependencias](https://en.wikipedia.org/wiki/Dependency_inversion_principle) (o
   inversión del control): *se debe depender de cosas abstractas, no concretas*. Es decir, la dependencia de una clase debe ser de un almacén de datos, no de una base de datos concreta, y el almacén de datos debe *inyectarse* en la clase cuando se vaya a crear.

### Ejemplo

Dividiremos las entidades en diferentes clases que tengan una
responsabilidad única. La clase expuesta anteriormente se encargará
solo y exclusivamente de los issues. Tendremos otra clase para los
hitos o *milestones*, una como esta

```perl6
use Project::Issue;

unit class Project::Milestone;

has UInt $!milestone-id;
has %!issues = ();
has Str $!project-name;

submethod BUILD( :$!milestone-id, :$!project-name) {}

method new-issue( Project::Issue $issue where $issue.project-name eq $!project-name) {
    %!issues{$issue.issue-id} = $issue;
}

proto method issues( | ) { * }
multi method issues() { return %!issues }
multi method issues( IssueState $state ) {
    return %!issues.grep: *.value.state eq $state
}
```

La única responsabilidad de esta clase es encargarse de los hitos, y
operaciones agregadas sobre ellos. Si hay que calcular el número de
hitos abiertos, delega en el propio issue, que sabe si está abierto o
no. La clase se encargará de albergar los issues y darnos los issue en
un estado determinado.

En este código, además, se usan todas las buenas prácticas para que sea lo más compacto posible, y es (si conoces el lenguaje) auto-descrito. Por ejemplo, se usa un solo nombre para recuperar los issues y *dispatch* múltiple para seleccionar lo que se llama, o se capturan los posibles errores de ejecución en la propia signatura del método, en vez de usar un detector. 

> Hay una posible ambigüedad que estamos resolviendo por las bravas:
> si hay un issue con un número y se vuelve a asignar, el nuevo
> sustituye al viejo. Siempre que quede claro y esté testeado, no
> tiene por qué haber problema.

En este caso no estamos usando ningún sistema de almacenamiento, pero
estamos desacoplando el modelo del sistema real. A un nivel superior
tendremos que introducir el sistema que decida de dónde se leen esos
issues e hitos. Este desacoplamiento es esencial, y ayuda desde el
diseño a hacer más adelante la inyección de dependencias.

El principio de la responsabilidad única indica también que sólo debe
haber
[una razón para que un objeto de una clase cambie](http://geekswithblogs.net/TimothyK/archive/2014/06/11/dry-and-srp.aspx). Si
un objeto de una clase está compuesto a su vez de objetos de otras
clases, el que cambie uno de las clases incluidas va a provocar que el
objeto de la clase anfitrión cambie sin saberlo, provocando *acción a
distancia*. Además, el principio de inyección de dependencias vendría
a decir que todos los objetos que cambien necesitarán su propia
*inyección* para cambiar. Por eso todo esto junto implica que, en
clases compuestas, va a haber objetos de una sola que se
responsabilicen de cambiar el estado de los objetos: el objeto sólo va
cambiar si se ejecuta una orden que haga que cambie, no si un objeto
de otra clase ejecuta una orden.

### Ejemplo

En el caso del proyecto, sólo el objeto Project será responsable de
cambiar el estado del resto de los proyectos, respaldando el cambio
con una sóla fuente de verdad (Single Source of Truth, SSOT), que
estará en el almacén de datos elegido. Sólo se inyectará la
dependencia en la clase que vaya a mutar al resto de las
clases. También esta única fuente de verdad estará relacionada con la
única entidad de la que hablamos en domain driven design, al
principio, mientras que el resto de las clases serán simplemente
objetos valor.

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
o agrupar algunas de ellas en un issue.

A partir de estas historias de usuario, y de la metodología de diseño,
habrá que empezar a escribir el código. Como código no testeado es
código roto, mejor diseñar el API para empezar y más adelante añadir
el código y los tests correspondientes. Pero eso ya será en la
siguiente sesión.

Adicionalmente, una historia de usuario especificará qué hay que hacer en caso de error. 

* **HU6** Un hito sin issues estará en un estado incorrecto y la única operación permisible sobre el mismo es añadir issues al mismo.


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

Raku permite la creación de [excepciones específicas](https://rakudocs.github.io/type/Exception). Generalmente sigue la convención de que se denominan con una `X` seguida del nombre de la clase a la que se apliquen. Por ejemplo, esta para nuestro proyecto se llamará `X::Proyecto::NoIssue` y la aplicaremos para el caso en que no haya ningún issue en un hito:

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

Si no hay ningún issue, devolver un hash vacío podría ser una solución *a priori* válida. Sin embargo, eso solo retrasa el tratamiento de una situación o ambigua o incorrecta al cliente de la clase. Las historias de usuario pueden estar centradas, por ejemplo, en las estadísticas de la clase (abiertos/cerrados), pero si no hay ningún issue, la historia de usuario ni siquiera es aplicable, por lo que es razonable indicar este hecho mediante una excepción, como estamos haciendo.

¿Se podría resolver esto forzando directamente a que cuando se cree un hito tenga que hacerse con algún issue? Atendiendo a las historias de usuario, es posible que no: un evento de creación de un hito es un hecho único sin acompañamiento de issues. Así que tratar esto con una excepción es la mejor forma de defendernos ante los posibles cambios o evoluciones en el futuro de la misma.


## Actividad

Esencialmente, en esta primera fase se llevarán a cabo las actividades
de diseño para el resto del curso.

1. Elegir un proyecto o un equipo o las dos cosas a la vez, y crear un
   repositorio 
   [usando esta plantilla](https://github.com/JJ/curso-qa-template),
   que contiene ya algunos tests y el diseño general, así como la
   licencia libre.
	  
2. Elaborar una cantidad aceptable de historias de usuario como
   documentos en un subdirectorio y crear a
   partir de ellas una serie de issues en GitHub. Los hitos deberán
   estar relacionados con estas historias de usuario.
   
3. Describir en el `README.md` el microservicio que se va a crear,
   explicando las tecnologías que se van a usar en el mismo.

## Entrega

Esta entrega se llevará a cabo, como el resto de las mismas, como un
pull request al fichero de [proyectos](../proyectos.md), tras añadir
en el *fork* propio el nombre del proyecto y un enlace al repo, así
como la versión.

Usaremos
[versionado semántico para las entregas](https://semver.org/), donde
el primer número será siempre el hito (comenzando por el hito
0). Diferentes versiones cambiarán el *minor* (el segundo) o el
tercero, si son algunos cambios que no alteran el API ni la
funcionalidad. Cada entrega corresponderá a un *release*, y por tanto
el respositorio tendrá que tener un tag 

> Los tags se hacen con `git tag`, y para hacer push de los mismos se
> tendrá que hacer, adicionalmente al normal, `git push --tags`

que deberá corresponder exactamente a la versión que se haya enviado.
