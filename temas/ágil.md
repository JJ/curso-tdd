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
elaborar una épica de la cual surgirán las historias de usuario que se
vayan a usar más adelante.

## Desarrollo ágil

Hace ahora 20 años, el [manifiesto ágil](https://agilemanifesto.org/)
apostaba por
una nueva manera de entender el desarrollo de software que aportara
valor al cliente y que fuera ágil en la evolución del mismo, a la vez
que proporcionara un entorno de trabajo más satisfactorio para quien
lo desarrolla.

Este manifiesto tenía una serie de lemas, que en general se
presentaban en contraposición al método de cascada o *waterfall* en el
que las diferentes fases de desarrollo estaban aisladas y
diferenciadas, y sólo se pasaba a producción al final de una larga
cadena de departamentos aislados entre sí. Los principales lemas eran

* Menos documentación, y más código funcionando. La documentación
  excesiva en forma de contratos y especificaciones funcionales no
  sirve de nada si no se acompaña de código que funcione; el código
  funcionando es la mejor forma de asegurar que efectivamente se
  entienden correctamente los requisitos del cliente.
* Menos procesos, más interacción con el cliente (y de los
  programadores entre sí). En vez de compartimentos aislados, con una
  cascada y el cliente en ambos extremos, las interacciones del
  cliente deben ser constantes, y los diferentes grupos de
  programadores llevando a cabo ese programa interaccionan
  continuamente para llevar el código a un estado en el que se pueda
  mostrar al cliente.
* La colaboración del cliente no debe ser mediante contratos (aunque
  tendrá que haberlos, sino mediante una interacción continua donde se
  le muestre productos funcionando y el cliente vea si eso corresponde
  a sus expectativas o no; si no lo hace, debe de organizarse el
  equipo de forma ágil para evolucionar el producto hasta que lo haga.

Estos lemas se organizan en una serie de principios, doce en
total. Pero de ellos vamos a extraer unos cuantos:

* La programación tiene que centrarse en resolver problemas. Lo más
  importante es eso, y debe ser el principal enfoque de la
  tarea. Resolverlos, y tener métodos ágiles para comprobar que
  efectivamente se ha resuelto.
* Para interaccionar con el cliente y que vea esos productos
  mínimamente viables, hay que publicar frecuentemente, pasando a
  producción cualquier cosa que esté lista y pase todos los tests. En
  este sentido, se parece al *release early, release often* del mundo
  del software libre.
* El diseño es esencial, aunque dentro de los límites de que se
  prefiere el código a la documentación. El diseño previo a la
  codificación debe seguir todos los lemas y todos los principios
  ágiles.
* Hay que atenerse a las buenas prácticas para codificar, en todas las
  áreas del proyecto, desde cómo nombrar las variables hasta que'tipo
  de herramientas y metodologías se consideran las mejores en un
  momento determinado. Es decir, cuando se comience un proyecto debe
  de dedicarse cierto tiempo a establecer cuales son esas buenas
  prácticas. En la evolución del mismo, será esencial para su
  flexibilidad y comprensibilidad seguir las mismas.
* La simplicidad es esencial, y no se debe hacer más que lo que hay en
  los requisitos, ni buscar más características que las que
  estrictamente se necesiten para resolver un problema.
* El trabajo se debe revisar frecuentemente, con el objetivo de
  hacerlo más eficiente, adaptarlo a nuevos requisitos, o simplemente
  incorporarlo a producción; el código siempre debe haber pasado por
  varios ojos antes de que sea hábil para funcionar.

Estos principios deben guiar una metodología de trabajo. Para empezar,
dice que hay que empezar por un problema a resolver, no con qué se
quiere hacer. Las soluciones no pueden estar por delante del
problema. Es decir, empezar por decir las herramientas que se van a
usar para hacer algo es una forma de empezar algo que no va a ser
simple, posiblemente no resuelva ningún problema, y sea difícil de
probar si efectivamente funciona o no. Además, te indica que hay que
organizar el trabajo en *hitos*, cada uno de los cuales implicará la
publicación de un producto mínimamente viable, cada uno de los cuales
se construirá sobre el anterior (o se agregará al anterior, según el
problema). Sin un producto mínimamente viable, no se puede testear, y
sin tener claro qué problema se quiere resolver, tampoco.

La calidad en el software empieza por el diseño, y este diseño incluye
desde la modularización del problema, hasta el el uso de lenguaje,
bibliotecas o estructuras de datos para trabajar. En informática rara
vez hay una sola forma de hacer las cosas, y siempre hay que tomar
decisiones técnicas que tendrán implicaciones en la evolución del
software. Diseñar te va ayudar a escribir menos código, y el mejor
código es el que no hay que testear, con lo que será código de más
claridad. Un diseño flexible, por capas, que desacople diferentes
partes del mismo, será también mucho más fácil de adaptar a diferentes
circunstancias.

Y la búsqueda de mejores prácticas es esencial. La sintaxis y los
manuales de referencia, y los tutoriales, rara vez se preocupan de
guiar en la toma de una serie de decisiones técnicas. Te presentan una
solución como ideal, o posiblemente la única posible. Sin embargo,
llegar a esas soluciones implica una serie de decisiones, y es en las
que hay que seguir las mejores prácticas, a todos los niveles:
personales, empresas, industria.

Finalmente, se tiene que establecer una infraestructura para revisión
de código. Lo más simple es establecer un estándar en el cual no se
incorpore código a la rama principal directamente, sino que se haga
siempre mediante pull requests. Pero adicionalmente, el desarrollo
ágil pide la creación de una serie de reuniones, normalmente llamadas
*retro*, que revisan el código que ha puesto en producción, y sugiere,
siempre de forma constructiva, diferentes mejoras (que se incorporarán
a un MVP futuro). El pasar tests frecuentemente para guardarse de
posibles cambios en las dependencias también es una buena práctica,
porque cerrarse en una versión determinada de todo puede ser
eficiente a la hora de llevar a producción, pero las versiones de todo
acaban siendo deprecadas y no quieres encontrarte en una situación en
la cual tengas que reescribir todo por usar algo con posibles huecos
de seguridad.

## Capturando los deseos de los clientes

Los deseos de los clientes se capturarán en unas [historias de
usuario](diseño.md). Pero previo a las historias de usuario se tendrán
que crear unas narrativas de los diferentes pasos que van a dar los
diferentes tipos de usuario, una visión más global que, más adelante,
se dividirá en fragmentos, historias de usuario, testeables y
programables. Estas narrativas se llaman
[épicas](https://www.qalovers.com/2018/04/historias-de-usuario.html). En
general, como afirma en el enlace anterior:

> Son historias de usuario demasiado extensas que se tienen que
> dividir en otras más pequeñas.

Y en este punto es donde es conveniente empezar a usar las mejores
prácticas en el desarrollo ágil. Hay muchas formas de llevarlo a cabo,
pero generalmente se agrupan en dos campos diferentes: los partidarios
de usar [*scrum*](https://proyectosagiles.org/que-es-scrum/) o los
usuarios de
[*kanban*](https://kanbanize.com/es/recursos-de-kanban/primeros-pasos/que-es-kanban). Hay
diferencias considerables, aunque los dos coinciden en el hecho de que
se trabaje sistemáticamente con historias de usuario... y con un
tablero. Los tableros permiten ver claramente en qué estado está el
trabajo, y permite organizar las historias de usuario en diferentes
columnas según el estado en el que estén. Las columnas clásicas son
"Por hacer", "haciéndose" y "hecho", pero se pueden añadir otras
columnas según el proyecto y el equipo: Diseño técnico, o Tormenta de
Ideas. Estas últimas permiten interaccionar, a través de la
herramienta que se elija (que, por simplicidad, es mejor que sea la
que  provee el gestor de código, por ejemplo, el de GitHub).

Estas columnas de "tormenta de ideas" se pueden usar, por ejemplo,
para elaborar colaborativamente una épica. De esa épica,
posteriormente, surgirán las diferentes historias de usuario. Pero eso
lo veremos a continuación.

## Ver también

Este [*whitepaper* gratuito describe en general la metodología
Scrum](https://shop.theliberators.com/products/scrum-a-framework-to-reduce-risk-and-deliver-value-sooner-whitepaper).

## Actividad

<-- Reescribir la actividad, que ahora ha pasado al hito 1 -->

## Entrega

Esta entrega se llevará a cabo, como el resto de las mismas, como un
pull request al fichero de [proyectos](../proyectos.md), tras añadir
en el *fork* propio el nombre del proyecto y un enlace al repo, así
como la versión.

Recordatorio: el *tag* deberá corresponder exactamente a la versión
que se haya enviado.
