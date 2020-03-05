# Hacia los tests unitarios

## Planteamiento

En un proceso de calidad del software, es tan importante el planteamiento de la clase y las herramientas que se usan para gestionar las tareas de un proyecto como el código que se escriba para asegurarnos de que efectivamente se cumplen las historias de usuario. Conviene desacoplar el diseño de la clase, sin embargo, del código que se implementa en el mismo, porque es el diseño el que debe seguir las historias de usuario, mientras que el código se asegura de que tengan el resultado deseado.

Por supuesto, todo en un proyecto se va a ejecutar desde un task runner, así que será lo primero que se vea en esta sesión.

## Al final de esta sesión

El estudiante habrá elegido un task runner, y habrá programado el interfaz de una clase correspondiendo a la historia de usuario o historias que desee, terminando el primer hito.

## Criterio de aceptación

Se habrá implementado el interfaz de una clase y un fichero de un task runner que contenga, al menos, la instalación de dependencias si fuera necesario.

## Herramientas de construcción o gestores de tareas.

> Antes de hablar de los tests unitarios en sí, vamos a hablar de las
> herramientas de construcción. En general, la ejecución de los tests
> unitarios (y del resto de las tareas) se gestionará a partir de un
> fichero de tareas que se ejecuta desde aquí.

Como parte de la metodología de 12 factores que vimos en la fase de
[diseño](diseño.md), una de los factores incluye [separar las fases](https://12factor.net/es/build-release-run) de
construcción, despliegue y ejecución. Pero para hacer esto todas las
fases (y alguna otra tarea que esté relacionada con las mismas) deben
de estar codificadas: la infraestructura es código, y ese código, en
este caso, será parte de un fichero que será ejecutado por una
herramienta de construcción.

Las herramientas de construcción o ejecutores de tareas permiten usar, como
subcomandos de un solo programa y especificados en un solo fichero, todas las tareas que se tienen que llevar a
cabo con una aplicación, desde su compilación hasta la generación de la
documentación.

Los task runners se diferencian entre si a lo largo de varios ejes

* Explícitos o implícitos, es decir, si hay un programa que se llame
explícitamente así y sea diferente al intérprete o compilador o no. Go es un
ejemplo de task runner implícito: como subcomandos de go se compila, se pasan
tests o se instala un paquete.
* Estándar o externos: hay lenguajes que vienen con su propia herramienta de
construcción, estándar o simplemente la que más se usa, aunque puede tener
limitaciones: `npm` en JavaScript, `cargo` en Rust, `zef` en Raku... En muchos
casos, sin embargo, hacen falta herramientas externas, de la cuales la
herramienta por antonomasia es `make`, pero hay otras más, como `invoke` para
Python o [`rake`](https://github.com/ruby/rake) para Ruby
* Imperativas o declarativas: las procedurales permiten ejecutar órdenes para
conseguir algo, mientras que las declarativas describen el estado en el que
quieres que el sistema esté y realizan sus propias acciones para llegar a ese
estado:
[`Maven` es declarativo, `ant` es imperativo](https://stackoverflow.com/questions/14955597/imperative-vs-declarative-build-systems)
* Genéricas o [específicas](https://softwareengineering.stackexchange.com/questions/297847/why-do-build-tools-use-a-scripting-language-different-than-underlying-programmin) del lenguaje:
Las genéricas lanzan scripts, generalmente del shell, mientras que las
específicas usan el propio lenguaje de programación, con lo que es más fácil que
 se adapten a diferentes plataformas.

Muchas herramientas usan un *Domain Specific Language*, un DSL que permite
expresar los diferentes *targets* y las acciones necesarias para alcanzarlos o,
en el caso declarativo, como saber que están en ese estado. `make`, por ejemplo,
 tiene el suyo, y otras herramientas como `sbt` también; algunas como Gradle
 usan Groovy.

Sean cuales sean las facilidades que ofrezca el lenguaje, las herramientas de
construcción permiten centralizar en un solo fichero todas las tareas relativas
  a la aplicación, y por tanto contribuyen al código limpio y a que la
  configuración sea código y explícita. Todo lo que esté en la herramienta de
  construcción son tareas que no tienes que describir en la documentación y que
  son, por tanto, mucho más fáciles de mantener. Esas tareas se suelen denominar *targets* u objetivos. En muchos casos se pueden establecer correspondencias entre objetivos, o bien definir reglas que activen esos objetivos (por ejemplo, la modificación de un fichero que haga que la versión compilada se haya desfasado con respecto al fuente).

La más antigua, `make`, sigue siendo una de las herramientas más
populares. Por ejemplo, este `Makefile` minimalista se podría usar
para un programa en go:

```Makefile
%:
	go $@
```

`%` es genérico, cualquier target, y `$@` es la variable que contiene el target.
 Es decir, si hacemos `make test` se ejecutará `go test`. Como los targets se
 ejecutan por orden, podemos poner algún target anterior con órdenes específicas
  que no sigan este patrón.
  
La herramienta `make` y sus `Makefile`s se pueden usar en cualquier lenguaje. De hecho, C y C++ lo usan, pero también Python.

Por el contrario, [`sake`](https://github.com/perl6/p6-sake) es un módulo
externo al lenguaje Raku, pero usa Raku para expresarse.

```perl6
task "installdeps", {
    shell "zef install --deps-only ."
}

for <test install> -> $task {
    task $task, {
        shell "zef $task ."
    }
}
```

Declaramos tres tareas, y como la mayoría de estas herramientas, si se usa
`sake help` nos dará las tareas que se pueden usar:

```
Registered tasks:
	✓ help
	✓ install
	✓ installdeps
	✓ test
```

Una vez visto desde dónde se van a ejecutar los tests, pasamos a los
tests en sí.

Adicionalmente, estas herramientas de construcción dan también un
vocabulario común para las diferentes tareas que se pueden realizar
sobre una base de código. Órdenes como `deploy`, `install`, `run`, van
a ser las mismas sin importar cómo se haga la herramienta. Si se usa
siempre la misma, por ejemplo `npm` con Node, sabemos que `npm install` va a ser la que lo instale todo; pero si no, no hace falta
más que especificar el binario de la herramienta para saber qué órdenes
habría que dar para realizar las tareas habituales. 


### Ejemplo en Python

Python usa generalmente la misma orden para instalar todo. Pero si
ponemos esa orden en el `Makefile`, así:

```
install:
	pip install -r requirements.txt
```

## Historias de usuario, las maravillas del código inexistente y tests

> En este ejemplo y en el siguiente hay realmente código en las clases, porque en su estado, ya están testeadas y demás. El código, sin embargo, no es lo importante y debéis recordar que siempre se escribe el test antes que el código. Así que no miréis al código y listo.


Una de las lecciones más importantes es que el código que no falla es
el que no se ha escrito. En general, esto se traduce en usar todo tipo
de restricciones a nivel de compilación (tales como la estructura de
tipos, o el protocolo meta-objetos) para que las cosas ocurran tal
como deben ocurrir sin tener que preocuparte con escribir código que,
en tiempo de ejecución, haga que se respete esa restricción. Código
que funciona correctamente según el compilador, y es así por su
estructura y no por el código adicional que se ha escrito, es más
correcto que cualquier otro. Esto también es un ejemplo de
programación defensiva.

### Ejemplo en Raku

Generalmente, lenguajes que ofrecen tipos graduales o tipos estáticos
son más estrictos, en este sentido, que otros que no lo exigen. Si
además el protocolo de meta-objetos (es decir, el que permite diseñar
el sistema de clases, roles y módulos) añade restricciones
adicionales, tenemos todo lo que deseamos. Por ejemplo, la clase
`Issue` en Raku:
                    
```Raku
enum IssueState <Open Closed>;

unit class Project::Issue;

has IssueState $!state = Open;
has Str $!project-name;
has UInt $!issue-id;

multi submethod BUILD( UInt :$!issue-id!,
            Str :$!project-name!,
            IssueState :$!state = Open) {}


method close() { $!state = Closed }
method reopen() { $!state = Open }
method project-name( --> Str ) { return $!project-name }
method issue-id( --> UInt ) { return $!issue-id }
method state( --> IssueState ) { return $!state } 
```

Esta clase tiene que respetar todas las historias de usuario
correspondientes. Por ejemplo, el constructor (`BUILD`) se asegura de
que el estado del issue esté abierto; hay funciones para cambiar el
estado. Pero lo importante es que todas las variables de instancia son
privadas (con `$!`), con lo que el propio compilador se va a asegurar
de que la única forma de cambiarlas sea a través de los métodos que
cambian su valor.

Adicionalmente, podríamos añadir una historia de usuario adicional,
HU7
> HU7: El proyecto al que esté asignado y el ID serán constantes a lo largo
de toda la vida de un issue.

¿Hay código que compruebe si se está cambiando? No. Es la propia
definición y el uso de la sintaxis del lenguaje el que no nos tendrá
que hacer comprobaciones sobre si ha cambiado tal cosa. En la propia
estructura, y sin código, estará asegurado.

También estamos implementando otra historia de usuario que no habíamos
pensado:

> HU8: El nombre del proyecto será una cadena y el identificador único
> de cada issue será un entero mayor que cero.

Una vez más, de esto nos aseguramos mediante la definición de las
variables de instancia, y mediante el constructor que se asegura de
que le pasen ese tipo y no otro.

Por esta razón es por la que lenguajes como Raku resultan más
apropiados para aplicaciones de cierta entidad que otros.

### Python y sus restricciones: no todo el monte es orégano.

Esta sería la definición del mismo tipo de datos en Python

```python
from enum import Enum

IssueState = Enum('IssueState', 'Open Closed')

class Issue:

    def __init__(self, projectName: str, issueId: int ):
        self._state = IssueState.Open
        self._projectName = projectName
        self._issueId = issueId

    def close(self):
        self._state = IssueState.Closed

    def reopen(self):
        self._state = IssueState.Open

    @property
    def state(self):
        return self._state

    @property
    def projectName(self):
        return self._projectName

    @property
    def issueId(self):
        return self._issueId
```

(Sólo funcionará de Python 3.4 en adelante, por el uso un tanto
peculiar de `Enum`).

Pero en todo caso, aquí hacemos varias cosas para llevar a cabo las
mismas historias de usuario.

* Anotaciones de tipo para el nombre del proyecto y el issue.
* Uso de propiedades para indicar los valores que podemos sacar del
  objeto.
  
Pero hay dos problemas.
* No existen las variables privadas o de sólo lectura en Python. Se
  indica con un subrayado en el primer carácter que son privadas, pero
  eso es una simple convención. Si queremos asegurarnos de que son
  privadas o no se alteran, tendremos que usar estructuras de datos
  específicas (y más lentas).
* Tampoco podemos añadir anotaciones de tipos a las variables de
  instancia. 

```
>>> from Project.Issue import Issue
>>> issue = Issue("X",33)
>>> issue._issueId = "Pepillo"
```

Hacemos esto y se queda tan campante. Con revisiones de código y
algunas otras medidas se puede asegurar que se comporte correctamente,
pero en todo caso siempre será mejor elegir algún lenguaje en el que
el compilador o intérprete haga ese trabajo por ti.

## Actividad

> Este hito corresponderá a la versión 1 `v1.x.x` del proyecto.

A partir del diseño creado en la anterior actividad, y siguiendo las
prácticas de uso de los issues (y su cierre desde un *commit*), crear
el interfaz de al menos una clase básicas que corresponda a la misma entidad (según
el dominio del problema que se haya elegido), esta funcionalidad debe corresponder a las historias de usuario que se hayan planteado, y el nombre de las funciones debe ser suficientemente explícito.

El repositorio tendrá que incluir un fichero de configuración para poder llevar a cabo los tests de evaluación del proyecto llamado `qa.json` con la siguiente estructura:

```json
{
    "lenguaje" : "Nombre del lenguaje",
    "build" : "Makefile",
    "clase" : "lib/nombre/del/fichero.pm6",
  
}
```

En vez de `Makefile`, se usará el nombre del fichero de construcción que se haya usado para ejecutar los tests, que tendrá que estar presente en el repositorio; el nombre del fichero de clase que se haya creado también deberá ponerse el que corresponda.

> Se aconseja no crear a mano el fichero JSON, o si se hace, que se compruebe online o donde sea. Cualquier editor de programación será capaz de crear uno sintácticamente correcto, de todas formas.
