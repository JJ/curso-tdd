# Flujos de trabajo con Git y GitHub


## Planteamiento

Git es una herramienta para gestionar flujos de trabajo y equipos, y
en combinación con GitHub/GitLab es imprescindible para gestionar los
procesos de calidad del software que vamos a ver en este
curso. 

## Al final de esta sesión

Conocerán las órdenes esenciales de git, y como usar la herramienta de
línea de órdenes de GitHub para realizar algunas tareas fundamentales;
también sabrán cómo organizar flujos de desarrollo usando pull
requests y el concepto del mismo.

## Criterio de aceptación

Cada equipo habrá creado una descripción del mismo, con los
componentes del mismo en un README.md, todos los usuarios añadidos al
repositorio, y tendrán que haber añadido sus nombre con un PR (que
habrá aprobado algún otro miembro del equipo).

## GitHub y git

Comencemos con la creación del repositorio. Primero, haz las
siguientes tareas para configurar correctamente git y GitHub.

* [Configura el usuario, correo electrónico y editor](https://git-scm.com/book/es/v2/Inicio---Sobre-el-Control-de-Versiones-Configurando-Git-por-primera-vez)
de alguna de las formas posibles.
* [Crea un par clave pública/privada](https://docs.github.com/es/github/authenticating-to-github/generating-a-new-ssh-key-and-adding-it-to-the-ssh-agent)
y súbela a tu perfil en GitHub.

A partir de ahí, vamos a empezar a trabajar con un repositorio
directamente. Lo más rápido es crear
repositorios directamente en GitHub

> A partir de ahora, cuando diga GitHub se entenderá el sitio web que
> uses para alojar tus repositorios, GitHub, GitLab o el que
> corresponda; en algunos casos las características podrán no estar disponibles.

Hay tres formas de crearlos: directamente (opción *New repository")
desde el menú, haciendo un *fork* o copia de un repositorio existente
(lo que se aconseja, principalmente, si vas a trabajar con ese
repositorio) o bien creándolos a partir de una plantilla o
*template*. Esto sólo se puede hacer con repositorios que han sido
marcados para ello,
como
[el repositorio de este curso](https://github.com/JJ/curso-qa-template);
si lo permite, la opción *Use this template* te permitirá crear tu
propio repositorio usando los ficheros existentes. Esta opción tiene
la ventaja de que el repositorio no aparece como un *fork*, y además
tienes una serie de ficheros para comenzar rápidamente.

> Aconsejamos también que se instale [`hub`](https://hub.github.com/),
> la línea de órdenes de GitHub. Con ella se puede acceder
> directamente, desde git, a funcionalidades del propio GitHub; por
> ejemplo, descargar repos sólo con el nombre, o acceder a issues.


Una vez creado el repositorio, se descarga con

~~~
git clone mirepo # Si tienes hub instalado
git clone git@github.com:minick/mirepo
~~~

El [ciclo básico de git](http://mini-git.github.io/) consiste en usar
`add`, `push`, `pull` y `commit`. No vamos a entrar demasiado en eso,
pero deberías saber cómo usarlos. Sí vamos a ver flujos de trabajo
basados en pull requests.

## Pulls y sus diferentes modalidades.

Como `git` es un sistema de control de versiones distribuido, `pull`
(y `push`) son los que permiten fusionar las historias de diversas
procedencias. En general, debemos imaginarnos estas dos historias como
dos ramas (literalmente, son ramas) de un árbol que, en un momento
determinado, divergieron. Esas ramas tienen una serie de *nudos*, que
son los commits. Fusionar implicar "ordenar" todos los nudos
procedentes de las dos ramas en una sola rama, de forma que se
incorporen las modificaciones de los dos lados. Vamos a imaginar por
lo pronto que no hay ningún tipo de conflicto. Hay tres formas de
hacer esto

* *Squash* y fusionar. A veces la rama que uno quiere fusionar (de la
  que va a hacerse pull) tiene un montón de commits, algunos de los
  cuales pueden deshacer trabajo hecho anteriormente, o simplemente
  eliminar texto de depuración. Hacer *squash* convierte todos los
  commits en uno solo, y te reúne todos los mensajes de commit de
  forma que puedas editarlos, o borrarlos, para dejar sólo los que
  sean relevantes al resultado final. 
  
* *Merge commit* en este caso se crea un commit específico que dice
  que se han mergeado, y se re-firman los commits existentes con la
  firma de quien lo acepta. De todas las opciones, esta es la que se
  debe de tratar de *no* usar, salvo que haya un modelo de desarrollo
  con una sola persona encargada de trabajar con la rama principal.

* *Rebase and merge* en este caso no se crea un merge commit, se
  aplican los commits de la rama, y encima se aplican los commits
  propios desde donde hayan divergido. Se reescribe la historia del
  repositorio de forma que provoque los mínimos problemas.
  
Pero ¿qué pasa si hay conflictos? El flujo de trabajo debe funcionar
de forma que los conflictos se minimicen, con diferentes personas
trabajando en diferentes partes del código. En ese caso mi experiencia
es que es mejor optar por el merge commit, porque creará marcas en el
fichero del conflicto que indiquen las dos versiones. En muchos casos
no hay más remedio que mirar el código y tomar la versión que
funcione; en otros casos, si sabemos que la versión buena es una de
ellas, hacer

```
git checkout --theirs fichero
git checkout --ours fichero 
``` 

En el primer caso la versión buena será la del repo del que estás
haciendo pull, en el segundo la del propio.

## Pull requests

Los *pull requests* (o *merge requests* en GitLab) son "peticiones de
pull", es decir, una forma de indicarle a quien tenga permisos en repo
que se quiere incorporar un cambio a la rama principal. Lo bueno es
que GitHub te provee un interfaz gráfico para interaccionar con el
cambio y también la persona que lo hace. Para empezar, se pueden crear
plantillas en el repositorio en el cual se dé una estructura al pull
request, tal como decir qué necesidad cubre o marcar si se han
cumplido una serie de condiciones; a posteriori se puede comprobar,
usando sistemas de integración continua, si se han cumplido esas
condiciones.

Por eso, un pull request es una ocasión para revisar el
código. *Siempre* hay que mirarlo, incluso aunque haya pasado los
tests; puede haber mejoras que se pueden hacer sobre la marcha, en la
rama desde la que se solicita el pull request. Pero lo principal de
los mismos es que pueden limitarse para que no se pueda fusionar si no
hay más de un número determinado de aceptaciones, por ejemplo. Eso
anima al desarrollo colaborativo y permite comprobar la calidad del
código como sólo los humanos saben hacerlo. Un flujo de trabajo en
dónde sólo se acepta a la rama principal desde un pull request permite
reducir la cantidad de errores y por tanto, desde el mismo origen,
trabajar en la calidad del producto resultante.

Los PRs, igual que todos los push a la rama principal, pueden ir
acompañados de una serie de tests específicos. Veremos más adelante en
qué consisten y cómo programarlos.

## *Tagging* y *releasing*

En el ciclo de vida de una base de código, los *releases* son puntos
de control que se alcanzan al final de algún hito. Estos puntos de
control permiten saber exactamente el estado de la base de código en
ese momento, e incluso volver a ellos si hace falta corregir algún
error.

En git se marcan los releases con un *tag*, que es simplemente una
anotación (o etiqueta) que se añade a un commit determinado; es, por
tanto, una forma de recordar un commit para volver a él si hace falta,
o simplemente recuperar todos los ficheros en el estado que estaban en
ese commit para hacer un release o un despliegue con todos ellos.

Para marcar, se usa `git tag`

```
git tag -a v0.0.1 -m "First release"
```

Tras la `a` se pone la versión, generalmente con una v delante, y
usando "versionado semántico", donde el primer número suele
corresponder a una "major", el siguiente a una "minor", y el siguiente
a *point releases* o versiones que mejoran algo sin hacer ninguna
alteración al API.

A partir de ese tag, en GitHub se pueden crear *releases* desde la
línea de órdenes o desde la web; estas releases crearán en la web un
paquete con los ficheros, pero adicionalmente se pueden añadir otros
ficheros binarios. *Todos* los ficheros generados deben ir en
releases, *no* en el repositorio; por ejemplo, PDFs o `.deb`.

Una vez constituido un release con un tag, equivale a una rama ligera;
se puede acceder al commit etiquetado con

```
git checkout v0.0.1
```

En realidad, se habrá obtenido el estado del repositorio tras un
commit determinado, por lo que se quedará en una situación llamada
*detached HEAD*, no asociado a ningún extremo del grafo de commits. Si
se quiere trabajar a partir de ahí (para corregir un bug, por ejemplo), habrá que crear una rama a partir
de ese commit:

```
git checkout -b rama-desde-tag
```

Esa rama podemos usarla como cualquier otra rama, desplegarla o
fusionarla eventualmente con `master`.


## Actividad

Esencialmente, en esta primera fase se llevarán a cabo las actividades
de diseño para el resto del curso.

1. Elegir un equipo para trabajar en el proyecto, y crear un
   repositorio 
   [usando esta plantilla](https://github.com/JJ/curso-qa-template),
   que contiene ya algunos tests y el diseño general, así como la
   licencia libre.

## Entrega

Esta entrega se llevará a cabo, como el resto de las mismas, como un
pull request al fichero de [proyectos](../proyectos.md), tras añadir
en el *fork* propio el nombre del proyecto y un enlace al repo, así
como la versión.

Usaremos
[versionado semántico para las entregas](https://semver.org/), donde
el primer número será siempre el hito (comenzando por el hito
0). Diferentes versiones cambiarán el *minor* (el segundo) o el
tercero, si son algunos cambios que no alteran el API ni la
funcionalidad. Cada entrega corresponderá a un *release*, y por tanto
el repositorio tendrá que tener un tag 

> Los tags se hacen con `git tag`, y para hacer push de los mismos se
> tendrá que hacer, adicionalmente al normal, `git push --tags`

que deberá corresponder exactamente a la versión que se haya enviado.
