# Gestores de tareas y su importancia en automatización del desarrollo.

## Planteamiento

En un proceso de calidad del software, es tan importante el
planteamiento de la clase y las herramientas que se usan para
gestionar las tareas de un proyecto como el código que se escriba para
asegurarnos de que efectivamente se cumplen las historias de
usuario.

Por supuesto, todo en un proyecto se va a ejecutar desde un task
runner, porque tanto el desarrollo como el despliegue deben estar
automatizados (y esta automatización garantiza la replicabilidad del
mismo).

## Al final de esta sesión

El estudiante habrá elegido un *task runner*, que usará para compilar o
comprobar la sintaxis del interfaz de una clase correspondiendo a la historia de usuario o historias que desee.

## Criterio de aceptación

Se habrá implementado el interfaz de una clase y un fichero de un task
runner que contenga, al menos, la comprobación de la sintaxis o
compilación, incluyendo la instalación de dependencias que fueran
necesarias. Este fichero se irá ampliando con las diferentes tareas
que se vayan haciendo durante el curso.

## Herramientas de construcción o gestores de tareas.

> Antes de hablar de los tests unitarios en sí, vamos a hablar de las
> herramientas de construcción. En general, la ejecución de los tests
> unitarios (y del resto de las tareas) se gestionará a partir de un
> fichero de tareas que se ejecuta desde aquí.

Como parte de la metodología de 12 factores que vimos en la fase de
[diseño](diseño.md), uno de los factores incluye [separar las fases](https://12factor.net/es/build-release-run) de
construcción, despliegue y ejecución. Pero para hacer esto todas las
fases (y alguna otra tarea que esté relacionada con las mismas) deben
de estar codificadas: la infraestructura es código, y ese código, en
este caso, será parte de un fichero que será ejecutado por una
herramienta de construcción.

Las [herramientas de construcción](https://en.wikipedia.org/wiki/List_of_build_automation_software) o ejecutores de tareas permiten usar, como
subcomandos de un solo programa y especificados en un solo fichero, todas las tareas que se tienen que llevar a
cabo con una aplicación, desde su compilación hasta la generación de la
documentación pasando por todo lo necesario para ejecutar todo tipo de
tests y desplegarlo.

Los task runners se diferencian entre si a lo largo de varios ejes

* Explícitos o implícitos, es decir, si hay un programa que se llame
explícitamente así y sea diferente al intérprete o compilador o no;
también se podían denominar internos o externos (aunque dejaremos este
eje para el siguiente). Go es un
ejemplo de lenguaje que usa task runner implícito: como subcomandos de go se compila, se pasan
tests o se instala un paquete. Rust usa un task runner explícito: se
llama `cargo` y desde él se pueden llevar a cabo todas las tareas
necesarias.
* Configuración externa o implícita. [Deno](https://deno.land/manual), un fork de Node, evita el
  fichero de configuración externo para usar directamente las
  declaraciones de uso de bibliotecas externas como parte de la
  definición. Go es capaz de hacerlo también. En la mayoría de los
  casos hace falta un fichero que describa este tipo de cosas.
* Estándar o opcionales: hay lenguajes que vienen con su propia herramienta de
construcción, estándar o simplemente la que más se usa, aunque puede tener
limitaciones: `npm` en JavaScript (que últimamente está siendo
sustituida por `yarn`, por cierto), `sbt` en Scala, `zef` en Raku... En muchos
casos, sin embargo, hacen falta herramientas externas, de la cuales la
herramienta por antonomasia es `make`, pero hay otras más, como `invoke` para
Python o [`rake`](https://github.com/ruby/rake) para Ruby.
* Imperativas o declarativas: las procedurales o imperativas permiten ejecutar órdenes para
conseguir algo, mientras que las declarativas describen el estado en el que
quieres que el sistema esté y realizan sus propias acciones para llegar a ese
estado: en el caso de Java,
[`Maven` es declarativo, `ant` es imperativo](https://stackoverflow.com/questions/14955597/imperative-vs-declarative-build-systems)
* Genéricas o [específicas](https://softwareengineering.stackexchange.com/questions/297847/why-do-build-tools-use-a-scripting-language-different-than-underlying-programmin) del lenguaje:
Las genéricas lanzan scripts, generalmente del shell, mientras que las
específicas usan el propio lenguaje de programación, con lo que es más fácil que
 se adapten a diferentes plataformas. `make` es el caso más clásico de
 herramienta genérica.

Muchas herramientas usan *Domain Specific Languages*, un DSL que permite
expresar los diferentes *targets* y las acciones necesarias para alcanzarlos o,
en el caso declarativo, como saber que están en ese estado. `make`, por ejemplo,
 tiene el suyo, y otras herramientas como `sbt` también; algunas como Gradle
 usan Groovy, un lenguaje "pequeño" pero de propósito general; una
 herramienta llamada [`xmake`](https://github.com/xmake-io/xmake) usa
 Lua.

> Por lo que siempre es conveniente conocer muchos lenguajes.

Sean cuales sean las facilidades que ofrezca el lenguaje (o simple descripción), las herramientas de
construcción permiten centralizar en un solo fichero todas las tareas relativas
  a la aplicación, y por tanto contribuyen al código limpio y a que la
  configuración sea código y explícita. Todo lo que esté en la herramienta de
  construcción son tareas que no tienes que describir en la documentación y que
  son, por tanto, mucho más fáciles de mantener. Esas tareas se suelen
  denominar *targets* u objetivos. En muchos casos se pueden
  establecer correspondencias entre objetivos, o bien definir reglas
  que activen esos objetivos (por ejemplo, la modificación de un
  fichero que haga que la versión compilada se haya desfasado con
  respecto al fuente). En la mayor parte de los casos, las tareas
  tienen nombres estándar: `test`, `build`, `install`.

### Ejemplos 

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

Por el contrario, [`ake`](https://github.com/Raku/ake) es un módulo
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
`ake help` nos dará las tareas que se pueden usar (y aparece sin
necesidad de registrarla):

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

Como se ha indicado, el gestor de tareas de Rust se llama `cargo`. Por
ejemplo, `cargo check` ejecutado sobre el [ejemplo](../ejemplos/rust)
comprobará que las dependencias son alcanzables y la sintaxis del
fichero, así:

```
    Updating crates.io index
  Downloaded lazy_static v1.4.0
  Downloaded time v0.1.44
  Downloaded autocfg v1.0.1
  Downloaded colored v1.9.3
  Downloaded log v0.4.11
  Downloaded num-traits v0.2.12
  Downloaded libc v0.2.77
  Downloaded simple_logger v1.9.0
  Downloaded num-integer v0.1.43
  Downloaded cfg-if v0.1.10
  Downloaded chrono v0.4.15
  Downloaded atty v0.2.14
  Downloaded 12 crates (851.8 KB) in 2.92s
   Compiling autocfg v1.0.1
   Compiling libc v0.2.77
   Compiling log v0.4.11
    Checking lazy_static v1.4.0
    Checking cfg-if v0.1.10
   Compiling num-traits v0.2.12
   Compiling num-integer v0.1.43
    Checking atty v0.2.14
    Checking time v0.1.44
    Checking colored v1.9.3
    Checking chrono v0.4.15
    Checking simple_logger v1.9.0
    Checking issue v0.1.0 (/home/jmerelo/Asignaturas/cloud-computing/curso-tdd/ejemplos/rust/issue)
    Finished dev [unoptimized + debuginfo] target(s) in 15.60s
```



### Ejemplo en Python

Python usa generalmente la misma orden para instalar todo, `pip` o
alguna variante. Pero si
ponemos esa orden en el `Makefile`, así:

```
install:
	pip install -r requirements.txt
```

podremos ejecutarla como `make install`. `make` es una de las
herramientas que no suele tener `help` como un objetivo, habría que
implementarlo a mano.

Desde 2016 existe un PEP, más concretamente el [PEP 518](https://www.python.org/dev/peps/pep-0518/#file-format),
donde se establece un formato estandar para definir las dependencias de un proyecto.
Se establece un archivo `pyproject.toml` que se inspira en el funcionamiento de `cargo`
y permite definir dependencias, dependencias de desarrollo, versiones compatibles, ....

Uno de los proyectos que implementan esta especificación es [poetry](https://python-poetry.org/)
(que se ha establecido como alternativa a [pipenv](https://pipenv-es.readthedocs.io/es/latest/)). Como 
se puede apreciar en el sitio web de `poetry` el funcionamiento es muy similar a `cargo` y 
permite definir estructuras para liberias y proyectos, con utilidades para operar en ellos.
Además de esto permite la gestión de entornos virtuales de python, con lo que se pueden aislar
las dependencias y usar versiones específicas del software.

## Actividad

> Este hito corresponderá a la versión 6 `v6.x.x` del proyecto.

A partir del diseño creado en la anterior actividad, y siguiendo las
prácticas de uso de los issues (y su cierre desde un *commit*), crear
el interfaz de al menos una clase básicas que corresponda a la misma entidad (según
el dominio del problema que se haya elegido), esta funcionalidad debe corresponder a las historias de usuario que se hayan planteado, y el nombre de las funciones debe ser suficientemente explícito.

A partir de este hito, el repositorio tendrá que incluir un fichero de
configuración para poder llevar a cabo los tests de evaluación del
proyecto llamado `qa.json` con la siguiente estructura:

```json
{
    "lenguaje" : "Nombre del lenguaje",
    "build" : "Makefile",
    "ficheros" : ["lib/nombre/del/fichero.pm6","otro/fichero.rakumod"]
  
}
```

En vez de `Makefile`, se usará el nombre del fichero de construcción
que se haya usado para ejecutar los tests, que tendrá que estar
presente en el repositorio; el nombre de los ficheros de clase (procedente
del hito anterior) que se haya creado también deberá ponerse el que corresponda.

> Se aconseja no crear a mano el fichero JSON, o si se hace, que se
> compruebe online o donde sea. Cualquier editor de programación será
> capaz de crear uno sintácticamente correcto, de todas formas. 
