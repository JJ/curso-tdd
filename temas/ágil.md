# Desarrollo ágil

## Planteamiento

Con el término desarrollo ágil se agrupan una serie de buenas
prácticas en el sector de la informática que ayudan a conseguir
productos de calidad, adaptados a las necesidades de los clientes, y
flexibles. En esta sesión veremos en qué consiste el desarrollo ágil.

## Al final de esta sesión

Se entenderá qué es el desarrollo ágil, y se empezará a organizar el
trabajo para emprender el desarrollo de un proyecto dentro de los
términos del curso.

## Criterio de aceptación

Se habrá asimilado en qué consiste el desarrollo ágil, y diferentes
técnicas y herramientas usadas en ella, y se habrá comenzado a
elaborar las historias de usuario que se vayan a usar más adelante.

## Desarrollo ágil



## Ver también

Este [*whitepaper* gratuito describe en general la metodología
Scrum](https://shop.theliberators.com/products/scrum-a-framework-to-reduce-risk-and-deliver-value-sooner-whitepaper).

## Actividad

Correspondiente al hito 1, esencialmente consiste en el planteamiento
inicial del proyecto, desde la idea (que tendrá que hacerse
explícitamente) a las primeras historias de usuario.

Se procederá de esta forma: Cada equipo se tendrá que reunir para decidir qué idea tienen o qué
  problema quieren resolver, y para quién quieren resolverlo. Esto
  establece el dominio del problema. La idea o idea iniciales se
  podrán poner en una columna de "ideas" en un tablero, o simplemente
  abrir una ficha de "problema" y que todo el mundo trabaje sobre
  ella.


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

> Los tags se hacen con `git tag` *sobre el repositorio del proyecto*, 
> y para hacer push de los mismos se
> tendrá que hacer, adicionalmente al normal, `git push --tags`

que deberá corresponder exactamente a la versión que se haya enviado.
