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

El proyecto tendrá funcionalidad adicional, integrará varias clases, incluyendo posiblemente módulos externos, y tendrá los tests correspondientes para probar que
efectivamente funciona.

## Criterio de aceptación

El repositorio tiene que estar corriendo los tests en Travis, y esos
tests deben pasar.

## Tests funcionales y de integración

Los tests de
integración
[prueban grupos de módulos y clases](https://en.wikipedia.org/wiki/Integration_testing) como
una sola unidad, de forma que se compruebe que los requisitos funcionales
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

Los tests de microservicios también se denominan [test funcionales](https://en.wikipedia.org/wiki/Functional_testing),
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


## Actividad


En esta actividad se añadirán tests de integración a la clase que se haya creado
 en el hito anterior. Estos tests de integración pueden ser uno o varios de los
 siguientes:

* Integración de un módulo que se vaya a usar desde el nuestro.
* Creación de un servicio web a partir de la clase, y prueba del mismo.


Como en los hitos anteriores, tendrá que, con los nuevos tests, seguir pasando los tests de cobertura y pasar los tests en Travis.

