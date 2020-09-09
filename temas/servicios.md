# Servicios avanzados en informática


## Planteamiento

Las aplicaciones modernas hacen uso de toda una serie de servicios que
va más allá de la clásica base de datos relacional, para emplear todo
tipo de almacenes de datos, comerciales o de software libre, desde registro
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

El servicio más útil del que posiblemente no has oído hablar es el de
logging o registro. No solamente sirve para lo obvio, registrar
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

No puede haber ningún proyecto sin servicio de registro o logging. La
única cuestión es a qué nivel colocarlo.

> Y, como cualquier tipo de servicio de datos, hay que usar inyección
> de dependencias para que una clase determinada o módulo lo use,
> evitando siempre el acoplamiento fuerte entre servicios y lógica de
> negocio. 

## Configuración remota

La fase final de puesta en producción de una aplicación se llama
*despliegue*; en este despliegue se levantan todos los servicios
necesarios y se echa el código a andar. Sin embargo, esta definición
oculta que los despliegues se pueden hacer de forma continua y que en
cada uno se puede desplegar sólo un microservicio o conjunto de
microservicios. Estos microservicios que se van a levantar necesitan
*descubrir* dónde está el resto de la aplicación para acoplarse a
ella, es decir, necesita una pequeña base de datos distribuida que se
pueda usar para esto con la autorización y autenticación necesaria.

Los servicios de configuración remota son esencialmente eso: bases de
dato clave-valor cuyas instancias en diferentes máquinas están
conectadas entre sí, y permiten independizar al servicio de la
configuración precisa de la máquina en la que se esté ejecutando. Cada
nueva instancia de un servicio consulta a la instancia local del
servicio los valores correspondientes a claves cuyo nombre conoce y es
común a toda la aplicación; estas claves pueden almacenar por ejemplo
IPs o puertos de otros servicios, o localizaciones de otros servicios
o cosas más complicadas.

## Actividad


## Entrega

Esta entrega se llevará a cabo, como el resto de las mismas, como un
pull request al fichero de [proyectos](../proyectos.md), tras añadir
en el *fork* propio el nombre del proyecto y un enlace al repo, así
como la versión. Recordad que se usa versionado semántico.

