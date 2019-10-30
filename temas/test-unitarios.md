# Hacia los tests unitarios

## Planteamiento

Los lenguajes de programación modernos tienen todo un marco de utilidades y bibliotecas para poder ejecutar esos tests; estos marcos van desde las funciones que te permiten comprobar si el resultado obtenido es igual al deseado, hasta las herramientas de construcción o ejecutores de tareas que se usan, de forma más o menos estándar, en cada lenguaje de programación para lanzar los tests. En este tema veremos de forma integral todos esos aspectos de los tests.

## Al final de esta sesión

El estudiante habrá programado los tests y los habrá lanzado desde un task runner específico para su lenguaje o genérico.

## Criterio de aceptación

La entidad principal del problema se habrá implementado en una clase,
y cada una de las funciones tendrá un test que se ejecutarán en
local.

## Test unitarios

Las pruebas deben de corresponder a las especificaciones que queremos
que respete nuestro software, y como tales deben de ser previas a la
escritura del código en sí y del test. Es esencial entender
perfectamente qué queremos que nuestro software haga, y hay diferentes
formas de hacerlo, pero generalmente, en metodologías ágiles, tenemos
que hacerlo mediante [*historias de usuario*](https://es.wikipedia.org/wiki/Historias_de_usuario),
narrativas de qué es lo que puede hacer un posible usuario y qué es lo
que el usuario debería esperar. Estas historias de usuario se
convertirán en *issues* del repositorio, cuyo cierre marcará que el
código está escrito, testeado, y se ajusta a la misma. 

En la mayoría de los entornos de programación y especialmente en `node` hay dos niveles en el test: el
primero es el marco de pruebas y el segundo la librería de pruebas que
efectivamente se está usando. El marco de pruebas será el que ejecute
todos los tests, examine el resultado y emita un informe, que
dependerá de si los tests se han superado o no.

> Para ello, todas las librerías de tests emiten sus resultados en un
> formato de texto estándar, que se llama TAP. Por eso los marcos de
> pruebas se pueden usar con cualquier librería de pruebas, incluso de
> cualquier lenguaje.

Por debajo del marco de pruebas (la librería que permite estructuras
las pruebas), a veces existe una biblioteca de aserciones, que son las
diferentes pruebas unitarias que se deben pasar o no. En muchos casos,
la biblioteca de pruebas incluye ya aserciones; en otros casos,
bibliotecas de pruebas pueden trabajar con diferentes bibliotecas de
aserciones. 

### Escribiendo tests en Go

[Go](https://golang.org/) es
un lenguaje que pretende evitar lo peor de C++ para crear un lenguaje
concurrente, de sintaxis simple y con más seguridad; además, Go provee
también un entorno de programación con una serie de herramientas
(*toolbelt*) de serie. Go integra este marco de pruebas en el
propio lenguaje, por lo que nos permite fijarnos exclusivamente en la
biblioteca de pruebas con la que estamos trabajando.

Por ejemplo, vamos a fijarnos
en
[esta pequeña biblioteca que lee de un fichero en JSON los hitos de la asignatura Infraestructura Virtual](https://github.com/JJ/HitosIV) escrita
en ese lenguaje, Go. La biblioteca
tiene
[dos funciones, una que devuelve un hito a partir de su ID y otra que te dice cuantos hay](https://github.com/JJ/HitosIV/blob/master/HitosIV.go).


Los módulos en Go incluyen funciones simples, estructuradas en un
paquete o *package*. Para testear un paquete en Go simplemente se crea un fichero con el
mismo nombre que el paquete y el sufijo `_test` como
[el siguiente](https://github.com/JJ/HitosIV/blob/master/HitosIV_test.go):


```Go
package HitosIV

import (
	"testing"
	"reflect"
)

func TestHitos (t *testing.T){
	t.Log("Test Id");
	if CuantosHitos() <= 0 {
		t.Error("No milestones")
	}
}

func TestTodosHitos (t *testing.T){
	t.Log("Test Todos");
	these_milestones := Hitos()
	if reflect.TypeOf(these_milestones).String() == "Data" {
		t.Error("No milestones here")
	}
}
```


> Te puedes descargar todo el proyecto con `git clone https://github.com/JJ/HitosIV` o hacerle *fork*, es software
> libre. Se agradecen PRs e issues.

La sintaxis no es excesivamente complicada. Se importan las
bibliotecas para [testear (`testing`)](https://golang.org/pkg/testing/) y para averiguar de qué tipo es
algo (`reflect`) y se crean dos funciones de test, una por cada función que
queremos probar. Las funciones de deberán empezar por una letra
mayúscula, como sucede aquí. El nombre del paquete es el mismo que el
del paquete que queremos testear.

De este fichero se ejecutarán todas las funciones al
ejecutar desde la línea de órdenes `go test`, que devolverá algo así:

```
PASS
ok  	_/home/jmerelo/Asignaturas/infraestructura-virtual/HitosIV	0.017s
```

En vez de aserciones como funciones específicas, Go simplifica el interfaz de test haciendo que
se devuelva un error (con `t.Error()`) cuando el test no pasa. Si
todos funcionan, no hay ningún problema y se imprime `PASS` como se muestra arriba. Adicionalmente, `t.Log()`
(siendo `t` una estructura de datos que se le tiene que pasar a todos
los tests) se usa para mostrar algún mensaje sobre qué está ocurriendo en el test. En este caso, uno de los tests comprueba que efectivamente
haya hitos en el fichero JSON que se ha pasado, y el segundo comprueba que el tipo que se devuelve cuando
se solicita un hito es el correcto. Estos tests no están completos;
generalmente hay que escribir una función de test para todas las
funciones del módulo. Se muestran solo estos para ilustrar cómo
funciona en un lenguaje determinado.

> Adicionalmente,
> [se pueden incluir ejemplos de salida que serán comprobados](https://golang.org/pkg/testing/#hdr-Examples) si
> se precede la salida deseada con la palabra correcta.


### Escribiendo tests en JavaScript

Go valora la simplicidad y además incluye de serie todo lo necesario
para llevar a cabo los tests. Python, el lenguaje en el que solo hay
una buena forma de hacer las cosas, permite que se hagan las cosas de
varias formas diferentes, e incluye en su biblioteca estándar una
biblioteca de aserciones.

En node hay
[múltiples bibliotecas que se pueden usar](https://stackoverflow.com/questions/14294567/assertions-library-for-node-js);
el [panorama de 2019 se presenta en este artículo](https://medium.com/welldone-software/an-overview-of-javascript-testing-in-2019-264e19514d0a). La
librería de aserciones [`assert`](https://nodejs.org/api/assert.html) 
forma parte de la estándar de JS, pero hay otras como
[Unexpected](http://unexpected.js.org/) o aserciones parte de marcos
de tests más completos. Estos marcos de test incluyen [Chai](https://www.chaijs.com/), [Jasmine](https://jasmine.github.io/),
[Must.js](https://github.com/moll/js-must) y [jest](https://jestjs.io/).


Veamos el siguiente
[ejemplo](https://github.com/JJ/desarrollo-basado-pruebas/blob/master/src/prueba-assert.js)
de uso de la biblioteca de aserciones llamada `assert`:

> Hace uso de una clase en JavaScript, [`Apuesta`, que está en otro repo](https://github.com/JJ/desarrollo-basado-pruebas/)

```
var apuesta = require("./Apuesta.js"),
assert= require("assert");

var nueva_apuesta = new apuesta.Apuesta('Polopos','Alhama','2-3');
assert(nueva_apuesta, "Creada apuesta");
assert.equal(nueva_apuesta.as_string(), "Polopos: Alhama - 2-3","Creado");
console.log("Si has llegado aquí, han pasado todos los tests");
```

Este programa usa `assert` directamente y como se ve por la línea del
final, no hace nada salvo que falle. `assert` no da error si existe el
objeto, es decir, si no ha habido ningún error en la carga o creación
del mismo, y `equal` comprueba que efectivamente la salida que da la
función `as_string` es la esperada.


El programa anterior ilustra la sintaxis, y puede formar parte de un
conjunto de tests; se puede ejecutar directamente, pero para testearlo
los lenguajes de programación usan un segundo nivel, el marco de
ejecución de los tests. Estos marcos incluyen programas de línea de
órdenes que, a su vez, ejecutan los programas de test y escriben 
un informe sobre cuáles han fallado y cuáles no con más o menos
parafernalia y farfolla. Una vez más, [hay varios marcos de testeo](https://stackoverflow.com/questions/4308786/what-is-the-best-testing-framework-to-use-with-node-js) para
nodejs (y, por supuesto, uno propio para cada uno de los lenguajes de
programación, aunque en algunos están realmente estandarizados).

Como algunos marcos de prueba como Chai usan su propia biblioteca de
aserciones, podemos hacer este pequeño cambio para usarla: 

```
var assert = require("chai").assert,
    apuesta = require(__dirname+"/../Apuesta.js");

console.log(assert);
describe('Apuesta con Chai', function(){
    // Testea que se haya cargado bien la librería
    describe('Carga', function(){
	it('should be loaded', function(){
	    assert.ok(apuesta, "Cargado");
	});
	
    });
    describe('Crea', function(){
	it('should create apuestas correctly', function(){
	    var nueva_apuesta = new apuesta.Apuesta('Polopos','Alhama','2-3');
	    assert.equal(nueva_apuesta.as_string(), "Polopos: Alhama - 2-3","Creado");
	});
    });
});
```

Los únicos cambios son el usar `assert.ok` en vez de assert, y el usar
el objeto `assert` de la biblioteca `chai`, en vez de usar el que hay
por omisión. 

Cada uno de ellos tendrá sus promotores y detractores, pero
[Mocha](https://mochajs.org/), [Jasmine](https://jasmine.github.io/) y [Jest](https://github.com/facebook/jest)
parecen ser los más populares. Los tres usan un sistema denominado
[Behavior Driven Development](https://en.wikipedia.org/wiki/Behavior-driven_development),
que consiste en describir el comportamiento de un sistema más o menos
de alto nivel; para ello suelen incluir una serie de aserciones o su
propia biblioteca de aserciones para que la sentencia que lleve a cabo
el test sea lo más cercana posible a la frase (en inglés) que la describiría. Como hay que escoger uno y parece que Mocha es más
popular, nos quedamos con este para escribir este programa de test.

```
var assert = require("assert"),
		apuesta = require(__dirname+"/../Apuesta.js");

describe('Apuesta', function(){
	// Testea que se haya cargado bien la librería
	describe('Carga', function(){
	it('should be loaded', function(){
		assert(apuesta, "Cargado");
	});
});

describe('Crea', function(){
	it('should create apuestas correctly', function(){
		var nueva_apuesta = new apuesta.Apuesta('Polopos','Alhama','2-3');
		assert.equal(nueva_apuesta.as_string(), "Polopos: Alhama - 2-3","Creado");
		});
	});
});
```

Mocha puede usar diferentes librerías de aserciones. En este caso hemos
escogido la que ya habíamos usado, `assert`. A bajo nivel, los tests
que funcionen en este marco tendrán que usar una librería de este
tipo, porque mocha funciona a un nivel superior, con funciones como
`it` y `describe` que describe, a diferentes niveles, el
comportamiento que queremos comprobar. Se ejecuta con `mocha` y
el resultado de ejecutarlo será:


```
    Apuesta
      Carga
        ✓ should be loaded 
      Crea
        ✓ should create apuestas correctly 


    2 passing (6ms)
```

(pero con más colorines)

>Y la verdad es que debería haber puesto los mensajes en español.

Con la librería BDD de Chai, podríamos expresar los mismos tests de
esta forma: 

```
var assert = require("chai").should(),
    apuesta = require(__dirname+"/../Apuesta.js");

describe('BDD con Chai', function(){
    it('Debería cargar la biblioteca y poder instanciarse', function() {
	apuesta.should.exist;
	var nueva_apuesta = new apuesta.Apuesta('Polopos','Alhama','2-3');
	
	nueva_apuesta.as_string().should.equal( "Polopos: Alhama - 2-3","Creado");
    })
});
```

La única diferencia es que ejecutamos la función `should` de `chai`,
que añade a todos los objetos funciones que permite expresar, en
lenguaje más o menos natural, qué es lo que queremos probar: que el
objeto de la librería existe, y que se puede instanciar y que los
resultados que obtienen se pueden convertir a una cadena de la forma
esperada. Como se ve, el marco (que incluye las funciones `describe` e
`it`) no varía, lo que varía es como se describe el test en sí, que
depende de la biblioteca de aserciones.

Además, te indica el tiempo que ha tardado lo que te puede servir para
hacer un *benchmark* de tu código en los diferentes entornos en los
que se ejecute.

### Realizando las pruebas en Scala

Hemos visto dos ejemplos: lenguaje el que la biblioteca de aserciones
forma parte de la biblioteca estándar, y lenguaje con múltiples
bibliotecas de aserciones para usar; también hay una diferencia entre
los lenguajes que incluyen los *task runners* *y* los marcos de test
dentro de la maquinaria básica, y otros que usan programas
externos. Veremos otro ejemplo de esto último.

En Scala, `sbt` realiza una función similar a `npm` en el mundo
node. Sin embargo, el lenguaje en sí es un poco más estricto y tiene
reglas más o menos precisas sobre dónde colocar los tests. Si las
fuentes están en `src/main`, las pruebas estarán en `src/test` en el
directorio correspondiente al nombre del paquete. Por ejemplo,
`src/test/scala/info/CC_MII/` para el paquete `info.CC_MII` que es el
que estamos usando en estos ejemplos.

También Scala tiene diferentes formas de testear. Una similar a la que
hemos usado anteriormente se llama `specs2`, una basada en
comportamiento. La usamos por ejemplo a continuación:

```Scala
package info.CC_MII

import org.specs2.mutable.Specification

class ApuestaSpec extends Specification {
  
  "Apuesta" should {

    "almacenar correctamente las variables" in {
      val esta_apuesta = new Apuesta( 2,3,"Dude")
      esta_apuesta.local must be_==(2)
      esta_apuesta.visitante must be_==(3)
      esta_apuesta.quien must beEqualTo("Dude")
    }

 
  }
}
```

Tras importar el módulo correspondiente a los tests, estos se agrupan
en una serie de sentencias `should` que serán ejecutadas
secuencialmente. En este caso tenemos una sola, en la que creamos una
instancia de la clase y comprobamos que efectivamente tiene los
valores que debe tener. Las órdenes `must be_==` y `must beEqualTo`
comprueban el valor de diferentes tipos y devuelven los valores
correspondientes si se cumple ese comportamiento y si no se cumple.

Este estilo de aserciones se suelen corresponder con
[*Behavior-Driven Development*](https://en.wikipedia.org/wiki/Behavior-driven_development),
al nivel más bajo, al menos. En vez de simples funciones o
comparaciones, tratamos de que el código de las aserciones se parezca
lo más posible a una descripción formal del comportamiento de esas
mismas funciones.

### Otros lenguajes

En general, en todos los lenguajes habrá dos niveles para llevar a
cabo  los tests: las aserciones, que permiten ejecutar código y
examinar el resultado del mismo, comparándolo con la salida deseada, y
generalmente un programa, que se encargará de buscar los ficheros de
tests siguiendo una convención determinada (nombre del fichero,
directorio en el que se encuentre), ejecutarlos, examinar la salida
(que, como hemos indicado arriba, sigue un protocolo determinado) y
decir si se han pasado todos los tests o no, en cuyo caso se indicará
alguna información adicional como qué scripts de tests no se ha
pasado o el mensaje de la misma. Algunos programas usados en otros
lenguajes son:

* Ruby usa [RSpec](http://rspec.info/), que además está basado en el
  comportamiento deseado, lo que permite tener descripciones mucho más
  informativas del test y el resultado del fallo.
  
* Perl usa [prove](https://perldoc.perl.org/prove.html), con múltiples
  opciones de configuración. De hecho, es el que se usa en el test de
  la asignatura.
  
* JUnit es el más cercano en Java.

* Raku usa prove6, pero también zef si se trata de usarlo sobre un módulo. 

Cada lenguaje incluye este tipo de marcos, sea como parte de su
distribución base o como parte de alguna biblioteca popular.

## Testeando los errores

Los errores o excepciones son parte integral de una aplicación como se ha visto
anteriormente
, y se
deben comprobar también; no se pueden testear todos los fallos posibles, pero al
 menos algunos previsibles y, sobre todo, los que estén previstos en el propio
 código de nuestra clase.

Casi todas las bibliotecas de aserciones incluyen alguna que permite testear que
 la excepción que se ha lanzado, o el fallo, es el correcto.

 Por ejemplo, en Go, esta función

```
func Uno(hito_id uint) (Hito,error) {
	if hito_id > uint(len(hitos_data.Hitos)) {
		return Hito{}, errors.New("Index too high")
	}
	return hitos_data.Hitos[hito_id], nil
}
```

debería devolver un error si el id del hito es mayor del admisible, ya que van
por orden. En Go se usa un paquete específico, `errors`, para ello, pero en
realidad Go no tiene un sistema de excepciones, sino que confía en esta
convención de retorno dual `( resultado_correcto, error)` para ello. Habrá que
comprobar, por tanto, de la misma forma:

```Go
	_, e := Uno( too_big )
	if e != nil {
		t.Log("Devuelve error si es demasiado grande")
	} else {
		t.Error("No devuelve error y debería")
	}
```

En este caso, como estamos comprobando que se devuelve el error, el primer
resultado no nos interesa y usamos la "variable desechable" de Go, `_`.
Adicionalmente podemos comprobar que el error devuelto es el correcto, por
supuesto, pero lo veremos en este otro ejemplo en Raku:

```perl6
my $milestone = Project::Milestone.new(:$project-name,:milestone-id(1));

throws-like { $milestone.issues }, X::Project::NoIssue,
        "Empty milestone throws";
```

Según la historia de usuario 6 del [tema anterior](diseño.md), un hito sin
issues está en un estado incorrecto; también diseñamos una excepción para esto.
En este caso comprobamos que esa historia se cumple: devolvemos la excepción
correcta si no hemos añadido ningún issue al hito.

## Fases de test: *setup*, *tests*, *teardown*.

En las tres fases del proceso de prueba:

* Durante el *setup* se crearán los objetos y cargarán los ficheros
  necesarios hasta poner nuestro objeto en un estado en el que se
  puedan llevar a cabo los tests. Esto puede incluir, por ejemplo,
  también crear esos objetos.
  
* A continuación se llevan a cabo las pruebas en sí; esas pruebas
  pueden estar agrupadas en subtests, y en el caso de que falle un
  subtest fallará el test del que depende completo.
  
* En la fase de *teardown* se limpia todo lo creado temporalmente, se
  cierran conexiones, y se deja al sistema, en general, en el mismo
  estado en el que estaba al principio.
  

Diferentes lenguajes tienen diferentes técnicas, más o menos formales,
para llevar a cabo las diferentes fases. En muchos de ellos se tratará
simplemente de las primeras órdenes de un script para organizarlo, y
los últimos para cerrar las pruebas. 

Por ejemplo, en Raku estas serían las primeras líneas de
un [test](../code/t/02-project.t): 

```perl6
use Test;

use Project::Issue;
use Project::Milestone;
use Project;

constant $project-name = "Foo";
my $issue-id = 1;
my $p = Project.new( :$project-name );
```

En este caso lo único que se hace es crear un objeto, que es sobre el
que van a recaer los tests más adelante. En el caso del módulo
similar, para hitos de una asignatura, en
Go,
[tendremos esto](https://github.com/JJ/HitosIV/blob/master/HitosIV_test.go#L9-L12):

```go
func TestMain(m *testing.M) {
	ReadsFromFile("./hitos_test.json") // Alternative test file
	os.Exit(m.Run())
}
```

`go test` llamará a la función `TestMain` del paquete antes que a
cualquier otra función. El argumento que recibirá no es de tipo
`testing.T`, como en el resto de los casos, sino `testing.M`; esta
función actuará como *setup*, en este caso leyendo de un fichero que
cargará la estructura de datos sobre la que actuarán el resto de los
tests. De hecho, el resto de los tests tenemos que llamarlos
explícitamente (con `m.Run`) y también que salir explícitamente del
`main` usando `os.Exit`, que devolverá el código de salida adecuado.

## Herramientas de construcción

Las herramientas de construcción o ejecutores de tareas permiten usar, como
subcomandos de un solo programa, todas las tareas que se tienen que llevar a
cabo con una aplicación, desde su compilación hasta la generación de la
documentación.

Los task runners se diferencian a lo largo de varios ejes

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

Muchas herramientas usan un Domain Specific Language, un DSL que permite
expresar los diferentes *targets* y las acciones necesarias para alcanzarlos o,
en el caso declarativo, como saber que están en ese estado. `make`, por ejemplo,
 tiene el suyo, y otras herramientas como `sbt` también; algunas como Gradle
 usan Groovy.

 Sean cuales sean las facilidades que ofrezca el lenguaje, las herramientas de
 construcción permiten centralizar en un solo fichero todas las tareas relativas
  a la aplicación, y por tanto contribuyen al código limpio y a que la
  configuración sea código y explícita. Todo lo que esté en la herramienta de
  construcción son tareas que no tienes que describir en la documentación y que
  son, por tanto, mucho más fáciles de mantener.

En el módulo en Go que hemos visto anteriormente podemos usar este simple
`Makefile`:

```Makefile
%:
	go $@
```

`%` es genérico, cualquier target, y `$@` es la variable que contiene el target.
 Es decir, si hacemos `make test` se ejecutará `go test`. Como los targets se
 ejecutan por orden, podemos poner algún target anterior con órdenes específicas
  que no sigan este patrón.

Por el contrario, [`sake`](https://github.com/perl6/p6-sake) es un módulo
externo, pero usa Raku para expresarse.

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

### Ejemplo en Elixir

Elixir no es un lenguaje que maneje con soltura, pero puede ser interesante como
 ejemplo de uno que incluye una utilidad externa al compilador, `mix`, con la
 cual se pueden expresar cosas como la versión del lenguaje con la que vamos a
 trabajar (ver de nuevo la aplicación de 12 factores). Implementaremos solo
 parte de la funcionalidad para gestionar un issue:

```elixir
defmodule Issue do
  @moduledoc """
  A simple issue in a repository
  """
  defstruct [:projectname, :id, state: :Open ]

  @enforce_keys [:state, :projectname, :id]

  @doc """
  Can create and close it, and that's it

  """
  def close( issue ) do
    issue |> struct( %{state: :Closed} )
  end

end
```

Hay unos pocos más dos puntos de la cuenta, pero al final lo que hace es definir
 un `Issue` con una función para cerrarlo; esta función lo que hace, en
 realidad, es generar un nuevo issue con solo ese campo cambiado, ya que las
 estructuras de datos en Elixir son inmutables
 . Por eso lo
 tenemos que testear de esta forma

```
defmodule IssueTest do
  use ExUnit.Case
  doctest Issue

  setup_all do
    this_issue = %Issue{ projectname: 'Foo', id: '1'}
    {:ok, issue: this_issue}
  end

  test "Initial issue state",context do
    assert context[:issue].state == :Open
  end

  test "State after closing",context do
    new_issue = Issue.close(context[:issue])
    assert new_issue.state == :Closed
  end
end
```

`ExUnit` es el módulo de Elixir para pruebas unitarias, y usa `setup_all` para
la fase de puesta a punto; en ella creamos un issue, y la estructura de datos
que se devuelve en ella estará disponible como `context`, un *hash* que usamos
para comprobar si efectivamente el issue creado está abierto y para crear una
nueva versión del issue cerrado.

Para testear, simplemente ejecutamos `mix test`; Elixir es un tipo de lenguaje
que usa una herramienta de construcción estándar como Node. El repositorio está
en [GitHub](https://github.com/JJ/elixir-gh-projects).

## Actividad

A partir del diseño creado en la anterior actividad, y siguiendo las
prácticas de uso de los issues (y su cierre desde un *commit*), crear
una o varias clases básicas que correspondan a la misma entidad (según
el dominio del problema que se haya elegido), por supuesto incluyendo
los tests correspondientes. Los tests se ejecutarán en local, por lo
pronto.

El repositorio tendrá que incluir un fichero de configuración para poder llevar a cabo los tests llamado `qa.json` con la siguiente estructura:

```json
{
  "lenguaje" : "Nombre del lenguaje" 
  "build" : "Makefile"
  
}
```

En vez de `Makefile`, se usará el nombre del fichero de construcción que se haya usado para ejecutar los tests, que tendrá que estar presente en el repositorio.
