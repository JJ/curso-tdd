# Tests de integración.

## Planteamiento

Mientras que los test unitarios se plantean a nivel de clase o de
función, los tests de integración o funcionales, también llamados *end to end*, comprueban cómo se
integran varias clases en programas de orden superior y cómo se
integran estos con diferentes servicios: bases de datos y APIs que se
inyecten a las clases, por ejemplo.

Aunque las técnicas básicas que se usan para este tipo de pruebas, es decir, aserciones y marcos de prueba, son
las mismas, la implementación, en general, será diferente y sobre todo
habrá técnicas específicas para simular partes de la aplicación que no
estén todavía programadas o donde sea complicado o pesado testear a la
vez.

## Al final de esta sesión

El proyecto tendrá funcionalidad adicional, tal como acceso a datos, integrará varias clases o
servicios e incluirá los tests correspondientes para probar que
efectivamente funciona.

## Criterio de aceptación

El repositorio tiene que estar corriendo los tests en Travis, y esos
tests deben pasar.

## Tests funcionales y de integración

Los tests de
integración
[prueban grupos de módulos y clases](https://en.wikipedia.org/wiki/Integration_testing) como
una sla unidad, de forma que se compruebe que los requisitos funcionales
expresados en las historias de usuario, se cumplan.

En general, los tests de integración son de tipo [caja negra](https://searchsoftwarequality.techtarget.com/answer/Integration-testing-Is-it-black-box-or-white-box-testing), 
es decir, no pretendemos conseguir una cobertura total de todo el
código de lo que estamos integrando (como en el caso de los tests
unitarios). Lo que nos interesa es que el código añadido se *integre* bien con nuestro propio software.


> Consultad [esta pregunta en SO](https://stackoverflow.com/questions/2741832/unit-tests-vs-functional-tests)
> para entender las diferencias entre tests unitarios y de integración
> o funcionales.

Los tests de integración, a nivel básico, usan las mismas técnicas que los tests unitarios: aserciones y marcos de test. Únicamente se diferencia en lo que se va a sondear. Por ejemplo, escribiremos una serie de tests para comprobar que el API de una clase de la que dependemos no ha variado, y lo haremos al nivel más alto posible.

El objetivo de los tests de integración es tanto comprobar que nuestro código funciona correctamente con ellos, como cerciorarse de que el API de lo integrado sigue siendo el mismo. Si mantenemos nuestro código con la última versión de los módulos de los que depende, conviene comprobar esta estabilidad del API. Y, por otro lado, también es conveniente que cuando se cambia la versión de alguno de los servicios subyacentes, como el lenguaje, se compruebe que lo integrado y la relación de nuestro código con el mismo sigue funcionando de la misma forma.

En el programa en Raku anterior, por ejemplo, necesitamos conocer las estadísticas de issues cerrados de cada uno de los hitos. Añadimos esta función a [`Project.pm6`](../code/lib/Project.pm6):

```
use Stats;
# Más cosas
method completion-summary() {
    my %percentage-completed = self.percentage-completed();
    return summary( %percentage-completed.values.list );
}
```

La función `summary` está en el módulo `Stats`, que es un módulo externo. Tendremos que escribir los tests de integración correspondientes:

```
my $summary = $p.completion-summary();
isa-ok( $summary, List, "Returns a hash");
isa-ok( $summary[0]<mean>, 0.5, "Returns correct average");
```

Estos tests están enfocados principalmente a evitar que el API de la
         clase integrada derive a algo diferente, por ejemplo
         devolviendo un objeto de una clase diferente. Los APIs
         cambian, y lo pueden hacer de forma inesperada, así que
         primero nos aseguramos de que lo que devuelve tiene el tipo
         correcto, y luego que la media está en el primer elemento de
         la lista y devuelve también el valor correcto. 

> El interfaz de esta clase es, en realidad, un poco peculiar, porque sería más adecuado devolver un hash. En un momento determinado, puede que se dé cuenta el propietario y lo cambie, con lo cual este test de integración nos guarda de que tal cosa ocurra.


## Tests de integración para microservicios

Los tests de microservicios también se denominan [test
         funcionales](https://en.wikipedia.org/wiki/Functional_testing),
         porque
proporcionamos una entrada y comprobamos que las salidas son
         correctas, pero también son de integración porque un API,
generalmente, va a integrar diferentes clases y el testear el API REST
va a ser una prueba de cómo se *integran* esas diferentes clases entre
sí, o como se integran con los servicios que se usan desde las clases;
de lo que se
trata es que tenemos que levantar la web y que vaya todo medianamente
bien. Sin embargo, las funciones a las que se llama desde un servicio
web son en realidad simples funciones, por lo que hay tanto marcos
como bibliotecas de test que te permiten probarlas.

Para hacer esas pruebas generalmente se crea un objeto cuyos métodos
son, en realidad, llamadas al API REST, o un objeto al que se le puede añadir un
 decorador que permite hacer tales llamadas. Este objeto tendremos que
primero crearlo desde nuestro "programa principal" o (mejor) módulo que responde
 a las
peticiones REST, y segundo importarlo desde el test. En el caso de
`express`, se crea un objeto `app`, que será el que usemos aquí.

Los tests podemos integrarlos, como es natural, en el mismo marco que
el resto de la aplicación, solo que tendremos que usar librerías de
aserciones ligeramente diferentes, en este caso `supertest`

```
var request = require('supertest'),
app = require('../index.js');

describe( "PUT porra", function() {
	it('should create', function (done) {
          request(app)
		.put('/porra/uno/dos/tres/4')
		.expect('Content-Type', /json/)
		.expect(200,done);
	});
});
```

(que tendrá que estar incluido en el directorio `test/`, como el
resto). En vez de ejecutar la aplicación (que también podríamos
hacerlo), lo que hacemos es que añadimos al final de `index.js` la
línea:

```
module.exports = app;
```

con lo que se exporta el objeto `app` que se crea; los métodos de ese objeto
recibirán las peticiones del API REST que vamos a comprobar; `require`
ejecuta el código y recibe la variable que hemos exportado, que
podemos usar como si se tratara de parte de esta misma
aplicación. `app` en este test, por tanto, contendrá lo mismo que en
la aplicación principal, `index.js`. Usamos el mismo estilo de test
con `mocha`
que [ya se ha visto](https://jj.github.io/desarrollo-basado-pruebas/)
pero usamos funciones específicas:

* `request` hace una llamada sobre `app` como si la hiciéramos *desde
  fuera*; `put`, por tanto, llamará a la ruta correspondiente, que
  crea un partido sobre el que apostar.
* `expect` expresa qué se puede esperar de la respuesta. Por ejemplo,
  se puede esperar que sea de tipo JSON (porque es lo que enviamos, un
  JSON del partido añadido) y además que sea de tipo '200', respuesta
  correcta. Y como esta es la última de la cadena, llamamos a `done`
  que es en realidad una función que usa como parámetro el callback.

Podemos hacer más pruebas, usando `get`, por ejemplo, pero se deja como ejercicio al alumno.

Estas pruebas permiten que no nos encontremos con sorpresas una vez
que despeguemos en el PaaS. Así sabemos que, al menos, todas las rutas
que hemos creado funcionan correctamente.

## Inversión de dependencias y cómo llevarla a cabo.

Para testear el acceso a datos y otras dependencias externas correctamente, y
siguiendo los principios de diseño SOLID que se vieron anteriormente, se debe
desacoplar las clases de su almacenamiento o serialización; para ello se usa el
principio de inversión de dependencias, es decir, las dependencias no las tienen
 las clases y éstas no dependen, en realidad, de ellas, y la inyección de
 dependencias, por las que se añaden a una clase objetos que permitan usar las
 funcionalidades de esas dependencias, pero siguiendo un interfaz abstracto.

Hagamos primero una pequeña desviación para hablar de cómo funcionarían esos
Interfaces abstractos.

### Roles o mixins

En general, los roles o mixins se componen de un interfaz y, en ocasiones, de
una implementación. Se usan en *composición* de objetos: un objeto compone, o
implementa, diferentes roles, tomando todos los métodos y atributos de cada uno
de los roles que componga.

Es una técnica de programación dirigida a objetos alternativa a la herencia para
 creación de nuevas clases. Mientras que en la herencia se heredan los atributos
  y métodos públicos, que se extienden o reimplementan, en composición se
  incluye en la clase así creada tanto el interfaz como la implementación,
  permitiendo creación de objetos más complejos con la característica principal
  de tener el mismo API que los roles que lo componen.

Por ejemplo, podemos definir este rol en Raku:

```Perl6
unit role Project::Dator;

method load() {...}
method update( \data ) {...}
```

Los `{...}` indican que, quien quiera que implemente ese rol, tiene forzosamente
 que implementar estos métodos. Este rol define solamente un interfaz, pero como
  las funciones son abstractas, sabemos que quien quiera que implemente ese rol
  va a tener esas dos funciones. Podemos implementarlo en una clase, por
  ejemplo:

```
use JSON::Fast;

use Project::Dator;

unit class Project::Data::JSON does Project::Dator;

has $!file-name;
has $!data;

method new( $file-name where $file-name.IO ~~ :e ) {
    return self.bless( :$file-name, data => from-json slurp $file-name );
}

submethod BUILD( :$!file-name, :$!data) {}

method load() { $!data }
method update( \data ) { $!data = data }
```

Esta clase `does` el rol anterior, e implementa los dos métodos que tiene que
implementar obligatoriamente. El principio de sustitución de Lyskov se aplica
también aquí: donde quiera que usemos un rol, se puede usar también cualquier
clase que implemente ese rol, por lo que podemos declarar argumentos como
`Project::Dator` sabiendo que vamos a poder usar esas dos funciones, `load` y
`update`.

### Inyectando dependencias

Este principio se basa en el uso, dentro de las clases que necesitan las
dependencias, de objetos que representen estas dependencias. Si representamos
estas dependencias implementan un rol, podemos intercambiarlas fácilmente sin
que la clase que los usa lo detecte.

Por ejemplo, podemos hacerlo en esta clase, `Project::Stored`:

```
unit class Project::Stored does Project;

has Project::Dator $!dator;

# Código de la clase aquí abajo
```

`Project` lo hemos convertido también en un rol para que sea más fácil
componerlo en otras clases; `Project`, como tal rol, se comporta de la misma
forma que una clase si se le usa en este contexto, pero haciéndolo así es más
fácil usar todas las variables privadas, que pasan directamente a formar parte
de la nueva clase. Dentro de esa clase, sin embargo, tenemos a `$!dator`, que
implementa el rol `Project::Dator` y por tanto se puede instanciar con cualquier
 tipo de objeto que siga ese rol.

La inyección de dependencias puede funcionar de esta forma:

```
my $dator = Project::Data::JSON.new($data-file);
my $stored = Project::Stored.new($dator);
```

En esta nueva clase tendremos que adaptar las funciones para usar este tipo de
almacenamiento de datos, pero en principio va a ser posible hacerlo sin mucho
problema.

Si queremos imitar ese almacenamiento, simplemente tenemos que usar el mismo
rol:

```perl6
unit class Project::Data::Mock does Project::Dator;

has $!data = { "milestones" => [
    {
        "2" => [
            {
                "4" => "Closed"
            },
            {
                "3" => "Open"
            }
        ]
    }
    ],
    "name" => "Foo"
};
```

Se puede instanciar este objeto exactamente de la misma forma para "imitar" la
clase original que da acceso a datos:

```perl6
$dator = Project::Data::Mock.new;
$stored = Project::Stored.new($dator);
```


Este concepto de *mock* o maqueta se puede extender también a cualquier tipo de
objeto que se use para imitar instancias de objetos que no tienen por qué estar
presentes en el momento del test.

> Por ejemplo, [este artículo](https://medium.com/@yeraydiazdiaz/what-the-mock-cheatsheet-mocking-in-python-6a71db997832)
muestra de forma extensa cómo usar mocks en Python. Algunos frameworks como Jest
 permiten también hacer [mocks de forma sencilla](https://jestjs.io/docs/es-ES/manual-mocks).

## Actividad


En esta actividad se añadirán tests de integración a la clase que se haya creado
 en el hito anterior. Estos tests de integración pueden ser uno o varios de los
 siguientes:

* Integración de un módulo que se vaya a usar desde el nuestro.
* Creación de un servicio web a partir de la clase, y prueba del mismo.
* Integración de un servicio de datos, usando inyección de dependencias.
