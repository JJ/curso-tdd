# Integración continua


## Planteamiento

Los sistemas de integración continua forman parte del flujo de trabajo
de un sistema de calidad, ejecutando automáticamente las pruebas que
se le configuren cada vez que se lleva a cabo un `push` o un `pull request`. 
A su vez, estos sistemas dan retroalimentación al alojamiento del
repositorio de forma que, en caso positivo, se realice el siguiente
paso en el pipeline, por ejemplo desplegar a producción.

## Al final de esta sesión

El estudiante entenderá los criterios para elegir un sistema de
integración continua, y sabrá configurar uno para poder ejecutar los
tests automáticamente en el mismo.

## Criterio de aceptación

El repositorio tiene que estar corriendo los tests en Travis, y esos
tests deben pasar.

## Pasando los tests automáticamente

A un primer nivel, la integración continua consiste en integrar los
cambios hechos por un miembro del equipo en el momento que estén y
pasen los tests. Pero eso, efectivamente, significa que deben pasar
los tests y para nosotros, consiste en crear una configuración para
una máquina externa que ejecute esos tests y nos diga cuáles han
pasado o cuales no. Estas máquinas más adelante se combinan con las de
despliegue continuo, no permitiendo el mismo si algún test no ha
pasado.

En general, la integración continua se hace *en la nube*; lo que no
quiere decir que se haga siempre en un servicio *cloud* contratado,
sino porque se suele hacer en máquinas dedicadas específicamente para
ello; es más general, sin embargo que una máquina
virtual se descarga los ficheros, ejecuta los tests
y crea un informe, enviando también un correo al autor indicándole el
resultado. Por tanto, para que haga esto tenemos que indicar en la
configuración todo lo necesario para ejecutar los tests y,
posiblemente, nuestro programa: aplicaciones, librerías que necesita
nuestro programa, aparte de la configuración que tendrá el programa en
sí con las librerías del lenguaje de programación en el que está
desarrollado.

Un sistema bastante popular de integración continua es
[Jenkins](https://jenkins.io/), pero está enfocado sobre todo a
Java y no tiene una web gratuita que se pueda usar. Jenkins lo puedes usar en la nube o instalarte tu propio
ordenador para hacerlo. Sin embargo, está enfocado sobre todo a Java
por lo que hay otros sistemas como [Travis](https://travis-ci.org) o
[Shippable](https://www.shippable.com/) que podemos usar también desde
la nube y, además, están preparados para más lenguajes de
programación.

Para trabajar con estos sistemas, generalmente hay que hacerlo en dos
pasos

1. Darse de alta. Muchos están conectados con GitHub por lo que puedes
   usar directamente el usuario ahí. A través de un proceso de
   autorización, acceder al contenido e incluso informar del resultado
   de los tests.

2. Activar el repositorio en el que se vaya a aplicar la
   integración continua. Travis permite hacerlo directamente desde tu
   configuración; en otros se dan de alta desde la web de GitHub.

3. Crear un fichero de configuración para que se ejecute la
   integración y añadirlo al repositorio.


Los ficheros de configuración de las máquinas de integración continua
corresponden, aproximadamente, a una configuración de una máquina
virtual que hiciera solo y exclusivamente la ejecución de los
tests. Para ello se provisiona una máquina virtual (o contenedor), se
le carga el sistema operativo y se instala lo necesario, indicado en
el fichero de configuración tal como este para Travis.

~~~~~YAML
	language: node_js
	node_js:
	  - "0.10"
	  - "0.11"
	before_install:
	  - npm install -g mocha
	  - cd src; npm install .
	script: cd src; mocha
~~~~~

Este fichero, denominado `.travis.yml`, contiene lo siguiente:

- `language` indica qué lenguaje se va a usar. Travis tiene
  [varios lenguajes](https://docs.travis-ci.com/user/getting-started/),
  incluyendo por supuesto nodejs. Las máquinas virtuales no suelen
  estar configuradas para lenguajes arbitrarios, aunque por supuesto
  se puede poner un lenguaje tal como C y luego descargar lo necesario
  para otro lenguaje.

- `node_js` en este caso indica las versiones que vamos a probar. Por
  el mismo precio podemos probar varias versiones, en este caso las
  dos últimas de node.

- `before_install` se ejecuta antes de la instalación de la aplicación
  (específica de cada lenguaje; por ejemplo en el caso de node.js
  sería `npm install .`. En nuestro caso tenemos que instalar `mocha`
  y además ejecutar este último paso en un subdirectorio que no es
  estándar.

- Finalmente, se ejecuta el script de prueba en sí (para el caso,
  cualquier cosa que quieras ejecutar). Una vez más, nos cambiamos al
  subdirectorio y ejecutamos `mocha` tal como lo hemos hecho
  anteriormente.

El resultado
[aparecerá en la web](https://travis-ci.org/JJ/desarrollo-basado-pruebas)
y también se enviará por correo electrónico. Y te da también un
*badge* que puedes poner en tu fichero para indicar que, por lo
pronto, todo funciona.

Si el informe indica que las pruebas son correctas, se puede proceder al despliegue. Pero eso
ya será en la siguiente clase.

Esta configuración es esencial por varias razones: primero, porque nos
permite ser conscientes de todo lo necesario para desplegar nuestra
aplicación. Segundo, porque al crear tests integramos el paso de
control de calidad en el desarrollo. Y, finalmente, porque la
integración continua y los tests correspondientes son un paso esencial
para el despliegue continuo, que se verá más adelante.

## Acelerando los tests

Es conveniente que los tests tarden la mínima cantidad de tiempo
posible, para que se pueda comprobar que existe algún error sobre la
marcha y se pueda corregir. Sin embargo, cualquier test va a necesitar
instalar una serie de prerrequisitos antes de ejecutarlos, así que la
descarga e instalación de paquetes y módulos, y en algunos casos
incluso la compilación de algún prerrequisito necesario, va a tardar
algún tiempo. Acelerar los tests hasta que tarden menos (incluso
bastante menos) de un minuto es esencial para un trabajo fluido.

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

Esto es lo que uso, por ejemplo, en la asignatura CC:

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
hacer las pruebas se puede usar también (o su precursor) para
desplegar la aplicación.

Por ejemplo, usaremos el contenedor generado por este Dockerfile para
testear los proyectos (y ortografía) en este curso:

```Dockerfile
FROM jjmerelo/p6-test-text
LABEL version="1.0" maintainer="JJ Merelo <jjmerelo@GMail.com>" perl5version="5.22"

ADD cpanfile .
RUN apt-get update && apt-get install -y git
RUN cpanm --installdeps .

VOLUME /test
WORKDIR /test

ENTRYPOINT cp /*.dic /*.aff /test && prove -I/usr/lib -c
```

Si el fichero es compacto, es porque previamente se ha generado un
contenedor anterior, `jjmerelo/p6-test-text`, que incluye el módulo
que comprueba la ortografía; lo que hay que añadir solamente son lo
necesario para testera en sí los proyectos enviados, que es el test
adicional que se lleva a cabo. Estos proyectos necesitarán una
instalación de `git`, y también una serie de módulos de Perl
adicionales; las dos sentencias `RUN` llevan a cabo esa labor. 

El `ENTRYPOINT` es lo que se va a ejecutar; tras copiar una serie de
ficheros que son necesarios en el mismo directorio donde se va a
ejecutar, llama al marco de test de Perl, llamado `prove`. 

A diferencia de los paquetes anteriores, que van en el repositorio,
normalmente los Dockerfiles no se ejecutan directamente (salvo en
GitHub Actions). Habrá que subirlos al Docker Hub, pero es
gratuito. Travis (o el sistema que sea) lo descargará de ese registro
en la fase correspondiente antes de aplicarlo a tu repositorio.

> Esa descarga puede tardar también algunos segundos, porque un
> contenedor puede tener varios cientos de megas, dependiendo de la
> base sobre la que lo construyas. Hacer un
> contenedor lo más ligero posible es también conveniente.

Esto se incluirá en la configuración de Travis, que además se
simplifica considerablemente:

```yaml
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
llevan a cabo los tests.


## Actividad

Añadir al repositorio que se ha hecho en el hito anterior integración
continua con Travis, al menos, y adicionalmente con cualquier otro
sistema.

El repositorio tendrá que incluir el badge de Travis y este tendrá que
estar en verde para aceptar el PR. El fichero de configuración de
Travis tendrá que estar también presente, como es natural.
