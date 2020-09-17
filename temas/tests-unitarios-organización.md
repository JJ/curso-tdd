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
varias clases,
y cada una de las funciones tendrá un test que se ejecutarán en
local. Los tests deberán pasar.


## Tests unitarios

Las pruebas deben de corresponder a las especificaciones que queremos
que respete nuestro software, y como tales deben de ser previas a la
escritura del código en sí y del test. Es esencial entender
perfectamente qué queremos que nuestro software haga, y hay diferentes
formas de hacerlo, pero generalmente, en metodologías ágiles, tenemos
que hacerlo mediante [*historias de usuario*](https://es.wikipedia.org/wiki/Historias_de_usuario),
narrativas de qué es lo que puede hacer un posible usuario y qué es lo
que el usuario debería esperar; ya hemos hablado de ellas en el tema
dedicado al [diseño](diseño.md). Estas historias de usuario se
convertirán en *issues* del repositorio, agrupados en mojones, cuyo cierre marcará que el
código está escrito, testeado, y se ajusta a la misma.

En la mayoría de los lenguajes de programación y especialmente en
lenguajes como
`node` hay dos niveles en el test: el
primero es el marco de pruebas y el segundo la biblioteca (o bibliotecas) de pruebas que
efectivamente se está usando. El marco de pruebas incluirá
generalmente un script que será el que ejecute
todos los tests, examine el resultado y emita un informe, que
dependerá de si los tests se han superado o no.

> Para ello, todas las bibliotecas de tests emiten sus resultados en un
> formato de texto estándar, que se llama [TAP](https://en.wikipedia.org/wiki/Test_Anything_Protocol). Por eso los marcos de
> pruebas se pueden usar con cualquier biblioteca de pruebas, incluso de
> cualquier lenguaje.

Por debajo del marco de pruebas (la biblioteca que permite estructuras
las pruebas), a veces existe una biblioteca de aserciones, que son las
diferentes pruebas unitarias que se deben pasar o no. En muchos casos,
la biblioteca de pruebas incluye ya aserciones; en otros casos,
bibliotecas de pruebas pueden trabajar con diferentes bibliotecas de
aserciones; en todo caso, lo que siempre existe es una biblioteca de
aserciones en todos los lenguajes de programación que permiten
comparar el resultado esperado con el resultado obtenido de diferentes formas.

Los tests unitarios deben ser, además, unitarios y valga la
redundancia. Dado que cada función debe tener una responsabilidad y
sólo una, esa única responsabilidad debe ser testeada desde el marco
de pruebas. Cada aserción debe
testear sólo una funcionalidad o característica, de forma que si falla
sepamos exactamente cuál ha sido. Además, si el lenguaje de
programación se organiza en subtests o funciones que testean algo,
cada función debe lanzar tests relacionados sólo con una
funcionalidad, si es posible, uno solo. De esa forma, cuando falla un
test sólo se tiene que arreglar lo relacionado con esa funcionalidad,
y no hay que buscar el error dentro de todas las que se están
testeando. El nombre de estas funciones, además, debe ser lo más
explícito posible, dejando totalmente claro lo que testea, si es
posible usando la misma frase que se use en la historia de usuario. 

## Fases de test: *setup*, *tests*, *teardown*.

En las fases del proceso de prueba:

* Planificación: en esta fase se decide cuantos tests se van a ejecutar.

* Durante el *setup* se crearán los objetos y cargarán los ficheros
  necesarios hasta poner nuestro objeto en un estado en el que se
  puedan llevar a cabo los tests. Esto puede incluir, por ejemplo,
  también crear esos objetos. En esta fase se pueden crear lo que se
  denominan *fixtures*: son simplemente objetos que, si no funciona su
  creación, algo va mal, pero si funciona se usan como base para el
  resto de los tests.
  
* A continuación se llevan a cabo las pruebas en sí; esas pruebas
  pueden estar agrupadas en subtests, y en el caso de que falle un
  subtest fallará el test del que depende completo.
  
* En la fase de *teardown* se limpia todo lo creado temporalmente, se
  cierran conexiones, y se deja al sistema, en general, en el mismo
  estado en el que estaba al principio.
  

Diferentes lenguajes tienen diferentes técnicas, más o menos formales,
para llevar a cabo las diferentes fases. Normalmente es parte de la
biblioteca de aserciones decidir si una parte del código se va a
ejecutar o no. Por ejemplo, en los [tests en Perl](t/proyecto.t) que
se pasan en este mismo repositorio, nos interesa ejecutar algunos sólo
cuando se trata de un `pull request`. Usamos esto:
			   
```
# Carga bibliotecas...

unless ( $ENV{'TRAVIS_PULL_REQUEST'} ) {
  plan skip_all => "Check relevant only for PRs";
}
# Resto del programa
```

En Perl se usa la biblioteca de aserciones `Test::More`. Por omisión,
se trabajará *sin plan* y los tests terminarán cuando se ejecute
`done_testing`. Se le puede decir también cuantos tests de van a
ejecutar; todo ello con la orden `plan`. Pero también se puede usar
esta orden para indicarle, como aquí, `skip_all`, que se salte los
tests a menos que (`unless`) Travis nos haya indicado (a través del
valor de una variable de entorno) que se trata de un `pull request`.

En la fase de planificación se deben decidir cuantos tests se van a
ejecutar. Aunque la respuesta obvia podría ser "todos", lo cierto es
que los tests van a variar dependiendo del entorno. Para empezar, hay
que decidir si va a haber algún plan (es decir, si sabemos de antemano
el número de tests) o simplemente se van a ejecutar a continuación
todos los tests que nos encontremos.


Tras la planificación, que es implícita en muchos marcos de tests y
bibliotecas, se ejecutará la fase de setup. Esta fase, en muchos
casos, se tratará
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

### Usando fixtures en Python
    
Python, a base de no querer extender la sintaxis, acaba añadiendo
conceptos y construcciones sintácticas para temas inesperados, como
por ejemplo los objetos que se crean en la fase de setup de los tests,
que se denominan *fixtures*, y tienen su sintaxis específica. Para
testear la clase `Issue` que hemos generado anteriormente, se usarían
fixtures de esta forma:
    
```Python
import pytest
from Project.Issue import Issue, IssueState

PROJECTNAME = "testProject"
ISSUEID = 1

@pytest.fixture
def issue():
    issue = Issue(PROJECTNAME,ISSUEID)
    return issue

def test_has_name_when_created(issue):
    assert issue.projectName  == PROJECTNAME

def test_has_id_when_created(issue):
    assert issue.issueId  == ISSUEID
    
def test_is_open_when_created(issue):
    assert  issue.state == IssueState.Open

def test_is_closed_when_you_close_it(issue):
    issue.close()
    assert  issue.state == IssueState.Closed

def test_is_open_when_you_reopen_it(issue):
    issue.reopen()
    assert  issue.state == IssueState.Open

```

`fixture` es una orden de pytest, y es un *decorador*, por eso lleva la arroba delante. En la práctica, crea un objecto del mismo nombre que la función que se decora que es el que vamos a usar en el resto de los tests, tal como se ve aquí. En este caso usamos la librería de aserciones de `pytest` también, ya puestos.


### Escribiendo tests en Go

[Go](https://golang.org/) es
un lenguaje que pretende evitar lo peor de C++ para crear un lenguaje
concurrente, de sintaxis simple y con más seguridad; además, Go provee
también un entorno de programación con una serie de herramientas
(*toolbelt*) de serie (su propio *task runner*). Go integra este marco de pruebas en el
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
ejecutar desde la línea de órdenes `go test` (que sería el marco de
pruebas en este caso), que devolverá algo así:

```
PASS
ok  	_/home/jmerelo/Asignaturas/infraestructura-virtual/HitosIV	0.017s
```

En vez de aserciones como funciones específicas, Go simplifica el
interfaz de pruebas eliminando las aserciones; por el contrario, hace que se devuelva un error (con `t.Error()`)
cuando el test no pasa. Si todos funcionan, no hay ningún problema y
se imprime `PASS` como se muestra arriba. Adicionalmente, `t.Log()`
(siendo `t` una estructura de datos que se le tiene que pasar a todos
los tests) se usa para mostrar algún mensaje sobre qué está ocurriendo
en el test. En este caso, uno de los tests comprueba que efectivamente
haya hitos en el fichero JSON que se ha pasado, y el segundo comprueba
que el tipo que se devuelve cuando se solicita un hito es el
correcto. 

>Los tests que se muestran aquí no cubren necesariamente todas las funcionalidades de este módulo; en el repositorio sí están completos. Se
>muestran solo estos para ilustrar cómo funciona en un lenguaje
>determinado.

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



## Actividad

A partir del diseño creado en la anterior actividad, y siguiendo las
prácticas de uso de los issues (y su cierre desde un *commit*), crear
una o varias clases básicas que correspondan a la misma entidad (según
el dominio del problema que se haya elegido), por supuesto incluyendo
los tests correspondientes. Los tests se ejecutarán en local, por lo
pronto.

Se editará el fichero `qa.json` añadiéndole, además, la siguiente clave (sin borrar las anteriores)

```json
{
  "test" : "directorio/fichero_de_test.ext"
}
```

En vez de este nombre ficticio, se usará el nombre del fichero de construcción que se haya usado para ejecutar los tests, que tendrá que estar presente en el repositorio.
