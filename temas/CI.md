# Integración continua


## Planteamiento

Los sistemas de integración continua forman parte del flujo de trabajo
de un sistema de control de calidad del software, ejecutando automáticamente las pruebas que
se le configuren cada vez que se lleva a cabo un `push` o un `pull request`. 
A su vez, estos sistemas dan retroalimentación al alojamiento del
repositorio de forma que, en caso positivo, se realice el siguiente
paso en el pipeline, por ejemplo desplegar a producción; por eso se llaman en general sistemas CI/CD, incluyendo *continuous delivery*, o despliegue continuo. 

## Al final de esta sesión

El estudiante entenderá los criterios para elegir un sistema de
integración continua, y sabrá configurar uno (o varios) para poder ejecutar los
tests automáticamente en el mismo. También habrá entendido los mecanismos que hacen que se ejecuten estos tests automáticamente.

## Criterio de aceptación

El repositorio tiene que estar corriendo los tests unitarios desarrollados anteriormente en (al menos) Travis, y esos
tests deben pasar.

## Concepto de integración continua

A un primer nivel, la integración continua consiste en incluir en la rama principal los
cambios hechos por un miembro del equipo en el momento que estén hechos y
pasen los tests.

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

## Pasando los tests automáticamente en la nube.

Muchos equipos de desarrollo instalan *hooks* con comprobaciones
básicas durante los mensajes de commit e incluso antes de hacer push a
una rama o a máster, pero en general, se usará algún *hook* en el
servidor que los ejecutará cuando se envíe un pull al mismo.

A diferencia de los *hooks* locales, que se ejecutan en el mismo
entorno de desarrollo que el que está usando quien lo desarrolle, para los remotos habrá que crear una configuración para que ejecute esos tests y nos diga cuáles han
pasado o cuales no. Estas máquinas más adelante se combinan con las de
despliegue continuo, no permitiendo el mismo si algún test no ha
pasado.

En general, la integración continua se hace *en la nube*, por el
simple hecho de que los equipos de desarrollo están distribuidos y
también los repositorios suelen ser servicios externos a los
ordenadores de la empresa; lo que no 
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
[Jenkins](https://jenkins.io/). Jenkins lo puedes usar en la nube o instalarte tu propio
ordenador para hacerlo. Sin embargo, está enfocado sobre todo a Java (y no hay un servicio gratuito que se pueda ejecutar)
por lo que recomendamos, al menos para empezar, otros sistemas como [Travis](https://travis-ci.org) o
[Shippable](https://www.shippable.com/) que podemos usar también desde
la nube y, además, están preparados para más lenguajes de
programación.

Para trabajar con un sistema de CI hay que hacerlo en dos
pasos

1. Darse de alta. Muchos están conectados con GitHub por lo que puedes
   usar directamente el usuario que tengas ahí. A través de un proceso de
   autorización, acceder al contenido e incluso informar del resultado
   de los tests.

2. Activar el repositorio en el que se vaya a aplicar la
   integración continua. Travis permite hacerlo directamente desde tu
   configuración; en otros se dan de alta desde la web de GitHub; también en algunos casos todos los repositorios estarán autorizados con sólo autorizar el usuario. Por supuesto, en el caso de GitHub Actions y *GitLab pipelines* no hace falta llevar a cabo este paso.

3. Crear un fichero de configuración con la configuración necesaria para ejecutar estos tests y añadirlo al repositorio.


Los ficheros de configuración de las máquinas que ejecutan los servicios de integración continua
corresponden, aproximadamente, a una configuración de una máquina
virtual que se dedicara solo y exclusivamente a llevar a cabo la ejecución de los
tests. Por ello las órdenes del mismo son equivalentes a una
provisión de una máquina virtual (o contenedor), a la que tras el
sistema operativo se le instala lo necesario, indicado en 
el fichero de configuración tal como este para Travis.

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
  ejecuta traiga instaladas (por ejemplo, make o git).

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

## Acelerando los tests

Es conveniente que los tests tarden la mínima cantidad de tiempo
posible, para que se pueda comprobar que existe algún error sobre la
marcha y se pueda corregir. Sin embargo, cualquier test va a necesitar
instalar una serie de prerrequisitos (módulos dependientes, por ejemplo) antes de ejecutarlos, así que la
descarga e instalación de paquetes y módulos, y en algunos casos
incluso la compilación de algún prerrequisito necesario, va a tardar
algún tiempo. Acelerar los tests hasta que tarden menos (incluso
bastante menos) de un minuto es esencial para un trabajo fluido, que
permita corregir sobre la marcha errores antes de continuar trabajando.

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
