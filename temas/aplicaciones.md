# Resolviendo problemas usando aplicaciones informáticas.

## Planteamiento

La gama de posibles "productos" que se pueden generar para resolver un
problema informático es muy amplia, casi tanto como la variedad de
dispositivos y sistemas sobre los que se puede desplegar. En este
(breve) tema veremos todas las posibilidades que hay, y qué nos puede
hacer elegir una u otra.

## Al final de esta sesión

Se conocerán diferentes posibilidades para crear y publicar aplicaciones
informáticas, y se tendrán elementos de juicio para elegir una u otra.

## Criterio de aceptación

El equipo tendrá que decidir qué forma va a tomar la solución al
problema que han planteado en la fase anterior.

## La ingeniería del software revuelve problemas usando sistemas informáticos

> En el [tema anterior](ddd.md) hemos planteado la necesidad de
> diseñar de forma adecuada una solución a un problema real. Aquí
> haremos un breve panorama de las diferentes soluciones informáticas
> que se pueden usar.

Esto, que puede parecer obvio, queda en el olvido totalmente en un
sistema de enseñanza de la informática compartimentalizado en el que
para empezar sólo se enfocan partes de un problema, y para seguir sólo
se explican herramientas específicas, exigiéndose saber cómo funcionan
esas herramientas antes que ayudar a resolver el problema de esa
forma. Con una asignatura que, por ejemplo, desarrolla un paradigma de
programación y que, a continuación, usa dos lenguajes de programación,
el foco de la misma se desplaza de los conceptos y técnicas generales
de programación a aprender la sintaxis de esos dos lenguajes. El foco
principal, que debería de ser la resolución de problemas, queda
totalmente olvidado.

Cuando se llega a los últimos cursos de informática, todo lo que sabe
hacer el estudiante medio es "voy a hacer un programa del tipo (o dos
tipos) que he aprendido que use el lenguaje X y *framework* Y", donde
tanto X como Y están entre la gama muy estrecha que se ha definido en
los cursos anteriores, o ni siquiera eso, en los cursos anteriores y
*no se odia*.

En ingeniería informática, sin embargo, se debe de estar dispuesto a
resolver cualquier problema que se presente, usando soluciones de
software, y en algunos casos también de hardware. Estas soluciones se
diseñarán en forma de capas de abstracción que faciliten su evolución,
pero también, por supuesto, sus pruebas. Una vez más, la calidad es un
proceso y no algo que se añade al producto; el asegurar la calidad de
un producto debe partir desde las herramientas elegidas (como `git`, que
se vio en el primer tema, pero también las herramientas informáticas
que se vayan a usar) hasta la metodología de diseño o la
arquitectura general que se va a usar.

Como el desarrollo de una aplicación también se basa en crear una
serie de productos mínimamente viables (MVP) de complejidad
creciente, en realidad esto son tanto aplicaciones finales como
posibles etapas de una aplicación.

En este capítulo vamos a tratar de hacer una pequeña panorámica de la
arquitectura de una aplicación informática, con "aplicación" siendo un
término vago que abarca todo producto informático que pueda ser
publicado. Empezamos por lo más bajo, el módulo.

## Módulos/Bibliotecas/Paquetes

Todos los lenguajes de programación permiten la creación de
aplicaciones modulares, es decir, dividir una aplicación en diferentes
partes, cada una de las cuales provee una funcionalidad específica y
consiste, en sí, una capa de abstracción (un lenguaje) sobre la
funcionalidad que incluye.

Diferentes paradigmas de programación llamarán a estos módulos de
forma diferente. En programación dirigida a objetos habrá interfaces,
roles o clases; en lenguajes procedurales o funcionales se les llamará
módulos o paquetes, pero en cualquier caso siempre habrá dos
componentes principales

* Una estructura de datos, que no será explícita en el caso de los
  lenguajes dirigidos a objetos (sino atributos en una clase), o sí en
  en caso de lenguajes procedurales.

* Un API o interfaz de aplicación, que servirá para abstraer esa
  estructura de datos y poder hacer cosas específicas con ellas.

Modelizar esta estructura de datos de forma que se corresponda al
dominio del problema es una de las tareas más importantes en el diseño
de una aplicación; pero desde nuestro punto de vista lo importante es
que este módulo, en sí, puede ser una *aplicación*, porque resuelva el
problema (de forma limitada, claro). Un módulo se puede publicar en
los repositorios del lenguaje si cumple las normas para el mismo.

> Evidentemente, un sólo módulo rara vez es una solución, en muchos
> casos habrá que crear toda una jerarquía o grupo interdependiente de
> los mismos, pero al final, habrá siempre un módulo en la capa más
> alta de abstracción que sea la solución al problema.

Los módulos formarán parte de cualquier solución, y deben estar
desacoplados de la misma; para testear y asegurar la calidad del
producto, así como la generalidad, la lógica de negocio tiene que
estar separada de cómo se vaya a usar en un programa determinado. De
hecho, los módulos tienen que ser lo más abstractos posibles y estar
separados de cualquier implementación, a través del mecanismo que se
llama *inyección de dependencias* (que se verá más adelante).

## APIs

Por encima de los módulos puede haber un API que permita al módulo
realizar un servicio en el marco de una aplicación compuesta por
muchos servicios. En general, un API incluirá una o varias clases,
aunque en el caso de una arquitectura de microservicios será, en
general, una sola clase. Un API será una capa de abstracción
adicional: mientras que el API de un módulo restringe el acceso al
mismo, un API en general podrá tener restricciones adicionales en el
contexto de una aplicación, e incluirá servicios adicionales, como
*logging* y por supuesto almacenamiento de datos. Sin preocuparnos en
este momento de cómo hacer estas cosas (ya tocará), un API es un
*producto* que puede resolver un problema, y se puede implementar de
diferentes formas.

* Un API REST es posiblemente la más popular, siguiendo la sintaxis y
  mensajes de estado del HTTP y permitiendo hacer el ciclo CRUD
  (creación, lectura, actualización y borrado) usando verbos
  equivalentes de HTTP. Se trata evidentemente de un API procedural,
  con lo que habrá que llevar a cabo adaptaciones en el caso de tener
  por debajo clases.

* Un API con websockets usa el protocolo HTTP de la misma forma, pero
  se diferencia del anterior en que usa conexiones permanentes, con
  reacciones por parte del cliente o del servidor cada vez que llegan
  datos por esa conexión. En aplicaciones de una sola página suelen
  ser bastante populares, pues permiten reaccionar rápidamente a
  cambios en el frontend (o actualizar desde el back-end).

* APIs que usen [gRPC](https://grpc.io/), un protocolo moderno para
  llamada remota a procedimientos independiente del lenguaje.

* Otros tipos de protocolos: SOAP, XML-RPC... Aunque no son tan
  populares, es posible todavía encontrárselos (y también en trabajos
  de la ETSIIT). En lo posible, evitarlos.

* APIs [GraphQL](https://graphql.org/learn/) que, más allá de la
  simple descripción de recursos que ofrece REST, permite crear
  peticiones complejas usando un lenguaje específico y con respuestas
  también complejas.

* Sistemas de mensajería, con interfaces orientados a tareas. En
  sistemas de tareas el cliente invoca a una tarea, que se pone de
  forma explícita en el interfaz. Por ejemplo, usando Celery un módulo
  se organiza en una serie de tareas, que se invocan desde el cliente.

Al final, este tipo de APIs también son un módulo, y por tanto puedes
publicarlo también; en general, sin embargo, serán parte de una
aplicación. No hay ningún problema para que un API REST resuelva
un problema sin tener que ponerle por encima un cliente web.

## Clientes de API

Sobre todo en sistemas de mensajería como Telegram o Slack, se pueden
enganchar clientes del mismo que provean alguna funcionalidad
adicional. Normalmente tienen un bucle que lee del canal o
funcionalidad a la que esté suscrita, y contesta o lleva a cabo algún
otro tipo de actividad. También pueden ser, en realidad, APIs que
reaccionen a algún otro tipo de API, como *hooks* que reaccionen a
peticiones a GitHub; en ese sentido, pueden ser una capa que esté por
encima de un API de cualquier tipo, o directamente ese tipo de API.

## Sistemas de mensajería

Hay situaciones en las que vamos a necesitar operar de forma concurrente
nuestros servicios. Para no sobrecargar la ejecución de los mismos, así
como ganar en performance, podemos delegar en otros microservicios la
realización de algunas tareas. Para sincronizar toda esta ejecución
será necesario utilizar un middleware como (RabbitMQ)[https://www.rabbitmq.com/]
que hará las veces de cartero (ó  broker de mensajería) repartiendo los
mensajes a quien le correspondiera. De esta forma podremos trabajar de
forma asíncrona, manteniendo informados sobre nuevos cambios a los
diferentes servicios suscritos al broker.

## Arquitecturas de microservicios

Una arquitectura de microservicios une diferentes microservicios
usando mecanismos como un *service mesh* (interno) o *API gateway*
(externo), creando a su vez un API conjunto que, en general, requiere
más configuración que programación. Las arquitecturas de
microservicios pueden ser en principio independientes del cliente,
pero pueden estar ligadas también a él.

Excluimos explícitamente las aplicaciones monolíticas MVC, porque
quedan en un nicho muy explícito, pero sobre todo crean una serie de
*vicios* (como no organizar en capas el código, o acoplar fuertemente
cliente-servidor-datos), que impiden su evolución y su despliegue
eficiente.

## Herramientas CLI y otros programas monolíticos.

Una aplicación debe de diseñarse para poder ser testeada. Una
herramienta que se use desde la línea de órdenes será complicada de
testear; por eso debe seguir, siempre, los principios de separación
entre el módulo que lleva a cabo la funcionalidad y la propia
herramienta, un script que prácticamente lo único que hará será
invocar la funcionalidad del módulo, que estará extensivamente
testeado.

Esto se aplica también a programas *desktop* que usen un interfaz de
usuario; la división en diferentes capas testeables es fundamental, y
se debe de evitar un solo programa monolítico como la peste. El diseño
de UI, aparte, es un arte arcano que requiere mucho más que técnica, y
asegurar la calidad requiere de testeo con usuarios, por ejemplo.

## Programas front-end

En general, los programas front-end se van a ejecutar en un navegador,
y por eso tendrán que escribirse en JavaScript o algún lenguaje que se
transpile a JavaScript como Dart o TypeScript. Lo esencial de este
tipo de programas, como en todo diseño de la arquitectura, es
desacoplarlos del servidor, de forma que el servidor ofrezca un API
que se consuma desde el cliente (pero también desde otro servicio o
incluso desde un programa de línea de órdenes).

En estos programas front-end incluyo también las aplicaciones móviles,
que no son sino una forma específica de crear aplicaciones para un
cliente determinado. En ese sentido, desacoplar front de back permite,
una vez más, crear diferentes clientes para un sólo servidor, y
desarrollar (y desplegar) de forma aislada uno del otro.

## Aplicaciones de escritorio

Todavía se desarrollan aplicaciones de escritorio, con bibliotecas
específicas multi-SO para poder crear aplicaciones que se ejecuten en
diferentes sistemas operativos. Suelen ser más aplicaciones *in-house*
que aplicaciones que estén a la venta, aunque evidentemente hay
muchísimas aplicaciones para todo tipo de sistemas operativos, todas
las que usamos de forma habitual, que se siguen desarrollando. Este es
un área donde el software libre está ganando al software privativo,
aunque las aplicaciones privativas se convierten en *front-end*s de
escritorio para aplicaciones que son en realidad cliente-servidor. En
cualquier caso, una aplicación de escritorio también se puede
desarrollar para ejecutarse en una consola, y suelen ser buenas
alternativas a aplicaciones CLI para usuarios que no quieren recordar
múltiples opciones.


## Actividad

En esta fase se decidirá el proyecto en sí y qué va a ser (entre
los tipos de aplicaciones mostradas antes) se añadirá al README. Este
fichero deberá contener la palabra *solución* donde se describirá el
tipo de solución informática que se ha elegido.

Conviene que se midan las fuerzas y no se intente nada demasiado
ambicioso (aplicación completa con varios front-end basados en
microservicios) en el tiempo que va a durar este curso, que son 21
días (prácticamente lo que dura un sprint en una empresa). Con crear
un módulo, y si acaso un API, es suficiente. Sí hay que tener muy
claro, sin embargo, el objetivo de ese API (o módulo) y qué problema
se quiere resolver.


## Entrega

Esta entrega se llevará a cabo, como el resto de las mismas, como un
pull request al fichero de [proyectos](../proyectos.md), tras añadir
en el *fork* propio el nombre del proyecto y un enlace al repo, así
como la versión. Recordad que se usa versionado semántico.

