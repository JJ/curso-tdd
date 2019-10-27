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

El primer paso para entender cuales son las diferentes entidades y objetos-valor es crear una serie de *casos de uso* o *historias de usuario* que nos aquilaten el dominio del problema y nos permitan trabajar con él.

### Ejemplo

> Una aplicación nos va a permitir controlar el avance de los diferentes proyectos de este curso. Mediante un *hook* de GitHub, todos los proyectos informarán a un sitio central de sus actividades. Nos interesará sobre todo saber en qué hito está cada proyecto y en qué estado de consecución está cada uno de esos hitos. El objetivo es, por ejemplo, mantener un *leaderboard* en tiempo real que liste los proyectos por consecución, o mantener una historia del mismo.

Vamos a ver qué historias de usuario saldrán de aquí:

* El usuario querrá estar informado en todo momento del estado de cada uno de los proyectos.

Realmente el resto son temas de presentación. Lo importante es que tenemos una entidad, el *proyecto*. Cada proyecto tiene una identidad propia, es decir que será un objeto que irá mutando de estado a lo largo del tiempo. El *agregado* integrará en un solo API acceso al estado de todos los proyectos, y el resto (hitos e *issues*) serán objetos-valor, sin ningún tipo de existencia fuera del contexto de un proyecto. Tendremos, por lo tanto, una sola entidad, la clase `Proyecto`. Los objetos valor, `Hito` e `Issue` también serán clases, pero no existen si no es dentro del contexto de un proyecto, por lo que los mantendremos así.

¿Cumple esta entidad nuestra historia de usuario? En principio sí, pero evidentemente se puede evolucionar durante el desarrollo de la aplicación.

Por ejemplo, un `Issue` puede ser así:

```perl6
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

> Todo el código irá en el subdirectorio [`code`](../code)

En general, tendremos muchas entidades en cada uno de los proyectos. En particular, los proyectos planteados aquí se podrán resolver con una sola.

## 12 Factor

La metodología de los [12 factores](https://12factor.net/es/) se puede usar a continuación del diseño, para plantear toda la instrumentación necesaria para llevar a cabo el proyecto. Este tipo de metodología, además, está adaptada al uso de aplicaciones nativas en la nube porque se desarrolla simultáneamente la infraestructura, el código y los tests. Desde el punto de vista de la calidad, dos de esos factores, guardar la configuración en el entorno y declarar y aislar las dependencias contribuyen a que la aplicación sea más fácil de testear y desarrollar. 

### Ejemplo

En el caso de nuestra aplicación, por lo pronto, no tenemos más dependencia que el lenguaje de programación que vamos a usar, Perl 6. Más adelante tendremos que especificar el resto de las dependencias, pero mientras tanto, en el fichero `META6.json` se especifican todos los módulos de los que esta aplicación va a depender.

Las dependencias las especificaremos siempre usando código, y por tanto distinguiremos entre varios tipos

* El lenguaje y versión del mismo con el que vayamos a trabajar. Esto se especifica en los metadatos del proyecto (en el fichero correspondiente) o de alguna otra forma, como ficheros específicos. En nuestro caso usamos `META6.json`, y declaramos la versión de Perl 6 (6.*) que vamos a usar.

* Dependencias externas. Lo mejor es usar una herramienta de construcción para que, con un simple `make install`, se puedan instalar todas. Usar un Dockerfile o una receta ansible también ayudará.

* Dependencias del propio lenguaje. En este caso, un fichero de metadatos será suficiente para especificarlo. 

## SOLID

Los principios [SOLID](https://es.wikipedia.org/wiki/SOLID) constituyen también una metodología de desarrollo de software que encaja bien con las metodologías anteriores. Pero desde nuestro punto de vista nos interesan dos especialmente:

* [Principio de la responsabilidad única](https://en.wikipedia.org/wiki/Single_responsibility_principle): las *entidades* de las que hablamos anteriormente tienen un contexto autónomo, y por tanto las programaremos en una clase, grupo de clases y eventualmente microservicio que se encargue exclusivamente de una sola entidad. Este principio se resume en que "debería haber una sola razón para cambiar una entidad": diferentes razones, diferentes responsabilidades.

* [Principio de la inversión de dependencias](https://en.wikipedia.org/wiki/Dependency_inversion_principle): *se debe depender de cosas abstractas, no concretas*. Es decir, la dependencia de una clase debe ser de un almacén de datos, no de una base de datos concreta, y el almacén de datos debe *inyectarse* en la clase cuando se vaya a crear. 

### Ejemplo

Dividiremos las entidades en diferentes clases que tengan una responsabilidad única. La clase expuesta anteriormente se encargará solo y exclusivamente de los issues. Tendremos otra clase para los hitos, una como esta

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

La única responsabilidad de esta clase es encargarse de los hitos, y operaciones agregadas sobre ellos. Si hay que calcular el número de hitos abiertos, delega en el propio issue, que sabe si está abierto o no. La clase se encargará de albergar los issue y darnos los issue en un estado determinado.

En este código, además, se usan todas las buenas prácticas para que sea lo más compacto posible, y es (si conoces el lenguaje) auto-descrito. Por ejemplo, se usa un solo nombre para recuperar los issues y *dispatch* múltiple para seleccionar lo que se llama, o se capturan los posibles errores de ejecución en la propia signatura del método, en vez de usar un detector.

> Hay una posible ambigüedad que estamos resolviendo por las bravas: si hay un issue con un número y se vuelve a asignar, el nuevo sustituye al viejo. Siempre que quede claro y esté testeado, no tiene por qué haber problema.

En este caso no estamos usando ningún sistema de almacenamiento, pero estamos desacoplando el modelo del sistema real. A un nivel superior tendremos que introducir el sistema que decida de dónde se leen esos issues e hitos.

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
