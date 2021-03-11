# Llevando a cabo los tests unitarios

## Planteamiento

Los lenguajes de programación modernos tienen todo un marco de
utilidades y bibliotecas para poder ejecutar esos tests; estos marcos
van desde las funciones que te permiten comprobar si el resultado
obtenido es igual al deseado, hasta las herramientas de construcción o
ejecutores de tareas que se usan, de forma más o menos estándar, en
cada lenguaje de programación para lanzar los tests. En este tema
veremos de forma integral todos esos aspectos de los tests.

## Al final de esta sesión

El estudiante habrá programado los tests y los habrá lanzado desde un
*task runner* específico para su lenguaje o genérico.

## Criterio de aceptación

La entidad principal del problema se habrá implementado en una o
varias clases, y cada una de las funciones tendrá un test que se
ejecutarán en local. Los tests deberán pasar.

## Marcos de prueba y bibliotecas de aserciones

El principal objetivo de los tests unitarios es probar todos los
posibles caminos que el código vaya a seguir. Se llaman de *caja
blanca* porque puedes *mirar* dentro del código.

> Deberían llamarse caja transparente, pero a saber.

Y en esa "contemplación" debes tratar de ejercitar, a través de
entradas a funciones, todas las posibles opciones que el código pueda
tomar: decisiones, posibles excepciones, e incluso diferentes órdenes
de magnitud en las variables de inicio y terminación de un bucle.

Ya que hemos visto una iniciación a como se testea, vamos a ver cómo
se llevan a cabo los tests unitarios en diferentes ejemplos.

Hay muchas metodologías para seguir en la creación de tests, pero una
de las que se pueden usar es la
[FIRST](https://medium.com/@tasdikrahman/f-i-r-s-t-principles-of-testing-1a497acda8d6). Los
tests deben ser rápidos (aunque esto no va a depender sólo del número
de tests), aislados, repetibles, auto-validados y completos, es decir,
seguir todos los caminos críticos de tu código (aunque no
necesariamente absolutamente todos los caminos). En particular, se
deben testear los casos *edge* o casos que que se producen en los
extremos de los valores de los argumentos que usemos en las
funciones. Esta completitud, aparte de ir sobre el código, tendrá que
ir también sobre las historias de usuario, que es lo que en realidad
debe ser cubierto.

Al principio, la T era de *timely*, es decir, *a tiempo*. TDD dice que
hay que escribir los tests *antes* del código, para seguir el
principio
[red-green-refactor](https://softwarecrafters.io/javascript/tdd-test-driven-development),
es decir, hay que escribir los tests,
luego escribir el código guarro que haga falta para que pasen los
tests (*green*), luego refactorizar. Sin embargo, lo importante, al
final, es que haya test. Ese tipo de estrategias pueden funcionar bien
en ciertos entornos. Lo que funcione mejor para cada uno es siempre lo mejor.

### Escribiendo tests en JavaScript

Hay lenguajes que, como Go, valoran la simplicidad y además incluye de serie todo lo necesario
para llevar a cabo los tests. Python, el lenguaje en el que solo hay
una buena forma de hacer las cosas (que depende del mes en que uno
intente hacerlas), permite que se hagan las cosas de
varias formas diferentes, e incluye en su biblioteca estándar una
biblioteca de aserciones.

Pero hay
[múltiples bibliotecas que se pueden usar](https://stackoverflow.com/questions/14294567/assertions-library-for-node-js) en
Node;
el
[panorama actualizado se presenta en este repositorio](https://github.com/goldbergyoni/javascript-testing-best-practices/).

> Cabe destacar que era inicialmente un artículo en Medium. Al final,
> acabó siendo un repo.

La
biblioteca de aserciones [`assert`](https://nodejs.org/api/assert.html)
forma parte de la estándar de JS, pero hay otras como
[Unexpected](http://unexpected.js.org/) o aserciones que son parte de marcos
de tests más completos, tales como [Chai](https://www.chaijs.com/), [Jasmine](https://jasmine.github.io/),
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
órdenes que, a su vez, ejecutan los programas de test y escriben un
informe sobre cuáles han fallado y cuáles no con más o menos
parafernalia y farfolla. Una vez más, [hay varios marcos de
testeo](https://stackoverflow.com/questions/4308786/what-is-the-best-testing-framework-to-use-with-node-js)
para nodejs (y, por supuesto, uno propio para cada uno de los
lenguajes de programación, aunque en algunos están realmente
estandarizados).

En general, y como en casi todos los lenguajes, cada test tendrá tres
partes: *Arrange*, *Act*, *Assert*. Es decir, prepara, haz lo que
tengas que hacer, y comprueba la aserción. Además de los
[preparativos](tests-unitarios-organización.md) que afectan al test en
general (setup, tests, teardown), estas tres partes afectarán a cada
test o subtest en particular.

Como algunos marcos de prueba como Chai usan su propia biblioteca de
aserciones, podemos hacer este pequeño cambio para usarla:

```
var assert = require("chai").assert,
    apuesta = require(__dirname+"/../Apuesta.js");

describe('Apuesta con Chai', function(){
    // Testea que se haya cargado bien la biblioteca
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

Los únicos cambios son el usar `assert.ok` en vez de `assert` (que
pertenece a Chai), y el objeto `assert` de la biblioteca `chai`, en
vez de usar el que hay por omisión.

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
	// Testea que se haya cargado bien la biblioteca
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

La mayoría de los marcos de tests, y en particular Mocha, pueden usar
diferentes bibliotecas de aserciones. En este caso hemos escogido la que
ya habíamos usado, `assert`. A bajo nivel, los tests que funcionen en
este marco tendrán que usar una biblioteca de este tipo, porque Mocha
funciona a un nivel superior, con funciones como `it` y `describe` que
hacen explícito, a diferentes niveles, el comportamiento que queremos
comprobar. Se ejecuta con `mocha` y el resultado de ejecutarlo será:


```
    Apuesta
      Carga
        ✓ should be loaded
      Crea
        ✓ should create apuestas correctly


    2 passing (6ms)
```

(pero con más colorines)

> Y la verdad es que debería haber puesto los mensajes en español.

Con la biblioteca BDD de Chai, podríamos expresar los mismos tests de
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
objeto de la biblioteca existe, y que se puede instanciar y que los
resultados que obtienen se pueden convertir a una cadena de la forma
esperada. Como se ve, el marco (que incluye las funciones `describe` e
`it`) no varía, lo que varía es como se describe el test en sí, que
depende de la biblioteca de aserciones.

Además, te indica el tiempo que ha tardado lo que te puede servir para
hacer un *benchmark* de tu código en los diferentes entornos en los
que se ejecute.

### Escribiendo tests en Go

[Go](https://golang.org/) es un lenguaje que pretende evitar lo peor
de C++ para crear un lenguaje concurrente, de sintaxis simple y con
más seguridad; además, Go provee también un entorno de programación
con una serie de herramientas (*toolbelt*) de serie (su propio *task
runner*). Go integra este marco de pruebas en el propio lenguaje, por
lo que nos permite fijarnos exclusivamente en la biblioteca de pruebas
con la que estamos trabajando. La diferencia principal con otros
lenguajes es que la biblioteca de Test en vez de aserciones, tiene
errores que tienes que especificar si alguno de los resultados no ha
sido el esperado.

Por ejemplo, vamos a fijarnos
en
[esta pequeña biblioteca que implementa información sobre los hitos de
un proyecto en el contexto de una asignatura](https://github.com/JJ/HitosIV) escrita
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


> Te puedes descargar todo el proyecto con `git clone
> https://github.com/JJ/HitosIV` o hacerle *fork*, es software
> libre. Se agradecen PRs e issues.

La sintaxis no es excesivamente complicada. Se importan las
bibliotecas para [testear (`testing`)](https://golang.org/pkg/testing/) y para averiguar de qué tipo es
algo (`reflect`) y se crean dos funciones de test, una por cada función que
queremos probar. Las funciones de deberán empezar por una letra
mayúscula, como sucede aquí. El nombre del paquete es el mismo que el
del paquete que queremos testear.

La fase de *setup* de este test está implícita en la importación del
paquete que testea, que en realidad se importa automáticamente sólo
por el nombre del fichero; este es, en realidad, parte del mismo
ámbito que el paquete que está probando (como se ve arriba, porque se
declara el mismo paquete).

De este fichero se ejecutarán todas las funciones al
ejecutar desde la línea de órdenes `go test` (que sería el marco de
pruebas en este caso), que devolverá algo así:

```
PASS
ok  	_/home/jmerelo/Asignaturas/infraestructura-virtual/HitosIV	0.017s
```

En vez de aserciones como funciones específicas, Go simplifica el API
de pruebas eliminando las aserciones; por el contrario, hace que se
devuelva un error (con `t.Error()`) cuando el test no pasa. Si todos
funcionan, no hay ningún problema y se imprime `PASS` como se muestra
arriba. Adicionalmente, `t.Log()` (siendo `t` una estructura de datos
que se le tiene que pasar a todos los tests) se usa para mostrar algún
mensaje sobre qué está ocurriendo en el test. En este caso, uno de los
tests comprueba que efectivamente haya hitos en el fichero JSON que se
ha pasado, y el segundo comprueba que el tipo que se devuelve cuando
se solicita un hito es el correcto.

>Los tests que se muestran aquí no cubren necesariamente todas las
>funcionalidades de este módulo; en el repositorio sí están
>completos. Se muestran solo estos para ilustrar cómo funciona en un
>lenguaje determinado.

La biblioteca de pruebas (que no de aserciones) usada proporciona, en este caso, una serie de
estructuras de datos que podemos usar para informar de los errores que
se produzcan. La estructura `T`, por ejemplo, es la que se recibe como
argumento en cada uno de los tests; tiene funciones como `t.Error`
para indicar cuando las condiciones del test no se cumplen. Si se usa
`ErrorF` se puede dar, como en otros marcos de test, cual es la salida
deseada y la obtenida a partir de una cadena formateada (de ahí el `f`).

```
// Comprueba si el número de hitos es correcto
func TestNumHitosCorrecto(t *testing.T) {
	t.Log("Test Número Hitos")
	var x uint = uint(CuantosHitos())
	if x == 3 {
		t.Log("El número de hitos es correcto")
	} else {
		t.Errorf("El número de hitos es incorrecto; esperábamos %d", 3)
	}
}

func TestDemasiadosHitos(t *testing.T) {
	var x uint = uint(CuantosHitos())
	var too_big uint = x + 3
	_, e := Uno( too_big )
	if e != nil {
		t.Log("Devuelve error si es demasiado grande")
	} else {
		t.Error("No devuelve error y debería")
	}

}
```

> Adicionalmente,
> [se pueden incluir ejemplos de salida que serán comprobados](https://golang.org/pkg/testing/#hdr-Examples) si
> se precede la salida deseada con la palabra correcta.


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
cabo los tests: las aserciones, que permiten ejecutar código (o
examinar el resultado del código) y realizar algún tipo de comparación
con el resultado deseado, y un segundo nivel que será generalmente un
programa, que se encargará de buscar los ficheros de tests siguiendo
una convención determinada (nombre del fichero, directorio en el que
se encuentre), ejecutarlos, examinar la salida (que, como hemos
indicado arriba, sigue un protocolo determinado llamado TAP) y decir
si se han pasado todos los tests o no, en cuyo caso se indicará alguna
información adicional como qué scripts de tests no se ha pasado o el
mensaje de la misma. Algunos programas usados en otros lenguajes son:

* Ruby usa [RSpec](http://rspec.info/), que además está basado en el
  comportamiento deseado, lo que permite tener descripciones mucho más
  informativas del test y el resultado del fallo.

* Perl usa [prove](https://perldoc.perl.org/prove.html), con múltiples
  opciones de configuración. De hecho, es el que se usa en el test de
  la asignatura.

* [JUnit](https://junit.org/junit5/) es el más cercano a estas
  funcionalidades en Java.

* Raku usa `prove6`, pero también `zef` si se trata de usarlo sobre un
  módulo (en realidad, `zef` usa una serie de heurísticas para
  aprovechar el marco de pruebas que esté instalado).

Cada lenguaje incluye este tipo de marcos, sea como parte de su
distribución base o como parte de alguna biblioteca popular.

## Ejecutando tests unitarios

Los tests son también programas; simplemente usan una API o librería
para informar de los fallos de test que se han producido. Como tales,
se pueden ejecutar como se ejecuten los programas en cada lenguaje:
compilando o interpretando el programa.

En algunos casos se usan adicionalmente marcos de test; sin embargo,
estos marcos de test, en general, sólo interpretan la salida y a veces
hacen alguna cosa adicional como establecer caminos de ejecución para
encontrar los módulos o ejecutar los tests que sigan la convención
general; sin embargo, para ejecutar el programa y probar lo que está
haciendo no son, en general, necesarios.

Usar un marco de test con su propio programa, por otro lado, te
permitirá ejecutar los tests de forma uniforme para todos los módulos
de un lenguaje, y también hacer otras cosas como ejecutarlos en
paralelo. Por eso conviene conocerlos, sobre todo porque es lo que se
va a usar desde los sistemas de integración continua.

Trabajar con un gestor de tareas estándar te permitirá, también,
lanzar los tests siguiendo el estándar. En muchos casos, lo más
conveniente es hacerlo de esta forma.

## Testeando las excepciones

Los errores o excepciones son parte integral de una aplicación como se
ha visto anteriormente, y se deben comprobar también; no se pueden
testear todos los fallos posibles, pero al menos algunos previsibles
y, sobre todo, los que estén previstos en el propio código de nuestra
clase.

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

```raku
my $milestone = Project::Milestone.new(:$project-name,:milestone-id(1));

throws-like { $milestone.issues }, X::Project::NoIssue,
        "Empty milestone throws";
```

Según la historia de usuario 6 del [tema anterior](diseño.md), un hito sin
issues está en un estado incorrecto; también diseñamos una excepción para esto.
En este caso comprobamos que esa historia se cumple: devolvemos la excepción
correcta si no hemos añadido ningún issue al hito.


### Ejemplo en TypeScript

[TypeScript](https://www.typescriptlang.org/) es un lenguaje con
tipado gradual, que funciona también de forma asíncrona. Podemos
programar el issue que hemos usado anteriormente de [esta
forma](https://github.com/JJ/ts-milestones):

```
export enum State { Open,Closed };
export class Issue {
    private state: State = State.Open;
    private project_name: string;
    private id: number;

    constructor(project_name: string, id: number) {
        this.project_name = project_name;
	    this.id = id;
    }

    show_state() {
	    return this.state;
    }

    close() {
        this.state = State.Closed;
    }
}
```

Aparte de usar `this` para referirse a la instancia de la clase, el
resto es similar a otros lenguajes. Lo podemos testear usando el marco
de pruebas `jest`

```
import { Issue, State } from '../Project/Issue';

var data: Issue;

beforeAll(() => {
    data = new Issue("Foo",1);
});



test("all", () => {
    expect(  data.show_state() ).toBe( State.Open );
    data.close();
    expect(  data.show_state() ).toBe( State.Closed );
});
```

`jest` usa una serie de aserciones basadas en el comportamiento, y
[fases de setup](https://jestjs.io/docs/en/setup-teardown) generales (con `beforeAll`), con otras adicionales
antes y después de cada uno de los tests. Esas funciones devolverán
promesas; hasta que no se cumplan no se procederá a llevar a cabo el
resto de los tests (en este caso) o los tests correspondientes. En
este caso, sin embargo, es una simple inicialización de un dato, que
se va a ejecutar siempre. Como los tests se llevan a cabo de forma
asíncrona, sin embargo, de esta forma nos aseguramos que cuando se
ejecute el código de los mismos esté presente. 


### Ejemplo en Elixir

Elixir no es un lenguaje que maneje con soltura, pero puede ser
 interesante como ejemplo de uno que incluye una utilidad externa al
 compilador, `mix`, con la cual se pueden expresar cosas como la
 versión del lenguaje con la que vamos a trabajar (ver de nuevo la
 aplicación de 12 factores). También porque está a medio camino entre
 la orientación a objetos y la funcionalidad.  Implementaremos solo
 parte de la funcionalidad para gestionar un issue:

```elixir
defmodule Issue do
  @moduledoc """
  A simple issue in a repository
  """

  @enforce_keys [:projectname, :id]
  defstruct [:projectname, :id, state: :Open ]

  @doc """
  Can create and close it, and that's it

  """
  def close( issue ) do
    issue |> struct( %{state: :Closed} )
  end

  @doc """
  Reopens issue

  """
  def reopen( issue ) do
    issue |> struct( %{state: :Open} )
  end
end
```

Hay unos pocos más dos puntos de la cuenta, pero al final lo que hace es definir
 un `Issue` con una función para cerrarlo; esta función lo que hace, en
 realidad, es generar un nuevo issue con solo ese campo cambiado, ya que las
 estructuras de datos en Elixir son inmutables
 . Por eso lo
 tenemos que testear de esta forma

```elixir
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

  test "State after reopening",context do
    new_issue = Issue.reopen(context[:issue])
    assert new_issue.state == :Open
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


## *Hooks* o ganchos de git.

Es posible que se considere a `git` una simple herramienta de control
de fuentes, cuando es mucho más: una verdadera herramienta de control
de flujos de trabajo. Los flujos de trabajo en git se controlan a base
de ganchos o *hooks*. Diferentes cambios de estado generan eventos
estándar, que reciben una cierta entrada y tienen como salida
un valor verdadero o falso, que indica si se puede pasar a la
siguiente etapa. Por ejemplo, crear un commit activará un hook que lo
procesará, añadiendo o no al mensaje de commit, y rechazando el commit
si el valor que devuelve el programa es distinto de cero.

Porque en general los *hooks* son eso, programas, scripts escritos en
cualquier lenguaje, con un nombre estándar relacionado con el del
evento (tal como `pre-commit`) y situados en el subdirectorio
`.git/hooks` del repositorio local.

Si queremos ejecutar los tests cada vez que se haga un commit,
tendremos que lanzarlos desde estos *hooks*. Pero en principio, la
idea principal es que un *hook* puede realizar cualquier tipo de
comprobación; lo que está también relacionado con la calidad. Por
ejemplo, este programa en Ruby que comprueba que el formato del
mensaje de commit sea el convencional de 50 caracteres en la primera
línea, luego una vacía, y luego el resto de las líneas de un máximo de
80 caracteres:

```
#!/usr/bin/env ruby
# coding: utf-8

lines = File.open(ARGV[0],'r').readlines

first_line = lines.shift

if first_line.size > 50
  puts "La primera línea tiene más de 50 caracteres"
  exit 255
end

if lines.size > 0
  second_line = lines.shift.chop

  if second_line != ''
    puts "La segunda línea debe estar vacía"
    exit 255
  end

end

if lines.size > 0

  bad_lines = {}

  lines.each_with_index do |line,i|
    bad_lines[i+2] = line if line.size > 80
  end

  if bad_lines.keys.size > 0
    puts "Todas estas líneas tienen más de 80 caracteres", bad_lines.keys.join(", ")
    exit 255
  end
end
```

Lo que hace el programa es ir extrayendo líneas de su argumento;
tratándose del hook, recibirá el fichero donde está el mensaje del
commit como primer argumento (generalmente se guardará en
`COMMIT_MSG`). Si alguna de las comprobaciones no funciona, saldrá del
programa con el código de estado 255, que indica que la ejecución ha
sido fallida. En ese caso, no se llevará a cabo el evento, en este
caso creación (o modificación) de un mensaje de commit.


## Actividad y entrega


En este, que será el hito 10, se deben de ejecutar todos los tests y tener un
resultado, que no necesariamente tiene que ser siempre positivo porque
todavía no hemos "integrado". Lo que se pide es que el `README.md`
incluya un apartado `# Instrucciones` y que dentro de ese apartado se
explique cómo ejecutar los tests. Necesariamente, ya que se ha
incluido un fichero de gestión de tareas, esta instrucción será del
estilo `nombre_fichero_gestión_tareas test`. Para identificarlo, habrá
que incluir una clave adicional, `testing`, con dos claves: `runner` y `framework`:

    testing:
        runner: grunt,
        framework: chai

> Hay que distinguir el *runner*, que es lo que declaramos en este
> caso, del *fichero* que usa el runner, que es el que hemos declarado
> anteriormente.

Por ejemplo; en este caso, lo que se buscará en el `README` será la
cadena

    `make test`

Lo que se persigue con este objetivo es que se empiece a convertir el
`README.md` del proyecto en documentación del mismo, que ayude a quien
lo encuentre a entender de qué va el proyecto, como instalárselo y
demás. También, por supuesto, a que se empiecen a incorporar todas las
tareas al gestor de tareas para simplificar su uso.


