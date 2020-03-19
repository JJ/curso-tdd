# Inversión de dependencias

## Planteamiento

La implantación de calidad integral fuerza a veces a tomar deciciones de arquitectura que permitan testear fácilmente cada una de las partes de un sistema, consiguiendo el máximo desacoplamiento.

A la vez, el principio de inversión de dependencias es uno de los principios SOLID. Así que merece la pena conocerlo, así como las decisiones de diseño que están detrás de él.

## Al final de esta sesión

Habrá un grupo de clases con acceso a datos o algún servicio externo, la arquitectura reflejará este principio y se habrá testeado adecuadamente.

## Criterio de aceptación

El repositorio tiene que estar corriendo los tests en Travis, y esos
tests deben pasar; tendrá que haber una clase abstracta que se pueda *inyectar* dentro de nuestras clases para acceder a datos.


### Roles o mixins

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

```Perl6
unit role Project::Dator;

method load() {...}
method update( \data ) {...}
```

Los `{...}` indican que, quien quiera que implemente ese rol, tiene forzosamente
 que implementar estos métodos. Este rol define solamente un interfaz, pero como
  las funciones son abstractas, sabemos que quien quiera que implemente ese rol
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

Esta clase `does` el rol anterior, e implementa los dos métodos que tiene que
implementar obligatoriamente. El principio de sustitución de Lyskov se aplica
también aquí: donde quiera que usemos un rol, se puede usar también cualquier
clase que implemente ese rol, por lo que podemos declarar argumentos como
`Project::Dator` sabiendo que vamos a poder usar esas dos funciones, `load` y
`update`.

### Inyectando dependencias

Este principio se basa en el uso, dentro de las clases que necesitan las
dependencias, de objetos que representen estas dependencias. Si representamos
estas dependencias implementan un rol, podemos intercambiarlas fácilmente sin
que la clase que los usa lo detecte.

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

En esta nueva clase tendremos que adaptar las funciones para usar este tipo de
almacenamiento de datos, pero en principio va a ser posible hacerlo sin mucho
problema.

Si queremos imitar ese almacenamiento, simplemente tenemos que usar el mismo
rol:

```perl6
unit class Project::Data::Mock does Project::Dator;

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

```perl6
$dator = Project::Data::Mock.new;
$stored = Project::Stored.new($dator);
```


Este concepto de *mock* o maqueta se puede extender también a cualquier tipo de
objeto que se use para imitar instancias de objetos que no tienen por qué estar
presentes en el momento del test.

> Por ejemplo, [este artículo](https://medium.com/@yeraydiazdiaz/what-the-mock-cheatsheet-mocking-in-python-6a71db997832)
muestra de forma extensa cómo usar mocks en Python. Algunos frameworks como Jest
 permiten también hacer [mocks de forma sencilla](https://jestjs.io/docs/es-ES/manual-mocks).

## Actividad


Lo esencial de este hito es añadir un servicio externo usando el principio de inyección de dependencias. Puede ser un servicio de descarga de datos, o puede ser un servicio de almacenamiento de datos; en realidad, el principio es el mismo. Tanto la clase que se encargue de los datos como la clase con el manejador de datos (dateador) insertado tendrán que testearse.
