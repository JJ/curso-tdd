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

Hace ahora 20 años, el  <a
href="https://agilemanifesto.org/">manifiesto ágil</a> apostaba por
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
  efectivametne se ha resuelto.
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
claidad. Un diseño flexible, por capas, que desacople diferentes
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
