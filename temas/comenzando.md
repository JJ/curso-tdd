# Entre el diseño y la implementación


## Planteamiento

Del diseño a la implementación, o a tomar decisiones sobre la
implementación, hay una serie de pasos que dar que incluyen decidir
quién se va a encargar de qué, y qué pasos vamos a dar en esa
implementación, cómo se va a organizar el proyecto. Aquí trataremos de
dar esos pasos, viendo también ejemplos.

## Al final de esta sesión

Previamente se habrán creado una serie de casos de uso/historias de
usuario, y quizás se ha avanzado un poco en el diseño de los paquetes
que lo van a implementar. Ahora se tratará de haber aclarado cuales
con los principios de implementación, y aclarar en una serie de hitos
cómo va a organizarse el trabajo de programación.

Además, se organizará en el repositorio, según el lenguaje elegido,
las dependencias que vayan a necesitarse.

## Criterio de aceptación

El proyecto tendrá una serie de hitos e issues creados

* Deberá haber documentos de una o varias historias de usuario en un
  directorio `HU`.

Con esto se probará que se están siguiendo los principios de diseño
desarrollando a partir de casos de uso, y que se desglosan a partir de
una serie de épicas.


## Preparando el entorno

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
   almacén de datos con un interfaz específico, no de una base de datos concreta, y el almacén de
   datos debe *inyectarse* en la clase cuando se vaya a crear. Este
   principio es esencial, también en el contexto de tests, y
   volveremos a él a lo largo de este curso.

### Ejemplo

Dividiremos las entidades en diferentes clases que tengan una
responsabilidad única. La clase expuesta anteriormente se encargará
solo y exclusivamente de los issues. Tendremos otra clase para los
hitos o *milestones*, que serían *objetos-valor*, una como esta

```raku
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
haber [una razón para que un objeto de una clase
cambie](http://geekswithblogs.net/TimothyK/archive/2014/06/11/dry-and-srp.aspx). Si
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
punto una serie de herramientas y una actitud; lo indicado por [Joel
on
software](https://dev.to/checkgit/the-joel-test-20-years-later-1kjk)
sigue siendo válido después de muchos años: usar siempre control de
fuentes, hacer el build (y finalmente el despliegue) en un solo paso,
priorizar arreglar los bugs.

Pero en todo caso, lo más importante es la planificación que se va a
llevar a cabo antes de aprobar. Los sistemas de control de fuentes
modernos incluyen un sistema de organización del trabajo usando
*issues* e *hitos*. Los issues son órdenes de trabajo (y ya los hemos
usado para las historias de usuario), los hitos los
agrupan creando un punto de control de forma que no se puede ir hacia
adelante hasta que no se terminen todos los issues de un hito. Lo más
importante desde el punto de vista de la organización del trabajo es
que cuando se trabaje, esté claro en qué contexto se hace y se haga
contra un issue, refiriéndose a él en el commit (preferiblemente en la
primera línea del mismo). Todos los issues, a su vez, deben estar en
un hito.


## Actividad: versión 5

Como hay que organizarse ya el trabajo de programación, en esta el
proyecto tendrá que

* Haber especificado las dependencias, especialmente externas (como un
  sistema de log)
* Haber organizado uno o más hitos, donde se habrán empezado a incluir
  los *issues* que conduzcan a la creación del producto mínimamente
  viable descrito en ese hito.

## Entrega

Esta entrega se llevará a cabo, como el resto de las mismas, como un
pull request al fichero de [proyectos](../proyectos.md), tras cambiar
en el *fork* propio (que deberá estar actualizado) la versión del
proyecto a *5.x.y*, que como siempre tendrá que corresponder con un tag del
repositorio.
