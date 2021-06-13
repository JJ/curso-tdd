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
aplicación, e incluirá los servicios imprescindibles en la misma.

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

Como en casi todos los casos que vamos a ver ahora, hay tanto
servicios comerciales para esto [como `logz.io`](https://logz.io) o
PaperTrail, pero también loggers de software libre tales como Logstash
(sobre el que se construye todo un *stack*, el ELK de Elastic,
Logstash y Kibana).

Por ejemplo, aquí estaríamos usando un servicio de log en Rust:

```rust
use simple_logger::SimpleLogger;

#[derive(Debug)]
pub enum IssueState {
    Open,
    Closed,
}

#[derive(Debug)]
pub struct Issue {
    state: IssueState,
    project_name: String,
    issue_id: u64,
}

pub fn issue_factory( project_name: String,
                      issue_id: u64) -> Issue {
    log::debug!( "Creating closed issue for project {} with id {}", project_name, issue_id );
    return Issue { state: IssueState::Closed,
                   project_name: project_name,
                   issue_id: issue_id }
}

fn main() {
    SimpleLogger::new().init().unwrap();
    let this_issue = issue_factory(String::from("CoolProject"), 1 );
    let mut that_issue = issue_factory( String::from("CoolProject"), this_issue.issue_id + 1 );
    that_issue.state = IssueState::Open; // Avoid warning
    log::debug!("Changed state to Open");
}

#[cfg(test)]
mod tests {
    use super::*;
    #[test]
    fn check_creation() {
        assert_eq!(issue_factory(String::from("CoolProject"), 1 ).issue_id, 1);
        assert_eq!(issue_factory(String::from("CoolProject"), 1 ).project_name, "CoolProject");
    }
}
```

Rust usa una biblioteca estándar que define un interfaz don los sistemas de log, de forma que las implementaciones sean fácilmente intercambiables entre sí. En este caso, hacemos logging de todos los objetos que hemos creado: en una función *factory* nos encargamos de crear objetos, y como Rust no tiene variables de estado en funciones usamos los propios objetos creados para guardar el estado del último issue.

> Esta primera versión se irá evolucionando, porque hay muchas cosas que podrían mejorarse, como comprobar que dos issues no tengan el mismo id. Se irá haciendo eventualmente a lo largo del curso. 

El logger usado, `SimpleLogger`, escribe en pantalla usando un formato más o menos estándar; en desarrollo este tipo de sistemas de log son totalmente aceptables. En producción, salvo que se use para un logger central y se almacene en un depósito que escale y sea rápido, es mejor usar algún programa o servicio externo.

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

Hay relativamente pocos servicios de este tipo, pero uno de los más
populares es [`etcd`](https://etcd.io/); hay otros, incluso
específicos de lenguaje, que se pueden usar también; finalmente,
servicios un poco más complejos de descubrimiento como
[`consul`](https://www.consul.io/) incluyen también un almacén clave
valor que se puede usar para almacenar la configuración remota.

## Almacenamiento de datos

El almacenamiento de datos actual va mucho más allá de las bases de
datos relacionales, dividiéndose de forma basta en bases de datos SQL
y NoSQL (no sólo SQL), pero este último término simple incluye toda
una complejidad de sistemas de almacenamiento de datos que incluyen
depósitos clave-valor (como [Redis](https://redis.io)), bases de datos documentales (como
Cassandra o Elastic), bases de datos en tiempo real (como RethinkDB) o
bases de datos de grafos (como [Neo4J](https://neo4j.com/)).

La cuestión principal es que cada una de ellas tienen diferentes casos
de uso. Evidentemente, si la información está estructurada limpiamente
en filas y columnas, las bases de datos relacionales son muy
eficientes (pero también todas las opciones libres existentes tienen
su especificidad, que hay que conocer), pero en otros casos, realmente,
es complicado dar con la más adecuada en cada momento.

Además, las bases de datos "tradicionales" están mejorando mucho
añadiendo, por ejemplo, primitivas para almacenamiento y recuperación
de información geográfica o incluso búsqueda dentro de información
estructurada en JSON. La ventaja de las bases de datos tradicionales
es que suelen tener apoyo de grandes empresas, pero también tienen un
desarrollo de decenas de años que hace que sean bastante maduras. Y
como estándar, el SQL no tiene rival; los almacenes de datos modernos
usan todo tipo de cosas, desde lenguajes propios a Lua o JavaScript.

A las opciones libres se añaden opciones comerciales dentro de
plataformas cloud como Firebase (con un marketing muy agresivo
últimamente) o CosmoDB; el problema con estas es que claramente te
estás atando a un servicio, aunque si el diseño abstracto es genérico,
puede ser simplemente cuestión de cambiar la implementación.


## Además

Hemos mencionado en el [capítulo anterior](aplicaciones.md) las
aplicaciones basadas en sistemas de mensajería; evidentemente, esas
necesitarán este tipo de servicio. Todas las plataformas cloud tienen
su propio sistema, pero adicionalmente se pueden usar aplicaciones
como [RabbitMQ](https://www.rabbitmq.com/) para gestionarlo,
directamente o con librerías de tareas como Celery por encima.

Otros servicios, como servidores web, forman parte más bien de la
infraestructura, pero en muchos casos se integran de forma directa con
la aplicación; es el caso de [Green
Unicorn](https://docs.gunicorn.org/en/stable/index.html) con
aplicaciones web de Python, por ejemplo. No se usan *desde la
aplicación*, pero en todo caso forma parte de la infraestructura.

En una infraestructura cloud también harán falta API Gateways, o
pórticos que enlazarán y conocerán a los demás microservicios. Algunos
sistemas como [Traefik](https://traefik.io) o
[Kong](https://konghq.com) son bastante potentes y populares. Salvo
que vayas a usar muchos microservicios, en general no serán necesarios
y para las funciones más básicas `nginx` será suficiente.

## Actividad

Principalmente, en esta sesión se trata de elegir las herramientas que
se van a usar. Mientras que las herramientas libres tienen la ventaja
de que no tienen coste ni limitación alguna, las herramientas
comerciales pueden ser útiles para prototipado rápido o simplemente
familiarizarse con ellas. Así que en este hito habrá que ampliar el
`README.md` con la descripción de las herramientas que se prevé usar
más adelante; de estas, el servicio de *logging* es obligatorio, el
servicio de configuración remota casi (sobre todo si lo que vas a
hacer es un conjunto de microservicios, o uno solo), y servicios
adicionales a gusto del consumidor.

## Entrega

Esta entrega se llevará a cabo, como el resto de las mismas, como un
pull request al fichero de [proyectos](../proyectos.md), tras añadir
en el *fork* propio el nombre del proyecto y un enlace al repo, así
como la versión. Recordad que se usa versionado semántico.

