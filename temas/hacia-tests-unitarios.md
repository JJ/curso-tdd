# Hacia los tests unitarios

## Planteamiento

En un proceso de calidad del software, es tan importante el planteamiento de la clase y las herramientas que se usan para gestionar las tareas de un proyecto como el código que se escriba para asegurarnos de que efectivamente se cumplen las historias de usuario. Conviene desacoplar el diseño de la clase, sin embargo, del código que se implementa en el mismo, porque es el diseño el que debe seguir las historias de usuario, mientras que el código se asegura de que tengan el resultado deseado.

Por supuesto, todo en un proyecto se va a ejecutar desde un task runner, así que será lo primero que se vea en esta sesión.

## Al final de esta sesión

El estudiante habrá elegido un task runner, y habrá programado el interfaz de una clase correspondiendo a la historia de usuario o historias que desee, terminando el primer hito.

## Criterio de aceptación

Se habrá implementado el interfaz de una clase y un fichero de un task
runner que contenga, al menos, la instalación de dependencias si fuera
necesario. 

## Historias de usuario, las maravillas del código inexistente y tests

> En este ejemplo y en el siguiente hay realmente código en las clases, porque en su estado, ya están testeadas y demás. El código, sin embargo, no es lo importante y debéis recordar que siempre se escribe el test antes que el código. Así que no miréis al código y listo.


Una de las lecciones más importantes es que el código que no falla es
el que no se ha escrito. En general, esto se traduce en usar todo tipo
de restricciones a nivel de compilación (tales como la estructura de
tipos, o el protocolo meta-objetos) para que las cosas ocurran tal
como deben ocurrir sin tener que preocuparte con escribir código que,
en tiempo de ejecución, haga que se respete esa restricción. Código
que funciona correctamente según el compilador, y es así por su
estructura y no por el código adicional que se ha escrito, es más
correcto que cualquier otro. Esto también es un ejemplo de
programación defensiva.

### Ejemplo en Raku

Generalmente, lenguajes que ofrecen tipos graduales o tipos estáticos
son más estrictos, en este sentido, que otros que no lo exigen. Si
además el protocolo de meta-objetos (es decir, el que permite diseñar
el sistema de clases, roles y módulos) añade restricciones
adicionales, tenemos todo lo que deseamos. Por ejemplo, la clase
`Issue` en Raku:

```Raku
enum IssueState <Open Closed>;

unit class Project::Issue;

has IssueState $!state = Open;
has Str $!project-name;
has UInt $!issue-id;

multi submethod BUILD( UInt :$!issue-id!,
            Str :$!project-name!,
            IssueState :$!state = Open) {}


method close() { $!state = Closed }
method reopen() { $!state = Open }
method project-name( --> Str ) { return $!project-name }
method issue-id( --> UInt ) { return $!issue-id }
method state( --> IssueState ) { return $!state }
```

Esta clase tiene que respetar todas las historias de usuario
correspondientes. Por ejemplo, el constructor (`BUILD`) se asegura de
que el estado del issue esté abierto; hay funciones para cambiar el
estado. Pero lo importante es que todas las variables de instancia son
privadas (con `$!`), con lo que el propio compilador se va a asegurar
de que la única forma de cambiarlas sea a través de los métodos que
cambian su valor.

Adicionalmente, podríamos añadir una historia de usuario adicional,
HU7
> HU7: El proyecto al que esté asignado y el ID serán constantes a lo largo
de toda la vida de un issue.

¿Hay código que compruebe si se está cambiando? No. Es la propia
definición y el uso de la sintaxis del lenguaje el que no nos tendrá
que hacer comprobaciones sobre si ha cambiado tal cosa. En la propia
estructura, y sin código, estará asegurado.

También estamos implementando otra historia de usuario que no habíamos
pensado:

> HU8: El nombre del proyecto será una cadena y el identificador único
> de cada issue será un entero mayor que cero.

Una vez más, de esto nos aseguramos mediante la definición de las
variables de instancia, y mediante el constructor que se asegura de
que le pasen ese tipo y no otro.

Por esta razón es por la que lenguajes como Raku resultan más
apropiados para aplicaciones de cierta entidad que otros.

### Python y sus restricciones: no todo el monte es orégano.

Esta sería la definición del mismo tipo de datos en Python

```python
from enum import Enum

IssueState = Enum('IssueState', 'Open Closed')

class Issue:

    def __init__(self, projectName: str, issueId: int ):
        self._state = IssueState.Open
        self._projectName = projectName
        self._issueId = issueId

    def close(self):
        self._state = IssueState.Closed

    def reopen(self):
        self._state = IssueState.Open

    @property
    def state(self):
        return self._state

    @property
    def projectName(self):
        return self._projectName

    @property
    def issueId(self):
        return self._issueId
```

(Sólo funcionará de Python 3.4 en adelante, por el uso un tanto
peculiar de `Enum`).

Pero en todo caso, aquí hacemos varias cosas para llevar a cabo las
mismas historias de usuario.

* Anotaciones de tipo para el nombre del proyecto y el issue.
* Uso de propiedades para indicar los valores que podemos sacar del
  objeto.
  
Pero hay dos problemas.
* No existen las variables privadas o de sólo lectura en Python. Se
  indica con un subrayado en el primer carácter que son privadas, pero
  eso es una simple convención. Si queremos asegurarnos de que son
  privadas o no se alteran, tendremos que usar estructuras de datos
  específicas (y más lentas).
* Tampoco podemos añadir anotaciones de tipos a las variables de
  instancia. 

```
>>> from Project.Issue import Issue
>>> issue = Issue("X",33)
>>> issue._issueId = "Pepillo"
```

Hacemos esto y se queda tan campante. Con revisiones de código y
algunas otras medidas se puede asegurar que se comporte correctamente,
pero en todo caso siempre será mejor elegir algún lenguaje en el que
el compilador o intérprete haga ese trabajo por ti.

## Actividad

> Este hito corresponderá a la versión 1 `v1.x.x` del proyecto.

A partir del diseño creado en la anterior actividad, y siguiendo las
prácticas de uso de los issues (y su cierre desde un *commit*), crear
el interfaz de al menos una clase básicas que corresponda a la misma entidad (según
el dominio del problema que se haya elegido), esta funcionalidad debe corresponder a las historias de usuario que se hayan planteado, y el nombre de las funciones debe ser suficientemente explícito.

El repositorio tendrá que incluir un fichero de configuración para poder llevar a cabo los tests de evaluación del proyecto llamado `qa.json` con la siguiente estructura:

```json
{
    "lenguaje" : "Nombre del lenguaje",
    "build" : "Makefile",
    "clase" : "lib/nombre/del/fichero.pm6"
  
}
```

En vez de `Makefile`, se usará el nombre del fichero de construcción que se haya usado para ejecutar los tests, que tendrá que estar presente en el repositorio; el nombre del fichero de clase que se haya creado también deberá ponerse el que corresponda.

> Se aconseja no crear a mano el fichero JSON, o si se hace, que se compruebe online o donde sea. Cualquier editor de programación será capaz de crear uno sintácticamente correcto, de todas formas.
