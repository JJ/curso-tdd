# Inversión de dependencias

## Planteamiento

La implantación de calidad integral fuerza a veces a tomar decisiones
de arquitectura que permitan testear fácilmente cada una de las partes
de un sistema, consiguiendo el máximo desacoplamiento.

A la vez, el principio de inversión de dependencias es uno de los
principios SOLID. Así que merece la pena conocerlo, así como las
decisiones de diseño que están detrás de él.

## Al final de esta sesión

Habrá un grupo de clases con acceso a datos o algún servicio externo,
la arquitectura reflejará este principio y se habrá testeado
adecuadamente.

## Criterio de aceptación

El repositorio tiene que estar corriendo los tests en Travis, y esos
tests deben pasar; tendrá que haber una clase abstracta que se pueda
*inyectar* dentro de nuestras clases para acceder a datos.

### Roles o mixins

> Vamos primero a entender los principios generales que se suelen
> usar, independientemente de frameworks externos, para implementar la
> inyección de dependencias, y a continuación veremos diferentes
> técnicas usadas para tal inyección de dependencias. Finalmente,
> veremos cómo se usan *dobles de test*, a través de esas inyecciones
> de dependencias, para llevar a cabo difentes técnicas de testing.

En general, los roles o mixins se componen de un interfaz y, en ocasiones, de
una implementación. Se usan en *composición* de objetos: un objeto compone, o
implementa, diferentes roles, tomando todos los métodos y atributos de cada uno
de los roles que componga.

Es una técnica de programación dirigida a objetos alternativa a la herencia para
 creación de nuevas clases. Mientras que en la herencia se heredan los atributos
  y métodos públicos, que se extienden o reimplementan, en composición se
  incluye en la clase así creada tanto el interfaz como la implementación,
  permitiendo creación de objetos más complejos con la característica principal
  de tener el mismo API que los roles que lo componen.

Por ejemplo, podemos definir este rol en Raku:

```Raku
unit role Project::Dator;

method load() {...}
method update( \data ) {...}
```

Los `{...}` son *stubs* que indican que, quien quiera que implemente ese rol, tiene forzosamente
 que implementar estos métodos. El *slash* o barra invertida delante
 del argumento `data` indica que se podrá usar cualquier tipo de
 contenedor, sin fijar ni tipo ni roles.

> En realidad, quien quiera que quiera instanciar una clase que
> implemente ese rol, pero la idea es la misma.


 Este rol define solamente un interfaz, pero como
  las funciones son abstractas, sabemos que quien quiera que
  implemente (o
  *mezcle*) ese rol
  va a tener esas dos funciones. Podemos implementarlo en una clase, por
  ejemplo:

```
use JSON::Fast;

use Project::Dator;

unit class Project::Data::JSON does Project::Dator;

has $!file-name;
has $!data;

method new( $file-name where $file-name.IO ~~ :e ) {
    return self.bless( :$file-name, data => from-json slurp $file-name );
}

submethod BUILD( :$!file-name, :$!data) {}

method load() { $!data }
method update( \data ) { $!data = data }
```

Esta clase `does` (o sea, "hace" o "implementa") el rol anterior, e
implementa los dos métodos que tiene que implementar
obligatoriamente. El principio de sustitución de Lyskov (la regla
básica de programación dirigida a objetos) se aplica también aquí:
donde quiera que usemos un rol, se puede usar también cualquier clase
que implemente ese rol, por lo que podemos declarar argumentos como
`Project::Dator` sabiendo que vamos a poder usar esas dos funciones,
`load` y `update`. Lo haremos a continuación.

En Ruby se definen como `modules` los mixins o roles; un módulo en
Ruby puede incluir tanto atributos como implementación, pero no se
puede instanciar como en el caso de Raku. Por ejemplo,
[aquí](../ejemplos/ruby):

```
module IssueStatus
  OPEN = 1
  CLOSED = 2
end

module Named
  attr_reader :name
end

class Project
  include Named
  attr_reader :issues, :milestones

  def initialize( name )
    @name = name
    @issues = []
    @milestones = []
  end

  class Issue
    include Named
    attr_reader :status

    def initialize( name )
      @name = name
    end
  end

end

```

Definimos el módulo `Named`. Ya que cada una de las clases tiene un ID
o nombre, simplemente usamos en todos el mismo para que tenga un
acceso uniforme; de esa forma también podríamos, por ejemplo, buscar
por nombres de cosas, sin tener en cuenta si son uno u otro. Con
`include Named` lo incluimos en la clase `Project` e `Issue`, que son
las dos que hemos definido. Como ese módulo sólo define un interfaz
(un lector de atributo), inicializar las variables de instancia es
cosa de cada inicializador.

> Obsérvese que el ámbito de la clase `Issue` es el de la otra
> clase. En este caso hemos decidido incluirlo todo en la misma
> clase.

### Inyectando dependencias

Este principio se basa en el uso, dentro de las clases que necesitan
las dependencias, de objetos que las representen, en
vez de acoplar clases (y objetos) a las dependencias de forma
rígida. Si estas dependencias implementan un rol, podemos
intercambiarlas fácilmente sin que la clase que los usa lo detecte.

Por ejemplo, podemos hacerlo en esta clase, `Project::Stored`:

```
unit class Project::Stored does Project;

has Project::Dator $!dator;

# Código de la clase aquí abajo
```

`Project` lo hemos convertido también en un rol para que sea más fácil
componerlo en otras clases; `Project`, como tal rol, se comporta de la misma
forma que una clase si se le usa en este contexto, pero haciéndolo así es más
fácil usar todas las variables privadas, que pasan directamente a formar parte
de la nueva clase. Dentro de esa clase, sin embargo, tenemos a `$!dator`, que
implementa el rol `Project::Dator` y por tanto se puede instanciar con cualquier
 tipo de objeto que siga ese rol.

La inyección de dependencias puede funcionar de esta forma:

```
my $dator = Project::Data::JSON.new($data-file);
my $stored = Project::Stored.new($dator);
```

En esta nueva clase tendremos que adaptar las funciones para usar este
tipo de almacenamiento de datos (en vez de almacenarlos en memoria),
pero en principio va a ser posible hacerlo sin mucho problema.

## Dobles de test

El concepto de [dobles de
test](https://docs.microsoft.com/en-us/archive/msdn-magazine/2007/september/unit-testing-exploring-the-continuum-of-test-doubles)
es un patrón que incluye todos los posibles objetos *falsos* que se
usen para sustituir a verdaderos objetos que sean costosos de
instanciar o, generalmente, tengan alguna dependencia externa.

El tipo de doble más simple es lo que se llama un
[*dummy*](https://blog.pragmatists.com/test-doubles-fakes-mocks-and-stubs-1a7491dfa3da)
o "pelele". Es
simplemente un objeto que se utiliza como *placeholder* en una llamada
a función o instanciación de un objeto, sin que en realidad haga nada.

>*Stub*: lo que queda en un ticket o cheque troquelado, o una colilla.

Por ejemplo, esta clase `NoLogger` es simplemente un stub:

```Ruby
require "project"

PROJECT_NAME = 'Foo'

class NoLogger
end

describe Project do

  before do
    @project = Project.new(PROJECT_NAME,NoLogger.new() )
  end
# continúa
end
```

Como Ruby tiene *duck typing*, se puede pasar cualquier cosa en
realidad. Evidentemente luego no se podrá usar; aunque se puede elevar
su rango a *stub*, que al menos tienen una implementación mínima de un
interfaz para que puedan ser llamadas.

Hay otros tipos de dobles de test.
Por ejemplo, todas las aplicaciones van a usar algún tipo de
almacenamiento. Si queremos testear el comportamiento de una
aplicación, simplemente tenemos que usar el mismo rol:

```raku
unit class Project::Data::Fake does Project::Dator;

has $!data = { "milestones" => [
    {
        "2" => [
            {
                "4" => "Closed"
            },
            {
                "3" => "Open"
            }
        ]
    }
    ],
    "name" => "Foo"
};
```

Se puede instanciar este objeto exactamente de la misma forma para "imitar" la
clase original que da acceso a datos:

```raku
$dator = Project::Data::Fake.new;
$stored = Project::Stored.new($dator);
```

Este tipo de dobles se llaman *fake*s, o simplemente falsos. No tienen
ninguna lógica de negocio, sino que simplemente tienen lo necesario
para responder de forma razonable a las entradas que se produzcan.


Este concepto de *mock* (imitación o maqueta) se puede extender también a cualquier tipo de
objeto que se use para imitar instancias de objetos que no tienen por qué estar
presentes en el momento del test.

> Por ejemplo, [este artículo](https://medium.com/@yeraydiazdiaz/what-the-mock-cheatsheet-mocking-in-python-6a71db997832)
muestra de forma extensa cómo usar mocks en Python. Algunos frameworks como Jest
 permiten también hacer [mocks de forma sencilla](https://jestjs.io/docs/es-ES/manual-mocks).

## Actividad


Lo esencial de este hito es añadir un servicio externo usando el
principio de inyección de dependencias. Puede ser un servicio de
descarga de datos, o puede ser un servicio de almacenamiento de datos;
en realidad, el principio es el mismo. Tanto la clase que se encargue
de los datos como la clase con el manejador de datos (dateador)
insertado tendrán que testearse.

Tendréis que añadir al fichero `qa.json` una hueva clave, `dateador`,
cuyo valor sea el fichero donde habéis implementado la clase abstracta
que sirva de tal, o alguna clase concreta que siga ese patrón.
