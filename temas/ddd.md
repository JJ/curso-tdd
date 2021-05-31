# Planteando un proyecto

## Planteamiento

Los sistemas de desarrollo ágil intervienen desde el primer momento,
desde el momento que se plantea qué problema resolver y para qué
resolverlo. Aquí veremos cómo plantear un proyecto y cómo emprender su
solución por medios informáticos.

## Al final de esta sesión

Se comprenderán conceptos como *Design Thinking*, y la metodología de
*personas* para plantear un problema.

## Criterio de aceptación

Se habrá planteado el problema, y las personas que están interesadas
en una solución del mismo.

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

En el caso de un hipotético *dashboard* para controlar los proyectos de
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
resultado]*. En general, las HUs serán una expresión de alto nivel de
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

[Un artículo da consejos para crear una serie de personas
creíbles](https://www.romanpichler.com/blog/10-tips-agile-personas/).

## Actividad

Correspondiente al hito 1, esencialmente consiste en el planteamiento
inicial del proyecto, desde la idea (que tendrá que hacerse
explícitamente) a las primeras historias de usuario.

Se procederá de esta forma: Cada equipo se tendrá que reunir para decidir qué idea tienen o qué
  problema quieren resolver, y para quién quieren resolverlo. Esto
  establece el dominio del problema. La idea o idea iniciales se
  podrán poner en una columna de "ideas" en un tablero de GitHub, o simplemente
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
