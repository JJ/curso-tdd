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

## Buscando la clientela

En muchos casos en informática, y en muchos a los que nos vamos a
enfrentar durante la carrera y, sobre todo, si queremos emprender o
crear alguna cosa totalmente nueva (o presentar un proyecto al
concurso, que para el caso es lo mismo) el principal problema al que
nos vamos a enfrentar es no encontrar ideas para iniciar el proyecto,
o no saber qué problema más o menos cercano o presente podríamos
resolver.

Sobre todo en emprendimiento, pero también en Informática, se puede
emplear, la mayoría de veces con éxito, la metodología de [*design
thinking*](https://www.designthinking.es/inicio/).

Es una metodología más o menos establecida, pero esencialmente se
parte de una estadística, un dato o un artículo, y a partir de ahí, en
diferentes fases, se van definiendo posibles soluciones al
problema. En la fase de ideas, la que nos interesa es la fase que se
denomina
[*empatizar*](https://designthinkingespaña.com/empatizar-primera-fase-design-thinking),
es decir, colocarse en el lugar de los futuros
usuarios para ver qué deseos tienen y cual sería la mejor forma de
canalizar esos deseos y lograr resolverlos con una aplicación.

### Ejemplo

En el caso del hipotético *dashboard* para controlar los proyectos de
los estudiantes, el principal problema que se puede plantear es lo
manual y tedioso que puede ser controlar uno por uno todos los
proyectos. Empatizar permite centrar el diseño en el usuario,
simplificar el desarrollo al no responder a necesidades que no se
soliciten, y crear un marco en el cual se va a desarrollar esta
aplicación. Además, también permite identificar los *actores*, o
quienes son los que van a usar efectivamente la aplicación.

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

## Empatizando con los clientes

Es esencial en la elaboración de un proyecto saber quién lo va a usar,
pero saberlo hasta el último detalle. Diseñar el interfaz de usuario
requiere saber el tipo de usuario y tener en cuenta la [accesibilidad
universal](https://www.fundacioncaser.org/autonomia/cuidadores-y-promocion-de-la-autonomia/promover-la-autonomia-personal/que-es-la-accesibilidad-universal),
pero la eficacia en que el destinatario final del software lleve a
cabo las labores que se pueden hacer con el mismo es esencial.

En un marco de *design thinking*, además, se habrá identificado a los
actores desde el principio. En esta fase se definirán un poco más, de
forma que pueda acercarse a lo que necesitamos saber de ellos para
desarrollar nuestro software.

Y la cuestión es que rara vez se trata de un solo tipo de
usuario. Aparte de las labores "clásicas", "usuario" y
"administrador", y también el "programador/a" que será quien escriba
el código, todos los roles necesitan ser definidos claramente en
función de sus capacidades motoras y cognitivas, o simplemente
preferencias culturales o lingüísticas.

> ¿Alguien tiene en cuenta a la hora de diseñar una aplicación que
> eventualmente vaya a ser usada por personas con diferentes idiomas
> nativos? Pues eso.

En desarrollo ágil, por tanto, se usa la metodología llamada
[personas](https://www.fundacioncaser.org/autonomia/cuidadores-y-promocion-de-la-autonomia/promover-la-autonomia-personal/que-es-la-accesibilidad-universal)
(en inglés es igual), que consiste simplemente en dar nombre,
apellidos, edad y una biografía e incluso currículum a los posibles
usuarios del software. De esa forma, no va a haber "usuario avanzado",
sino "Doris Yllana McKenzie, máster en ciencia de datos, 35 años,
residente en Tres Cantos, Madrid.

Los personajes o *personas* creadas servirán como protagonistas de las
historias de usuario, que siempre tendrán la forma *como [rol] quiero
que en un [contexto] se obtenga [resultado] o si no [otro
resultado]*. En general, las HUs serán una expresió de alto nivel de
los deseos de todos los posibles clientes de nuestro software.

### Ejemplo

Hemos venido trabajando con una aplicación que intenta monitorizar las
diferentes etapas en las que se encuentran los proyectos de
estudiantes de una carrera de informática.

Para crear la "persona" conviene que se investigue un poco el posible
usuario, usando estadísticas publicadas.

> He intentado buscar estadísticas de la UGR sobre edad media por
> disciplinas, y no la he encontrado. La publicación de datos, y más
> de datos abiertos, es un gran fail.

Por ejemplo, la edad mediana del profesorado de informática en la UGR está
entre los 50 y 60 años.

> Parece mentira, pero es así. Yo estoy ligeramente por debajo de la
> mediana.

En informática, la mayoría del profesorado es hombre. Salvo que
queramos proyectar un mensaje (que también es posible), se debe tratar
de usar estas estadísticas en el diseño de las personas.

Finalmente, el profesorado tiene, en general, un doctorado y es de
origen español (una minoría de otros países de habla hispana, como
Cuba y Argentina). Con lo que ya tenemos definida la persona:

> Iris Capuleto Troya, con nacimiento en España en 1967, licenciatura
> en Informática y doctorado en Informática por la UGR, habla español
> correctamente, también inglés (nivel B1), usa gafas bifocales y
> tiene tanto portátiles como tablets como móviles de última
> generación.

Es decir, cuando decidamos a partir de ahora crear HUs, hablaremos de
"Iris quiere" o "Iris desea". Lo haremos en el material del curso,
dentro de la medida de lo posible.

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

Adicionalmente, decidirá (y escribirá la biografía) de las "personas"
que vayan a usar su software.


## Entrega

Esta entrega se llevará a cabo, como el resto de las mismas, como un
pull request al fichero de [proyectos](../proyectos.md), tras añadir
en el *fork* propio el nombre del proyecto y un enlace al repo, así
como la versión.

En este hito empezaremos a usar un fichero, `agil.yaml`, en el
directorio principal, que se usará para poner una serie de contenidos
relacionados con el hito y que se puedan evaluar automáticamente. En
este hito se añadirá una sola clave: `personas`, que será un *array*
en YAML con el nombre de las personas que se hayan creado. Por
ejemplo, algo así:

```yaml
personas:
    - Iris Capuleto Troya
```

En el caso definido antes. Iremos añadiendo claves a este fichero,
pero por lo pronto tendrá solamente esa clave. Más nombres tendrán que
añadirse de la misma forma, con otra línea precedida por `-`.

Recordatorio: el *tag* deberá corresponder exactamente a la versión
que se haya enviado.
