# Calidad en un aplicación desde el diseño.


## Planteamiento

En nuestro contexto, se define [la calidad del
software](https://en.wikipedia.org/wiki/Software_quality) como la
capacidad del mismo de seguir para cumplir (o exceder) las
especificaciones y las expectativas de los clientes del mismo.

En general, la calidad es un proceso, y no simplemente una
característica que se añade en un momento determinado al producto. Por
eso el producto, en nuestro caso el software, junto con el proceso de
desarrollo, debe estar diseñado y pensado desde el principio para
asegurar que funciona y que responde a todos los requisitos
funcionales y de otro tipo que se hayan planteado.

En un curso que inicialmente iba dedicado al diseño de tests se debe
partir del planteamiento de la propia [aplicación, componente o
biblioteca](aplicaciones.md), porque se realizan pruebas sobre las
especificaciones de la aplicación; no se puede quedar en la sintaxis y
una enumeración de los frameworks disponibles para hacer tests.

Así que en esta sesión vamos a hablar de cómo diseñar de forma ágil un
sistema, para asegurarse de que va a responder a las necesidades del
cliente y además va a ser suficientemente flexible para seguirlo
haciendo si las necesidades cambian (o surgen otras nuevas).

## Al final de esta sesión

Previamente, los estudiantes habrán formulado una idea general o un
modelo de "cliente" y habrán expresado en una serie de épicas (o una
sola) cómo se articulan esas necesidades. En este hito, los
estudiantes sabrán como plantear una arquitectura básica de aplicación
a partir de sus especificaciones y comenzar la implementación de forma
que hacer pruebas sobre esas especificaciones sea sencillo y
directo. También sabrán como plasmar en plataformas de desarrollo
colaborativo estos requisitos para llevar a cabo el desarrollo de la
aplicación.

## Criterio de aceptación

El proyecto tendrá una serie de hitos e issues creados

* Deberá haber documentos de una o varias historias de usuario en un
  directorio `HU`.

Con esto se probará que se están siguiendo los principios de diseño
desarrollando a partir de casos de uso, y que se desglosan a partir de
una serie de épicas.


### Después de la épica

> Echar un vistazo a la sesión sobre [metodologías ágiles](ágil.html)
> que precede a esta.

Tras las épicas, es necesario dividir lo que se quiere en varias
partes, de forma que se puedan abordar y por supuesto comprobar de
forma individual. En este proceso es cuando se empiezan a elaborar las
historias de usuario individuales.

En nuestro programa que tratará con un proyecto y sus diferentes
partes, hitos, issues y demás, por ejemplo para examinar el estado de
un proyecto externo en una clase, las acciones comenzarán
siempre con una petición que llegue desde GitHub. Por lo tanto,
podremos tener las siguientes historias de usuario.

* **HU0**: (Configuración) Como usuario, necesito que cada proyecto deberá tener una cadena única
  que lo identifique.
* **HU1**: Como usuario, necesito que cuando se cree un hito en un proyecto, ese hito se incluirá en
  la estructura de datos del proyecto correspondiente.
* **HU2**: Como usuario, necesito que cuando se cree un issue, se añadirá al hito
  correspondiente con estado "abierto". Si no está asignado a ningún hito, se emitirá un
  mensaje de error.
* **HU3**: Como usuario, necesito que cuando se cierre un issue, se cambie el estado del
  mismo.
* **HU4**: Como usuario, necesito que si se borra un issue, dejará de
  estar accesible.
* **HU5**: Si se solicita el porcentaje de terminación del hito, se
  responderá con una cantidad entre 0 y 100.

Estas historias de usuario se crearán como issues, y agruparse, a su
vez, en un hito, siempre que se identifique cuál es el producto
mínimamente viable. Por ejemplo, en este caso
todas las relativas a issues se pueden incluir en el mismo hito (salvo
quizás la última). El
MVP será una serie de clases que serán capaces de gestionar todo lo
relacionado con los hitos de forma independiente.

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

## Diseño dirigido por dominio

Una vez decidido el foco principal del proyecto y su arquitectura
general, el diseño debe descender hasta un nivel en el que pueda ser
abordable mediante la programación del mismo. "Divide y vencerás" nos
permite trabajar con entidades que son autónomas e independientes
entre sí, y que se pueden programar y testear por separado. Esta
autonomía, que es un requisito, hace que una de las técnicas más
conocidas sea el [diseño dirigido por el
dominio](https://en.wikipedia.org/wiki/Domain-driven_design).

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
para todos ellos. Estos agregados son imprescindibles y tienen que
tenerse en cuenta, porque en muchos casos servirán para gestionar todo
un conjunto de objetos, erigiéndose en *única fuente de verdad*.

Eventualmente, una entidad se convertirá en un módulo cuando se vaya a
implementar en el lenguaje de programación en el que decidamos
hacerlo. Todos los lenguajes de programación modernos son modulares,
con módulos agrupando funcionalidad relacionada, pero dependiendo del
lenguaje, una entidad y un objeto valor será una clase, un rol, un
módulo o paquete, o simplemente un fichero con una serie de funciones
y convenciones para ser invocadas una vez importado. La mayoría de los módulos
generan un *espacio de nombres*, que refleja también la jerarquía de
los mismos; este espacio de nombres a veces se refleja en el nombre
del módulo, a veces en el camino donde está almacenado.

> Por ejemplo, en Raku un módulo llamado `My::Project` estará almacenado
> en `lib/My/Project.pm6` y podrá tener otros módulos llamados
> `My::Project::Issue` que estará almacenado en
> `lib/My/Project/Issue.pm6`. Generalmente no se gestionarán estos
> objetos de forma independiente, sino que se usará un *agregado*; una
> estructura de datos que abarcará un conjunto de *issues* En el caso
> de Python, un módulo que se
> llame Project estará definido en `Project/core.py` (y en el
> directorio `Project` tendrá que haber un fichero `__init__.py`. El
> otro fichero mencionado estará en `Project/Issue.py`).

Este tipo de consideraciones tendremos que tenerlas en cuenta a la
hora de diseñar los ficheros en los que se va a almacenar nuestra
aplicación o proyecto; los nombres de los ficheros y la estructura de
directorios debe seguir las buenas prácticas habituales y reflejar la
estructura del mismo.

Tanto las entidades como objetos valor pueden ser módulos
independientes; sin embargo, el nombre de los mismos o como se diseñe
debe reflejar las dependencias unos de otros.

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

Vamos a ver qué historias de usuario saldrán de aquí; esta sería la
"historia de usuario" principal, aunque a partir de ella tendremos que
añadir alguna adicional (más adelante).

* El usuario querrá estar informado en todo momento del estado de cada uno de los proyectos.

Realmente el resto son temas de presentación. Lo importante es que
tenemos una entidad, el *proyecto*. Cada proyecto tiene identidad
propia, es decir que será un solo objeto que irá mutando de estado a
lo largo del tiempo. El *agregado* integrará en un solo API acceso al
estado de todos los proyectos, y el resto (hitos e *issues*) serán
objetos-valor, sin ningún tipo de existencia fuera del contexto de un
proyecto. Tendremos, por lo tanto, una sola entidad, la clase
`Proyecto`. Los objetos valor, `Hito` e `Issue` también serán clases,
pero no existen si no es dentro del contexto de un proyecto, por lo
que los mantendremos así.

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
> [`ejemplos`](../ejemplos) de este repositorio. En este caso en el
> subdirectorio `raku`.

En general, tendremos varias entidades en cada uno de los
proyectos. En particular, los proyectos planteados aquí se podrán
resolver con una sola, aunque también necesitaremos contar con al
menos un agregado que gestione el conjunto de los *issues*:

```raku
use Project::Issue;
use X::Project::NoSuchIssue;

unit class Project::Issues;

has %!issues;

method add( Project::Issue $issue ) { … }

method delete( UInt $issue-id ) { … }

method all() { %!issues };

method close( UInt $issue-id ) { … }

method get( UInt $issue-id --> Project::Issue ) { … }

```

Estamos hablando de TDD (que era el tema inicial del curso) y estamos poniendo código antes de
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
no pasarán; pero contiene todo el API que va a ser necesario para
llevar a cabo el objetivo anterior (incluso posiblemente alguno más
que se podría eliminar).


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

> El "entorno" en el que se va a guardar la configuración debe, muy
> posiblemente, incluir en producción sistemas de configuración
> distribuida como los vistos en [el tema de servicios](servicios.md).

### Ejemplo

En el caso de nuestra aplicación, por lo pronto, no tenemos más
dependencia que el lenguaje de programación que vamos a usar,
Raku (y que tenemos que usar logs obligatoriamente). Más adelante
tendremos que especificar el resto de las
dependencias, pero mientras tanto, en el fichero `META6.json`, que es
el fichero de metadatos para distribuciones en Raku, bibliotecas o
aplicaciones, se
especifican todos los módulos de los que esta aplicación va a
depender.

Las dependencias las especificaremos siempre usando código (y bajo
control de versiones), y por tanto distinguiremos entre varios tipos

* El lenguaje y versión del mismo con el que vayamos a trabajar. Esto
  se especifica en los metadatos del proyecto (en el fichero
  correspondiente) o de alguna otra forma, como ficheros
  específicos. En nuestro caso usamos `META6.json`, y declaramos la
  versión de Raku (6.*) que vamos a usar.

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

* [Principio de la responsabilidad única](https://en.wikipedia.org/wiki/Single_responsibility_principle):
  las *entidades* de las que hablamos anteriormente tienen un contexto
  autónomo, y por tanto las programaremos en una clase, grupo de
  clases y finalmente microservicio que se encargue exclusivamente
  de una sola entidad. Este principio se resume en que "debería haber
  una sola razón para cambiar una entidad": diferentes razones,
  diferentes responsabilidades. 

* [Principio de la inversión de dependencias](https://en.wikipedia.org/wiki/Dependency_inversion_principle)
 (o inversión del control): *se debe depender de cosas abstractas, no
   concretas*. Es decir, la dependencia de una clase debe ser de un
   almacén de datos, no de una base de datos concreta, y el almacén de
   datos debe *inyectarse* en la clase cuando se vaya a crear. Este
   principio es esencial, también en el contexto de tests, y
   volveremos a él a lo largo de este curso.

### Ejemplo

Dividiremos las entidades en diferentes clases que tengan una
responsabilidad única. La clase expuesta anteriormente se encargará
solo y exclusivamente de los issues. Tendremos otra clase para los
hitos o *milestones*, que serían *objetos-valor*, una como esta

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

En este código, además, se usan todas las buenas prácticas para que
sea lo más compacto posible, y es (si conoces el lenguaje)
auto-descrito. Por ejemplo, se usa un solo nombre para recuperar los
issues y *dispatch* múltiple para seleccionar lo que se llama, o se
capturan los posibles errores de ejecución en la propia signatura del
método, en vez de usar un detector.

> Hay una posible ambigüedad que estamos resolviendo por las bravas:
> si hay un issue con un número y se vuelve a asignar, el nuevo
> sustituye al viejo. Siempre que quede claro y esté testeado, no
> tiene por qué haber problema.

En este caso no estamos usando ningún sistema de almacenamiento (entre
otras cosas porque es un objeto valor, más sobre esto más adelante), pero
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
con una sola fuente de verdad (*Single Source of Truth*, SSOT), que
estará en el almacén de datos elegido. Sólo se inyectará la
dependencia en la clase que vaya a mutar al resto de las
clases. También esta única fuente de verdad estará relacionada con la
única entidad de la que hablamos en domain driven design, al
principio, mientras que el resto de las clases serán simplemente
objetos valor.

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


## Actividad: versión 4

Esencialmente, en esta primera fase se llevarán a cabo las actividades
de diseño para el resto del curso. Como en el resto de los hitos
el código se debe añadir mediante un PR que deberá aprobar algún otro
miembro del proyecto.

Elaborar una cantidad aceptable de historias de usuario y crear a
partir de ellas una serie de issues en GitHub (HUs dirigido a la
persona que programe).

## Entrega

Esta entrega se llevará a cabo, como el resto de las mismas, como un
pull request al fichero de [proyectos](../proyectos.md), tras cambiar
en el *fork* propio (que deberá estar actualizado) la versión del
proyecto, que como siempre tendrá que corresponder con un tag del
repositorio.

Seguiremos usando 
[versionado semántico para las entregas](https://semver.org/), donde
el primer número será siempre el hito (comenzando por el hito
0).
