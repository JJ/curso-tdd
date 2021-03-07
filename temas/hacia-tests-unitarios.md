# Hacia los tests unitarios

## Planteamiento

Aunque el código se debe escribir *después* de los tests, las
definiciones de tipos de datos, argumentos de métodos (especialmente
constructores) y demás, son algo que se puede, y quizás se debe,
escribir *antes* de los tests. En este capítulo veremos una serie de
técnicas, especialmente basadas en el uso del sistema de tipos del
lenguaje, para reducir la cantidad de tests y asegurarnos de la
calidad del software (y su respeto de las especificaciones) antes de
empezar a escribir los mismos.

Por otro lado, muchos lenguajes trabajan con funciones
asíncronas. Merece la pena conocer al menos el funcionamiento básico
de las mismas para poder trabajar adecuadamente con los tests.

## Al final de esta sesión

Se conocerán una serie de técnicas para reducir la cantidad de código
que necesita ser testeado.

## Criterio de aceptación

El estudiante deberá haber empleado correctamente el sistema de tipos
de su lenguaje para tratar de evitar los posibles errores en la
configuración de los objetos de las diferentes clases que se vayan a
usar. Las clases definidas habrán estado guiadas por las historias de
usuario, habiendo escrito sólo lo que se ha solicitado y precisamente
lo que se ha solicitado.

## Historias de usuario, las maravillas del código inexistente y tests

> En este ejemplo y en el siguiente hay realmente código en las
> clases, porque en su estado, ya están testeadas y demás. El código,
> sin embargo, no es lo importante y debéis recordar que se aconseja
> que siempre se escriba el test antes que el código. Así que no
> miréis al código y listo.

Una de las lecciones más importantes en calidad del software (e
informática en general) es que el código que no falla es
el que no se ha escrito. En general, esto se traduce en usar todo tipo
de restricciones a nivel de compilación (tales como la estructura de
tipos, o el protocolo de meta-objetos) para forzar que las cosas ocurran tal
como deben ocurrir sin tener que preocuparte con escribir código que,
en tiempo de ejecución, se encargue de que se respete esa
restricción. Código declarativo
que funciona correctamente según el compilador, y es así por su
estructura y no por el código adicional que se ha escrito, es más
correcto que cualquier otro. Esto también es un ejemplo de
programación defensiva, como ya [hemos visto](a-programar.md).

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
> HU7: El proyecto al que esté asignado y el ID serán constantes a lo
> largo de toda la vida de un issue.

¿Hay código que compruebe si se está cambiando? No. Es la propia
definición y el uso de la sintaxis del lenguaje el que no nos tendrá
que hacer comprobaciones sobre si ha cambiado tal cosa. En la propia
estructura, y sin código, estará asegurado.

> Aquí habría que añadir que las variables privadas en Raku son
> verdaderamente privadas, no se heredan; si en una clase no varían,
> una clase derivada de esa clase no va a lograr que varíen tampoco.

También estamos implementando otra historia de usuario que no habíamos
pensado:

> HU8: El nombre del proyecto será una cadena y el identificador único
> de cada issue será un entero mayor que cero.

Una vez más, de esto nos aseguramos mediante la definición de las
variables de instancia, y mediante el constructor que se asegura de
que le pasen ese tipo y no otro.

Por esta razón es por la que lenguajes con un sistema de tipos estricto como Raku resultan más
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

> (Sólo funcionará de Python 3.4 en adelante, por el uso un tanto
> peculiar de `Enum`).

Pero en todo caso, aquí hacemos varias cosas para llevar a cabo las
mismas historias de usuario de antes.

* Anotaciones de tipo para el nombre del proyecto y el issue.
* Uso de propiedades para indicar los valores que podemos sacar del
  objeto.

Pero hay dos problemas.
* No existen las variables privadas o de sólo lectura en
  Python. Convencionalmente, se
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

Hacemos esto y se queda tan campante. Con revisiones de código
estáticas y
algunas otras medidas se puede asegurar que se comporte correctamente,
pero en todo caso siempre será mejor elegir algún lenguaje en el que
el compilador o intérprete haga ese trabajo por ti. O código adicional
que se asegure de que las restricciones se cumplen en todo caso.

## Funciones asíncronas

La programación asíncrona es todo un mundo, pero un mundo que tenemos
que tener en cuenta a la hora de programar, sobre todo si lo hacemos
con las últimas versiones de Python (desde 3.4, creo), TypeScript u
otros lenguajes como Kotlin o Swift. Mientras que las funciones
"síncronas" o regulares te devuelven un resultado, una función
síncrona te devuelve una *promesa*. Hay que *esperar* (con `await` o
similar) a que esa promesa se cumpla para obtener el valor.

Las funciones asíncronas permiten mucha flexibilidad, porque implican
a nivel bajo un bucle de eventos que va a introducir un evento en el
mismo cuando la función se cumpla; pero también, incluir `await` son
puntos de control en los que el bucle de eventos se detiene y espera a
que la promesa que se está esperando se resuelva. Sin embargo, el
código de las promesas (generalmente entrada salida, pero también
puede ser cualquier cosa) se ejecuta de forma simultánea o secuencial,
dependiendo de si el código es multihebra o con un solo bucle de
eventos; esto es transparente, de todas formas, y más eficiente que
lanzar cada una de las peticiones y esperar el resultado.

Por ejemplo, tenemos esta mini-función en [Deno](https://deno.land) (en realidad,
TypeScript, Deno es un runtime para node/typescript)

```typescript
export const fetchMilestone = async (user: string, repo: string, id: number ): Promise<Response> => {
    let data = await fetch( "https://api.github.com/repos/{user}/{repo}/milestones/{id}" ) 
    return data
}
```

La separación de responsabilidades (que es parte del *do one thing* de
SHOC), implicará que el código asíncrono
tiene que ejecutarse por su cuenta, y sin mezclarse, en lo posible,
con el síncrono; pero en todo caso es una facilidad de programación
que hay que tener en cuenta a la hora de ponerse a diseñar una
aplicación. Evidentemente, este código asíncrono recibirá un
tratamiento especial a la hora de testearlo.

> Deno es un runtime seguro que, además, no te permitirá acceder a la
> red a menos que se lo permitas explícitamente. Ya veremos más sobre
> esto más adelante.

## Actividad

> Este hito corresponderá a la versión 6 `v6.x.x` del proyecto.

Esencialmente, se trata de continuar con el desarrollo de las clases
anteriores, usando todas las técnicas posibles para asegurarse de que
el diseño de las clases captura, en tiempo de compilación, todos los
posibles errores (o simplemente no permite que se produzcan).

Como la clave `ficheros` de `qa.json` admite un array, se pueden
simplemente ir añadiendo a esa los diferentes ficheros que se hayan
ido diseñando.
