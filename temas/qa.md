# Progresando en calidad

## Planteamiento

La calidad en el software es un tema bastante extenso, que incluye
tanto técnicas específicas como herramientas en cada uno de los
niveles. Hasta ahora hemos tratado de explicar, de forma práctica,
estas herramientas y técnicas; en la última sesión veremos a un nivel
un poco más teórico técnicas y conceptos adicionales usuales en este
área.

## Al final de esta sesión

Se habrá terminado un MVP del proyecto, incluyendo tests de integración, y se
habrá creado una hoja de ruta para abarcar todos los demás aspectos
que necesite. 

## Criterio de aceptación

El repositorio tiene que estar corriendo los tests en Travis, y esos
tests deben pasar. Los tests deben incluir pruebas adicionales,
incluyendo cobertura, y esta cobertura debe llegar al 90%.

## Tests de front-end

En el *front-end* se ejecutan programas en JavaScript, y por tanto
estos programas se deben probar exactamente igual que cualquier
otro. También se denomina pruebas *end-to-end* puesto que se extiende
desde un extremo (el front-end) hasta el otro (*back-end*).

> También se puede programar front-end en aplicaciones de escritorio, aunque hoy en día no son tan populares como las aplicaciones basadas en web; incluso hay frameworks que permiten programar en escritorio exactamente igual que se haría en la web, usando el motor del navegador como motor de presentación.

Por lo tanto, tendremos dos tipos de tests: 

* Tests unitarios (y de integración, en caso de que se incluyan bibliotecas externas o se combinen diferentes módulos). En general, estos se pueden hacer de la misma forma que el resto de los tests unitarios.
* Tests end-to-end o de interacción, que intentarán trabajar con el programa de la misma forma que lo haría un usuario final, es decir, testear los elementos de interfaz d e usuario y cómo cambia este como respuesta a las acciones del usuario.

Hay múltiples bibliotecas que permiten testear este último aspecto. Por ejemplo, [`enzyme`](https://airbnb.io/enzyme/) se usa en conjunción con `React` para testear usando un DOM ficticio. Este tipo de marcos de test se suelen denominar *headless*, ya que en vez de levantar un navegador, incluyen un motor de HTML y JavaScript interno que reacciona de la misma forma que lo haría este navegador; [`cypress`](https://www.cypress.io/) es independiente del marco de programación que se vaya a usar. 

> Hay [diferentes estrategias de testeo del front-end](https://medium.com/@toastui/pragmatic-front-end-testing-strategies-1-4a969ab09453). Son demasiado extensas para tratarlas en este breve curso, pero en todo caso, hay que tener en cuenta que no hay que dejar ningún aspecto de la aplicación sin testear, incluyendo este.

Normalmente, este tipo de tests incluyen la escritura de una especie
de guión en el que se detalla cómo va a ser la navegación y qué se
debe esperar como respuesta. Herramientas como
[`CasperJS`](http://casperjs.org/) te permiten automatizar este tipo
de guiones y llevar a cabo los tests.

## Tests de regresión

En el transcurso de la puesta en producción de una aplicación, sucede
que un test que previamente pasaba de repente empieza a fallar. El
test de regresión no es una técnica específica, ni tiene marcos
específicos, pero consiste en identificar qué cambio ocurrido en el
pasado es el responsable de que suceda esta regresión, a nivel de
*commit*. 

Este tipo de tests necesitan una instrumentación complicada, hasta el
punto de generar una versión de la aplicación para cada uno de los
commits, y poder ejecutar la aplicación en cada una de esas
versiones. Sin embargo, es la única forma de encontrar el código
culpable y una vez la instrumentación está lista, permite resolver los
problemas rápidamente.


## Tests *blue/green* *A/B*

En un entorno de integración y despliegue continuo, en muchas
ocasiones es necesario probar de cara al público dos versiones de un
mismo producto, monitorizándolo y posteriormente eligiendo la versión
que resulte más satisfactoria.

Esta es la esencia de los despliegues [A/B y blue/green](https://dev.to/david_j_eddy/whats-the-difference-ab-testing-vs-bluegreen-deployment-3p77). La
principal diferencia es cuál es el foco principal de cada uno de
ellos. Los despliegues alfa/beta están principalmente enfocados a
determinar la reacción del usuario, mientras que los blue/green están
más relacionados con las prestaciones.

Finalmente, las [publicaciones "canario"](https://blog.getambassador.io/cloud-native-patterns-canary-release-1cb8f82d371a)
siguen una técnica similar: sacar una versión nueva de un
microservicio o producto, de forma que sólo una pequeña parte de
usuarios la use.

Todas estas técnicas confían en algún servicio que actúe como
front-end y decida qué porcentaje de usuarios o de peticiones se
entrega a cada uno de los tipos de producto. 

Para esto, introduzcamos un nuevo concepto: el pórtico del API o *API
Gateway*.

### API gateways y pruebas

Un [API gateway](https://www.nginx.com/learn/api-gateway/) actúa como
el guardián de una galaxia de microservicios, recibiendo peticiones
del front-end y enrutándolas, de forma segura, al microservicio (o microservicios) que se
vaya a encargar de servirla.

En el momento que haya varios microservicios en una aplicación, este
API gateway es esencial para que el usuario (o front-end) no tenga que
conocer las complejidades de cada uno de los mismos. También se puede
encargar de gestionar permisos y puede actuar como *proxy* inverso
para equilibrar la carga de los servicios que gestione.

Este API gateway son aplicaciones que se configuran para que respondan
a diferentes tipos de servicios, y van desde simples proxies inversos
como HAProxy o servidores web de altas prestaciones como `nginx` hasta
aplicaciones específicas como [`Tyk` o `Kong`](https://www.bbva.com/es/tyk-kong-analizamos-estos-dos-api-gateways/),
[`Zuul` o `Linkerd`](https://engineering.opsgenie.com/comparing-api-gateway-performances-nginx-vs-zuul-vs-spring-cloud-gateway-vs-linkerd-b2cc59c65369)o
[`Traefik`](https://github.com/containous/traefik). 

En el caso que nos ocupa, los despliegues que impliquen diferentes
versiones de uno o varios microservicios se gestionan a nivel del API
gateway, por ejemplo, [usando `Traefik` para hacer *canary releases*](https://blog.containo.us/canary-releases-with-traefik-on-gke-at-holidaycheck-d3c0928f1e02). 

Mientras que los *API gateways* están cara al público, para que los
servicios se comuniquen entre sí se usan *service meshes*. 

### Qué es una *service mesh*

Una [*service mesh*](https://medium.com/swlh/a-quick-introduction-to-service-meshes-c4c47c6894b1) 
permite que los microservicios desplegados se despreocupen de con qué
otros microservicios tienen que interaccionar; esta *service mesh* se
encargará de proporcionar descubrimiento de servicios y configuración
automática para que todos los microservicios operen sobre una capa de
abstracción, una *rejilla de servicios*, que le permita usar el resto
sin preocuparse de su ubicación ni del resto de las características
físicas. 

Como la *service mesh* no está expuesta al público, es más propia para
blue/green y canary; las herramientas que se usan son, en muchos
casos, las mismas que hay para API gateway, tales como [Istio](https://istio.io/). Por
ejemplo, [este tutorial describe cómo usar Istio para despliegues Blue/Green](https://thenewstack.io/tutorial-blue-green-deployments-with-kubernetes-and-istio/).

### Bibliotecas para tests A/B 

Estos tests se pueden hacer también a nivel del propio servicio,
usando bibliotecas como [`split`](https://github.com/splitrb/split),
que dividirá automáticamente el tráfico entre diferentes versiones de
una ruta o función. Sin embargo, aunque puede resultar útil en
desarrollo (y en la fase de tests de integración), el tener
varias versiones etiquetadas en el sistema de control de fuentes es
más fácil de gestionar.

Adicionalmente, bibliotecas como
[`sixpack`](http://sixpack.seatgeek.com/) o
[`abba`](https://github.com/maccman/abba). Este último se integra
fácilmente con Heroku, por ejemplo.

> Por alguna razón, todas estas herramientas están escritas en Ruby. 

## Actividad


Hito final del proyecto, con toda la funcionalidad deseada al
principio añadida, tests unitarios y de cobertura con una cobertura
aceptable, y una hoja de ruta para añadir pruebas de calidad a todos
los niveles de ahora en adelante. 
