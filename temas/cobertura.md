# Tests de cobertura

## Planteamiento

Si el código no se ha probado, no funciona. Los tests de cobertura nos
ayudan a saber qué partes del código no están cubiertas por los tests
unitarios. Usarlos nos permitirá asegurarnos de que todo el código
funciona (y que hace lo que debe), estableciendo un nivel determinado
de cobertura, así como políticas sobre el mismo, para asegurar la
calidad del código.

## Al final de esta sesión

Se habrán incluido tests de cobertura en el proyecto y refactorizado
el código en caso necesario.

## Criterio de aceptación

Inclusión del badge de `codecov` con un porcentaje de cobertura aceptable.

## Tests de cobertura

Cuando se testea, se comprueba habitualmente el [*camino
feliz*](https://en.wikipedia.org/wiki/Happy_path), sin ningunos
errores o excepciones, todo según lo acordado. El código que
representa ese *happy path* normalmente está bien comprobado. Pero hay
[casos en el filo, o en la
esquina](https://medium.com/swlh/taking-the-edge-off-of-edge-cases-7b3008d83a57),
cuyo código en ocasiones no está testeado de forma tan extensiva.

Los tests de cobertura miden qué parte de nuestro código ha sido
ejercitada por los tests unitarios (que, recordemos, son de caja
blanca y por tanto se puede saber qué camino han seguido por el
mismo). Estos tests de cobertura funcionan tanto a nivel de línea,
como de función o de paquetes, pero generalmente van a dar un
porcentaje de líneas cubiertas por los tests unitarios.

Dependiendo del lenguaje, se hará con unas herramientas u otras. En
general, constarán de dos partes:

* Instrumentación para poder saber qué líneas se están ejecutando, y
  que genere un informe en algún formato estándar. Con este tipo de
  instrumentación, se ejecutarán los tests. La instrumentación puede
  ser una opción de compilación, opción de ejecución de la herramienta
  de tests, o alguna otra forma que permita trazar la ejecución del
  código y generar un informe. A partir de ahí, se generará un
  fichero.
* Visualizadores de los informes, que a partir del anterior lo pasan a
  HTML, por ejemplo.

Como en cualquier caso en programación ágil, conviene seguir una serie
de buenas prácticas, como [las indicadas en esta entrada del blog de
testing de
Google](https://testing.googleblog.com/2020/08/code-coverage-best-practices.html):

- No hay que intentar alcanzar el 100% de cobertura, pero sí conviene
  establecer niveles aceptables y niveles recomendables. Por ejemplo,
  en Google consideran 60% aceptable, y un 90% excelente. En general,
  lo importante es las prácticas que emergen de intentar cubrir todos
  los casos posibles mediante el test, más que el hecho de tenerlo
  todo cubierto en sí. Además, identificar qué partes del código no se
  están testeando pueden contribuir a ver qué partes del código es
  *legacy* y ya no se usa.
- La buena práctica en general es usar el flujo TDD: escribir tests
  antes que el código. De esa forma, se garantiza que sólo se escribe
  el código para que pase los tests y la cobertura siempre va a ser
  100%. Sin embargo, las bases de código evolucionan y por eso puede
  haber casos no cubiertos por test. Hacer tests de cobertura te sirve
  para identificar esas zonas de código.
- También puede significar un beneficio en proyectos open source:
  cuando se añade nuevo código mediante un PR, se puede estimar cómo
  ha variado la cobertura. En general, todo código nuevo añadido
  debería estar testeado, por lo que el nivel de cobertura no debería
  variar.
- La cobertura de código se puede usar en combinación con un
  *profiler* para tener un conocimiento dinámico más exhaustivo del
  código, los caminos de código que se siguen, e identificar posibles
  cuellos de botella.

### Tests de cobertura en Go y cómo usarlos para mejorar el código.

En Go, por ejemplo, es parte de la instrumentación del propio lenguaje.

```
go test -coverprofile=coverage.out
go tool cover -html=coverage.out
```

La primera ejecuta los tests y genera un fichero de salida con el
nombre indicado, y la segunda orden abre un navegador con una página
en la que nos muestra nuestro código y la cobertura que tiene,
señalando las funciones y líneas que no están cubiertas. Sobre la
clase [`HitosIV` que ya hemos usado
anteriormente](https://github.com/JJ/HitosIV), estos serían los
resultados.

![Cobertura de los tests en la clase HitosIV](img/gocover.png)

En este caso, las líneas no cubiertas eran las que lanzaban errores en
caso de que se encuentren algún problema; efectivamente, como se ha
comentado en la introducción, el código fuera del *camino feliz* que
no se estaba mirando. No siempre es obligatorio
que cubrir el 100% de las de las líneas (por ejemplo, generar un JSON
erróneo a ver si salta la segunda), pero quizás la primera sí merece
la pena que se cubra, así que se añade un test adicional, pero debemos
[modificar ligeramente el
código](https://stackoverflow.com/a/46841524/891440) para asegurar que
sigue las mejores prácticas del lenguaje:


![Nueva cobertura de los tests en la clase HitosIV](img/gocover-2.png)

Siempre es mejor en Go devolver un error que enviar a registro un
error fatal (sin hacer nada más) o lanzar un *panic*, así que este
cambio en el código asegura que se pueda cubrir mejor con los tests.

> Y también demuestra que la calidad en el desarrollo no es siempre
> cuestión de escribir más o menos tests, sino de seguir buenas
> prácticas en el diseño de aplicaciones para que estos tests sean
> posibles y tengan la máxima cobertura.

En Go se ejemplifican las dos partes de los tests de cobertura: el
generador de datos, y el que crea los informes. En casi todos los
lenguajes va a ocurrir lo mismo, sólo que no va a estar integrado con
el lenguaje, sino que va a ser una o dos utilidades aparte del
compilador. Por ejemplo, en TypeScript


### Tests de cobertura en TypeScript

En `jest`, que hemos usado anteriormente con TypeScript, también está
incluido un sistema de tests de cobertura. Por ejemplo, si lo
aplicamos a la última versión de
nuestro [sistema de hitos](https://github.com/JJ/ts-milestones),
obtendremos un resultado como este ejecutando `jest --coverage`:

```
 PASS  src/__tests__/all_test.ts
  ✓ Issue (3ms)
  ✓ Milestone (3ms)

------------|----------|----------|----------|----------|-------------------|
File        |  % Stmts | % Branch |  % Funcs |  % Lines | Uncovered Line #s |
------------|----------|----------|----------|----------|-------------------|
All files   |      100 |    83.33 |      100 |      100 |                   |
 Project.ts |      100 |    83.33 |      100 |      100 |                31 |
------------|----------|----------|----------|----------|-------------------|
Test Suites: 1 passed, 1 total
Tests:       2 passed, 2 total
Snapshots:   0 total
Time:        1.263s
Ran all test suites.
```

En este caso se indica que la cobertura de ramas es del 83%, lo que
puede oscilar entre lo inaceptable y totalmente aceptable. Por eso
tenemos que usar otro sistema que genere una página web en la que se
pueda ver claramente qué ha fallado, y ese sistema está integrado
dentro
de otro marco de tests, llamado 
[`istanbul` y se llama `nyc`](https://www.npmjs.com/package/nyc). Primero,
habrá que ejecutar `jest` lanzándolo desde `nyc`, y a continuación

```
nyc report --reporter=html
```

Dentro de la carpeta `coverage` se generarán una serie de ficheros
HTML donde podremos consultar qué es lo que ocurre. Esto se puede
añadir al sistema donde se haga integración continua, como en este
caso
a
[GitHub Actions](https://github.com/JJ/ts-milestones/blob/master/.github/workflows/coverage.yml).

```yaml
name: Pasa tests de cobertura
on: [push]

jobs:
  build:
    name: Cobertura
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v1
        with:
          fetch-depth: 1
      - name: Instalación general
        run: npm install
      - name: Instala tests y cobertura
        run: sudo npm install -g jest nyc codecov
      - name: Ejecuta tests de cobertura
        run: nyc jest --coverage
      - name: Crea los informes
        run: nyc report --reporter=json > coverage/coverage.json
      - name: Sube los tests
        run: codecov
```

Los tres últimos pasos son los que ejecutan los [tests de
cobertura](https://github.com/JJ/ts-milestones/commit/599e3f41ed6314f23603862b5da5079358df61c6/checks?check_suite_id=299177238)
y los suben [a
codecov](https://codecov.io/gh/JJ/ts-milestones/src/master/src/Project.ts). La
cobertura es del 100%, así que no hay mucho que mejorar aquí.

> Se puede configurar GitHub para que en los pull requests sólo acepte
> uno si no empeora la cobertura, lo que es razonable. Si el código
> añadido tiene una parte no testeada, es que no es correcto.


## Actividad


En el hito número 13, añadir los tests de cobertura al proyecto.

* Darse de alta en [codecov](https://about.codecov.io/) o algún sitio similar.
* Añadir tests de cobertura al ejecutor de tareas y a la configuración
  del servicio de integración continua.
* Añadir API key al servicio de integración continua (desde la web) y subir automáticamente los
  tests de cobertura a la misma tras cada test.

Se tendrán que añadir instrucciones en el README también sobre cómo
ejecutar los tests de cobertura, usando el target `coverage`; se
comprobará que la cadena `ejecutor-de-tareas coverage` esté en el
`README.md`.

También se comprobará que el badge de `codecov` esté presente en el
`README.md`. El porcentaje de cobertura deberá ser una cantidad
aceptable, acordada por los miembros del equipo.
