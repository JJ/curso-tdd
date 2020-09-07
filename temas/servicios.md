# Servicios avanzados en informática


## Planteamiento

Las aplicaciones modernas hacen uso de toda una serie de servicios que
va más allá de la clásica base de datos relacional, para emplear todo
tipo de servicios, comerciales o de software libre, desde registro
hasta servicios de mensajería. Trataremos de dar un panorama parcial
de estos servicios, para que se conozcan sus casos de uso y cuando
usarlos en una aplicación.

## Al final de esta sesión

Conocerán los conceptos de logs, tareas, servidores de aplicaciones y
otros conceptos que se podrán usar en una aplicación.

## Criterio de aceptación

El equipo decidirá cuales de estos servicios pueden ser útiles en su
aplicación. 

## Servicios de logs

El servicio más util del que posiblemente no has oído hablar es el de
logging o registro. No sólamente sirve para lo obvio, registrar
eventos para poder hacer análisis de prestaciones y de uso de los
diferentes servicios, sino que puede llegar hasta el punto de
construir toda una arquitectura basada en logs (en vez de hacerlo
basada en almacenamiento de datos), la llamada [arquitectura kappa](https://milinda.pathirage.org/kappa-architecture.com/).

Algunos lenguajes (como Python) incluyen facilidades para este tipo de
servicios en la librería básica; en otros casos hay simplemente que
elegir alguna biblioteca popular. Como en muchos otros casos, hay
bibliotecas genéricas, que se instancian con diferentes *drivers* para
servicios específicos, y bibliotecas específicas, que sirvan
exclusivamente para un tipo específico de sistema de logging.

## Actividad


## Entrega

Esta entrega se llevará a cabo, como el resto de las mismas, como un
pull request al fichero de [proyectos](../proyectos.md), tras añadir
en el *fork* propio el nombre del proyecto y un enlace al repo, así
como la versión. Recordad que se usa versionado semántico.

