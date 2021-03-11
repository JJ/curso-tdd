# Integración continua


## Planteamiento

Los sistemas de integración continua forman parte de los flujos de trabajo
en equipos ágiles, ejecutando
automáticamente las pruebas que se le configuren cada vez que se lleva
a cabo un `push` o un `pull request`.

> O, para el caso, cualquier tipo de evento en el servidor del equipo
> o localmente.

A su vez, estos sistemas dan
retroalimentación al alojamiento del repositorio de forma que, en caso
positivo, se realice el siguiente paso en el pipeline, por ejemplo
desplegar a producción; por eso se llaman en general sistemas CI/CD,
incluyendo *continuous delivery*, o despliegue continuo.

## Al final de esta sesión

El estudiante entenderá los criterios para elegir un sistema de
integración continua, y sabrá configurar uno (o varios) para poder
ejecutar los tests automáticamente en el mismo. También habrá
entendido los mecanismos que hacen que se ejecuten estos tests
automáticamente.

## Criterio de aceptación

El repositorio tiene que estar corriendo los tests unitarios
desarrollados anteriormente en algún sistema de integración continua a
elegir por el estudiante.

## Concepto de integración continua

A un primer nivel, la [integración
continua](https://www.martinfowler.com/articles/continuousIntegration.html)
consiste en incluir en la rama principal los cambios hechos por un
miembro del equipo en el momento que estén hechos y pasen los tests.

> En general, no se desarrollará directamente trabajando sobre la rama
> máster del repositorio, pero hay diferentes metodologías y no nos
> vamos a meter en eso. En general, en todo caso, habrá o un pull
> request a la rama máster o un push a la rama master y en ese momento
> se tendrán que ejecutar automáticamente los tests.

Se denomina continua porque implica una mejora atómica (de un pequeño
átomo, vamos) de la base de
código, y prueba y despliegue para cada uno de los pequeños cambios o
arreglos que se hagan en el mismo, oponiéndose a ciclos de integración
en los que el código se desarrollo de forma independiente de los
tests, que se ejecutan al final de un ciclo de desarrollo.

Esto implica también la ejecución automática de tests. Hay diferentes
maneras de hacerlo, como veremos a continuación, pero todos se basan
en un mecanismo similar.

## Pasando los tests automáticamente en la nube.

Muchos equipos de desarrollo instalan
[*hooks*](tests-unitarios#hooks-o-ganchos-de-git) con comprobaciones
básicas durante los mensajes de commit e incluso antes de hacer push a
una rama o a máster; en general, sin embargo, se usará algún *hook* en
el servidor que los ejecutará cuando se envíe un pull al mismo.

A diferencia de los *hooks* locales, que se ejecutan en el mismo
entorno de desarrollo que el que está usando quien lo desarrolle, para
los remotos habrá que crear una configuración para que ejecute esos
tests y nos diga cuáles han pasado o cuales no. Estas máquinas más
adelante se combinan con las de despliegue continuo, no permitiendo el
mismo si algún test no ha pasado.

En general, la integración continua se hace *en la nube*, por el
simple hecho de que los equipos de desarrollo están distribuidos y
también los repositorios suelen ser servicios externos a los
ordenadores de la empresa; lo que no quiere decir que se haga siempre
en un servicio *cloud* contratado, sino porque se suele hacer en
máquinas dedicadas específicamente para ello; es más general, sin
embargo que una máquina virtual se descarga los ficheros, ejecuta los
tests y crea un informe, enviando también un correo al autor
indicándole el resultado. Por tanto, para que haga esto tenemos que
indicar en la configuración todo lo necesario para ejecutar los tests
y, posiblemente, nuestro programa: aplicaciones, librerías que
necesita nuestro programa, aparte de la configuración que tendrá el
programa en sí con las librerías del lenguaje de programación en el
que está desarrollado.

Un sistema bastante popular de integración continua es
[Jenkins](https://jenkins.io/). Jenkins lo puedes usar en la nube o
instalarte tu propio ordenador para hacerlo. Sin embargo, está
enfocado sobre todo a Java (y no hay un servicio gratuito que se pueda
ejecutar) por lo que recomendamos, al menos para empezar, otros
sistemas como [Travis](https://travis-ci.org) o
[Shippable](https://www.shippable.com/) que podemos usar también desde
la nube y, además, están preparados para más lenguajes de
programación.

Para trabajar con un sistema de CI hay que hacerlo en varios
pasos

1. Darse de alta. Muchos están conectados con GitHub por lo que puedes
   usar directamente el usuario que tengas ahí. A través de un proceso de
   autorización, acceder al contenido e incluso informar del resultado
   de los tests.

2. Activar el repositorio en el que se vaya a aplicar la integración
   continua. Travis permite hacerlo directamente desde tu
   configuración; en otros se dan de alta desde la web de GitHub;
   también en algunos casos todos los repositorios estarán autorizados
   con sólo autorizar el usuario. Por supuesto, en el caso de GitHub
   Actions y *GitLab pipelines* no hace falta llevar a cabo este paso.

3. Crear un fichero de configuración con la configuración necesaria
   para ejecutar estos tests y añadirlo al repositorio. En sistemas de
   CI integrados en un repositorio, como GitHub actions, este paso es
   el único necesario.


Los ficheros de configuración de las máquinas que ejecutan los
servicios de integración continua corresponden, aproximadamente, a una
configuración de una máquina virtual que se dedicara solo y
exclusivamente a llevar a cabo la ejecución de los tests. Por ello las
órdenes del mismo son equivalentes a una provisión de una máquina
virtual (o contenedor), a la que tras el sistema operativo se le
instala lo necesario, indicado en el fichero de configuración tal como
este para Travis.

> Que no es que aconsejemos travis exclusivamente, sobre todo ahora
>	que tiene los créditos muy limitados. Pero fue uno de los primeros
>	que se creó, y si se usa con prudencia, es bastante útil
    
```
	language: node_js
	node_js:
	  - "10"
	  - "11"
	  - "12"
	before_install:
	  - npm install -g mocha
	  - cd src; npm install .
	script: cd src; mocha
```


Este fichero, denominado `.travis.yml`, contiene lo siguiente:

- `language` indica qué lenguaje se va a usar. Travis tiene
  [varios lenguajes](https://docs.travis-ci.com/user/getting-started/),
  incluyendo por supuesto nodejs. Las máquinas virtuales no suelen
  estar configuradas para lenguajes arbitrarios, aunque por supuesto
  se puede poner un lenguaje tal como C y luego descargar lo necesario
  para otro lenguaje. Con `language: minimal` no se cargará nada
  adicional y se usarán sólo las utilidades que el contenedor donde se
  ejecuta traiga instaladas (por ejemplo, make o git). Si se pone
  `minimal` como lenguaje, hay algunos instalados que se pueden usar,
  aunque sin versiones, por ejemplo Perl o Python.

- `node_js` en este caso indica las versiones que vamos a probar. Por
  el mismo precio podemos probar varias versiones, en este caso las
  últimas de node.

- `before_install` se ejecuta antes de la instalación de la aplicación
  (específica de cada lenguaje; por ejemplo en el caso de node.js
  sería `npm install .`. En nuestro caso tenemos que instalar `mocha`
  y además ejecutar este último paso en un subdirectorio que no es
  estándar.

- Finalmente, se ejecuta el script de prueba en sí (para el caso,
  cualquier cosa que quieras ejecutar). Una vez más, nos cambiamos al
  subdirectorio y ejecutamos `mocha` tal como lo hemos hecho
  anteriormente.

Esta configuración no es completa ni mínima. En general, para cada
lenguaje habrá una serie de instrucciones estándar que se ejecutarán
con sólo especificar el lenguaje y la versión; también hay otros
apartados de configuración que conviene mirar en la web de Travis.
El resultado
[aparecerá en la web](https://travis-ci.org/JJ/desarrollo-basado-pruebas)
y también se enviará por correo electrónico. Y te da también un
*badge* que puedes poner en tu fichero para indicar que, por lo
pronto, todo funciona.

Si el informe indica que las pruebas son correctas, se puede proceder al despliegue. Pero eso
ya no corresponde a este capítulo.

Esta configuración es esencial por varias razones: primero, porque nos
permite ser conscientes de todo lo necesario para desplegar nuestra
aplicación. Segundo, porque al crear tests integramos el paso de
control de calidad en el desarrollo. Y, finalmente, porque la
integración continua y los tests correspondientes son un paso esencial
para el despliegue continuo.

Desde 2018 que salieron de beta, por sus límites generosos, por su
buena integración con GitHub y en general porque simplemente son
prácticas (aunque tienen sus problemas) se están imponiendo hoy en día
las [GitHub Actions (GHA)](https://github.com/features/actions). En general,
GHA son un sistema de flujos de trabajo activados por eventos en el
repositorio, una parte relativamente pequeña de los cuales son los
push y pull requests. Siguen un esquema habitual en este tipo de
herramientas (similar a los *pipelines* en GitLab, por ejemplo). Una
*action* se activa por una serie de eventos, que se tienen que
definir, filtrando también por el contenido del repositorio que ha
cambiado (ficheros, ramas o tags, por ejemplo). Una acción contiene
varios *jobs*, cada uno de los cuales usa un runner diferente y en
principio es independiente del resto (aunque es fácil pasar
información de un *job* a otro dentro de la misma *action*). Cada
*job* puede tener información común (como variables de entorno), y se
divide en diferentes *steps*. Los *steps* se ejecutan dentro de la
misma MV o contenedor, aunque en diferentes shells, por los que habrá
que re-declarar las variables de entorno si las queremos. Cada uno de
estos pasos se puede o programar directamente sobre el runner (usando
aluno de los shells incluidos en el runner, como Perl o bash) o usar
una *action* externa (sí, el nombre es confuso, porque *actions* en el
*marketplace* son pasos aquí). Veamos un ejemplo:

```yaml
name: "Test Nim"
on:
  push:
    paths:
      - "ejemplos/nim/**"
  pull_request:
    paths:
      - "ejemplos/nim/**"

jobs:
  test-nim:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v2
      - uses: jiro4989/setup-nim-action@v1
        with:
          nim-version: '1.4.0' # default is 'stable'
      - run: cd ejemplos/nim && nimble test -Y

```

Esta GHA pasa los tests a los [ejemplos en Nim](../ejemplos/nim) de
este repositorio. Por eso filtra sólo los ficheros de esos directorios
(con `**` se indica que es cualquier fichero a cualquier
profundidad). Está declarada sólo cuando se hace push o pull request
(es decir, no cuando se crea un issue, por ejemplo), usa como *runner*
la última versión de Ubuntu (por lo pronto la 18.04, pronto la
20.04). Usa una action externa para instalar nim (que esencialmente
usa `choosenim` para instalar una versión en espacio de usuario) y
finalmente, con `run` pasa los tests. Cada paso tiene esas claves
estándar, aparte de `name`, que aquí no hemos usado. Hay más ejemplos
en [el directorio de workflows](../.github/workflows), que ejercen
tanto como tests, como creando otros workflows para diferentes labores
administrativas.

## Acelerando los tests

Es conveniente que los tests tarden la mínima cantidad de tiempo
posible, para que se pueda comprobar que existe algún error sobre la
marcha y se pueda corregir. Sin embargo, cualquier test va a necesitar
instalar una serie de prerrequisitos (módulos dependientes, por
ejemplo) antes de ejecutarlos, así que la descarga e instalación de
paquetes y módulos, y en algunos casos incluso la compilación de algún
prerrequisito necesario, va a tardar algún tiempo. Acelerar los tests
hasta que tarden menos (incluso bastante menos) de un minuto es
esencial para un trabajo fluido, que permita corregir sobre la marcha
errores antes de continuar trabajando.

Hay muchas formas de conseguir que estos tests vayan más rápidamente,
que pasan generalmente por crear un testeador específico con todo lo
necesario para ejecutarse, y que no haya más que instalarlo. Veamos
varias opciones.

### *Packing*

Muchos lenguajes tienen programas que permiten *empaquetar* todos los
fuentes necesarios para un programa en un solo fichero, con lo que
solo con la descarga de ese fichero, o su inclusión en el repositorio,
tendríamos todo lo necesario para testear (o para lo que se quiera la
aplicación). Por ejemplo, Perl
tiene [`FatPacker`](https://metacpan.org/pod/App::FatPacker), Python
tiene [`wheels`](https://pythonwheels.com/) y node
tiene [WebPack](https://webpack.js.org/).

Esto es lo que uso, por ejemplo, en la asignatura [CC](https://jj.github.io/CC):

```
fatpack pack src/check-hitos.t > t/check-hitos.t
```

El fichero resultante, que incluye todas las bibliotecas necesarias,
está ya en el repositorio y se ejecuta directamente sin necesidad de
usar CPAN (el sistema de instalación de módulos en Perl) para instalar
los módulos necesarios.

Esto solo funciona en caso de que todas las dependencias sean
bibliotecas del lenguaje. Si no es así, hay que usar otro sistema.

### Contenedores Docker

Crear un contenedor Docker para testear nunca es una mala idea. Para
empezar, muchos sistemas de CI (como CircleCI) directamente usan este
tipo de herramientas y lo primero que hay que hacer para configurarlo
es elegir el contenedor Docker sobre el que se va a basar la
prueba. Un contenedor [Docker](https://www.docker.com/), en una sola
imagen, tiene toda la infraestructura necesaria para ejecutar o
testear una aplicación. Además, el mismo contenedor que se usa para
hacer las pruebas (o su precursor) se puede usar también  para
desplegar la aplicación.

> Explicar el concepto de contenedor Docker es muy extenso para este
> curso. Nos quedaremos con la idea y sintaxis básica y dejamos
> recomendado un curso o cursos sobre esta materia, imprescindible
> para la programación moderna.

Por ejemplo, usaremos el contenedor generado por este Dockerfile para
testear los proyectos (y ortografía) en este curso:

```
FROM jjmerelo/perl-test-text
LABEL version="1.0" maintainer="JJ Merelo <jjmerelo@GMail.com>" perl5version="5.22"

WORKDIR /home/install
ADD cpanfile .
RUN apt-get update && apt-get install -y git
RUN cpanm --installdeps .

VOLUME /test
WORKDIR /test

ENTRYPOINT cp /home/install/data/*.dic /home/install/data/*.aff /test && prove -I/usr/lib -c
```

Si el fichero es compacto, es porque previamente se ha generado un
contenedor anterior, `jjmerelo/perl-test-text`, que incluye el módulo
que comprueba la ortografía (`Test::Text`); lo que hay que añadir solamente son lo
necesario para testear en sí los proyectos enviados, que es el test
adicional que se lleva a cabo. Estos proyectos necesitarán una
instalación de `git`, y también una serie de módulos de Perl
adicionales; las dos sentencias `RUN` llevan a cabo esa labor. 

El `ENTRYPOINT` es lo que se va a ejecutar; tras copiar una serie de
ficheros que son necesarios en el mismo directorio donde se va a
ejecutar, llama al marco de test de Perl, llamado `prove`. 

A diferencia de los paquetes anteriores, que van en el repositorio,
normalmente los Dockerfiles no se ejecutan directamente (salvo en
GitHub Actions). Habrá que subirlos al Docker Hub, pero es
gratuito para proyectos de software libre. Travis (o el sistema que sea) lo descargará de ese registro
en la fase correspondiente antes de aplicarlo a tu repositorio.

> Esa descarga puede tardar también algunos segundos, porque un
> contenedor puede tener varios cientos de megas, dependiendo de la
> base sobre la que lo construyas. Hacer un
> contenedor lo más ligero posible es también conveniente.

Esto se incluirá en la configuración de Travis, que además se
simplifica considerablemente:

```
language:
  - minimal

install:
  - docker pull jjmerelo/p5-devqagrx:latest
  - docker images

script: 
  - docker run -t -v  $TRAVIS_BUILD_DIR:/test jjmerelo/p5-devqagrx:latest
```

Esta configuración simplemente descarga de Docker Hub durante la fase
de instalación y lo ejecuta durante la fase `script` en la que se
llevan a cabo los tests. `docker images`, de hecho, no hace falta.

> Como desventaja, con Docker hay que preparar contenedores diferentes
> para probar versiones diferentes del lenguaje; si este paso es
> imprescindible, mejor entonces usar algún "packer" para empaquetar
> los tests.

### Otras formas de acelerar el sistema de integración continua

Travis y el resto de los sistemas de CI suelen tener una forma rica de
configurar la construcción y los tests. Por ejemplo, se pueden asignar
diferentes valores a variables de entorno desde él, y hacer que se
ejecuten diferentes tests dependiendo del valor de las mismas. Usando
una característica llamada *build matrix*, se puede hacer que estos
diferentes valores se ejecuten en paralelo, o al menos empiecen antes
de que el anterior acabe. También se pueden hacer tests diferentes en
diferentes sistemas de CI; cada uno lo lanzará cuando deba, y todos se
estarán ejecutando simultáneamente.

Otras formas de acelerar las pruebas:

* Usar una [caché](https://docs.travis-ci.com/user/caching/). Muchos
  sistemas de CI te permiten almacenar los módulos instalados o los
  programas que se hayan compilado, de forma que no haya que hacerlo
  de nuevo.

* Los propios marcos de test tienen opciones para ejecutar diferentes
  conjuntos de test en paralelo; incluso make permite hacerlo. Hay que
  buscar la forma de activarlo para que sea efectivo, buscando sobre todo que los tests terminen lo antes posible.

## Actividad

Añadir al repositorio que se ha hecho en el hito anterior integración
continua con Travis, al menos, y adicionalmente con cualquier otro
sistema.

El repositorio tendrá que incluir el badge de Travis y este tendrá que
estar en verde para aceptar el PR. El fichero de configuración de
Travis tendrá que estar también presente, como es natural.
