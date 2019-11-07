# Progresando en calidad

## Planteamiento

La calidad en el software es un tema bastante extenso, que incluye
tanto técnicas específicas como herramientas en cada uno de los
niveles. Hasta ahora hemos tratado de explicar, de forma práctica,
estas herramientas y técnicas; en la última sesión veremos a un nivel
un poco más teórico técnicas y conceptos adicionales usuales en este
área.

## Al final de esta sesión

Se habrá terminado el proyecto, incluyendo tests de integración, y se
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



## Actividad


Hito final del proyecto, con toda la funcionalidad deseada al
principio añadida, tests unitarios y de cobertura con una cobertura
aceptable, y una hoja de ruta para añadir pruebas de calidad a todos
los niveles de ahora en adelante. 
