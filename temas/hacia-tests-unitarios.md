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

## DRY, números mágicos y otras reglas de programación básicas

"No te repitas a ti mismo" es posiblemente una de las afirmaciones más
famosas del manifiesto por un [código
limpio](https://medium.com/@sheyiogundijo/clean-code-in-a-nutshell-ac7aa5f80a99). Código
repetido indica malas prácticas como mal diseño de tipos, o
simplemente mal diseño de la lógica de negocio. Lo cierto es que el
código repetido no es una característica que uno quiera introducir,
sino que simplemente aparece en las revisiones de código. Una
refactorización debe de mirar todo el código en más profundidad, y
pasar por la creación de funciones o la creación de tipos completos
que permitan, por ejemplo, hacer comprobaciones que si no habría que
repetir en diferentes partes de nuestra aplicación.

> En las revisiones de código de estudiantes, este es uno de los
> errores que se encuentra con más frecuencia. Se debe también a la
> práctica de código "write-only", código que se escribe para una
> práctica o, mucho peor, un examen y que realmente no sirve para nada
> más que para ser corregido. Incluso en un contexto de aprendizaje,
> el código debe crear para satisfacer una serie de necesidades, y por
> supuesto para ser leído por colegas o por uno mismo.

Los "números mágicos" se refieren a literales usados como argumentos a
funciones, o constantes en general sin ningún tipo de nombre. Según
las directrices del código limpio, se deben asignar identificadores
con sentido a todos los datos que se usen en el programa. Un literal
impide darle sentido al mismo. Si hay un valor "1" en un programa y
hay que cambiarlo, ¿se cambian todos los unos? ¿Sólo los del módulo o
la función? Conviene asignarle un identificador, y una constante y
usarla. Así cuando se cambie el valor de la constante se propagará a
todos los lugares donde se use y la factorización será mínima.

> Por la misma razón, hay que intentar reducir la cantidad de
> *lambdas* que se usen. O se les asigna un nombre, o caes en el error
> de repetir código (DRY, como arriba), aparte de usar "números
> mágicos".

Este ejemplo es parte de un test, pero a estos se aplican los mismos
principios:

```nim
import ../project

const projectId= "Foo"
var
  thisProject: Project

thisProject = Project( id: projectId )

assert thisProject.id == projectId

```

En Nim se definen constantes con `const`, y la usamos  para estar
seguros de que el ID del proyecto va a ser siempre el mismo.


### Ejemplos

En el [ejemplo en Raku](ejemplos/raku) tampoco hay tanto código como
para que se encuentren repeticiones *en el mismo módulo*. Sin embargo,
nos encontramos con esto:

```raku
method new-issue( Project::Issue $issue where $issue.project-name eq
$!project-name) {…}
multi method new-milestone( $milestone where $milestone.project-name eq
        $!project-name) {…}
```

Es código repetido al fin y al cabo. ¿A qué se debe? A que, en
principio, se permite que se creen *milestones* *fuera* de un
proyecto, e *issues* *fuera* de un milestone. Es posible que, aunque
esto no esté cubierto por una HU, en un refinamiento posterior debamos
crear una HU que venga a decir que el proyecto es la única fuente de
verdad, y los issues y milestones sólo tienen sentido dentro del
mismo. Llevaremos a cabo un ejemplo (en otro lenguaje) que haga esto.

> Por otro lado, también te muestra que se puede escribir código
> perfectamente válido y que siga las HUs, pero en un entorno de
> programación ágil, se debe estar abierto a modificaciones continuas
> con el objetivo de resolver el problema de la mejor forma posible.

## Pelusilla en el código

En general, todo lo que se ha mencionado arriba, más una serie de
reglas expecíficas de cada uno de los lenguajes, se suelen llamar
"pelusilla" o *lint*, aunque también recibe el nombre de *olor* de
código (*code smell*). Se trata simplemente de construcciones o formas
de hacer las cosas que son o bien no idiomáticas, o antipatrones, o
indican errores más profundos en el diseño o planteamiento.

Para evitar esto se usan lo que se llaman genéricamente *linters*,
herramientas de análisis estático de código que te señalan diferentes
errores, y que son generalmente configurables (para evitar señar
errores que no se consideren en el marco de la empresa) e incluso, en
algunos casos, extensibles. Herramientas como `pylint` (para Python),
`RuboCop` para Ruby, u otras muchas para cada lenguaje (incluso Nim
tiene varias) permiten comprobar el código cada vez que se incorpora
para examinar los errores que pueda haber.

Generalmente, este tipo de herramientas deben estar ahí desde el
principio; si no lo están, hacerlo sobre una base de código por
pequeña que sea hará que se tenga que emplear mucho tiempo en
refactorizarla, y en muchos casos no sólo se tratará de cambios de
formato, sino rediseños más profundos.

Por ejemplo, aplicando `pylint` a nuestos ejemplos de Python, nos
resulta en esto:

```text
************* Module Project.core
Project/core.py:10:0: W0301: Unnecessary semicolon (unnecessary-semicolon)
Project/core.py:1:0: C0114: Missing module docstring (missing-module-docstring)
Project/core.py:1:0: C0115: Missing class docstring (missing-class-docstring)
Project/core.py:6:4: C0116: Missing function or method docstring (missing-function-docstring)
Project/core.py:6:4: E0202: An attribute defined in Project.core line 4 hides this method (method-hidden)
Project/core.py:9:4: C0103: Method name "newMilestone" doesn't conform to snake_case naming style (invalid-name)
Project/core.py:9:4: C0116: Missing function or method docstring (missing-function-docstring)
Project/core.py:12:4: C0116: Missing function or method docstring (missing-function-docstring)
Project/core.py:15:4: C0103: Method name "percentageCompleted" doesn't conform to snake_case naming style (invalid-name)
Project/core.py:15:4: C0116: Missing function or method docstring (missing-function-docstring)
Project/core.py:18:4: C0103: Method name "completionSummary" doesn't conform to snake_case naming style (invalid-name)
Project/core.py:18:4: C0116: Missing function or method docstring (missing-function-docstring)
Project/core.py:21:4: C0116: Missing function or method docstring (missing-function-docstring)
************* Module Project
Project/__init__.py:1:0: C0103: Module name "Project" doesn't conform to snake_case naming style (invalid-name)
************* Module Project.Issue
Project/Issue.py:1:0: C0103: Module name "Issue" doesn't conform to snake_case naming style (invalid-name)
Project/Issue.py:1:0: C0114: Missing module docstring (missing-module-docstring)
Project/Issue.py:9:8: C0103: Attribute name "_projectName" doesn't conform to snake_case naming style (invalid-name)
Project/Issue.py:10:8: C0103: Attribute name "_issueId" doesn't conform to snake_case naming style (invalid-name)
Project/Issue.py:5:0: C0115: Missing class docstring (missing-class-docstring)
Project/Issue.py:12:4: C0116: Missing function or method docstring (missing-function-docstring)
Project/Issue.py:15:4: C0116: Missing function or method docstring (missing-function-docstring)
Project/Issue.py:19:4: C0116: Missing function or method docstring (missing-function-docstring)
Project/Issue.py:23:4: C0103: Attribute name "projectName" doesn't conform to snake_case naming style (invalid-name)
Project/Issue.py:23:4: C0116: Missing function or method docstring (missing-function-docstring)
Project/Issue.py:27:4: C0103: Attribute name "issueId" doesn't conform to snake_case naming style (invalid-name)
Project/Issue.py:27:4: C0116: Missing function or method docstring (missing-function-docstring)
************* Module Project.Milestone
Project/Milestone.py:2:0: C0303: Trailing whitespace (trailing-whitespace)
Project/Milestone.py:18:0: C0304: Final newline missing (missing-final-newline)
Project/Milestone.py:1:0: C0103: Module name "Milestone" doesn't conform to snake_case naming style (invalid-name)
Project/Milestone.py:1:0: C0114: Missing module docstring (missing-module-docstring)
Project/Milestone.py:4:8: C0103: Attribute name "_projectName" doesn't conform to snake_case naming style (invalid-name)
Project/Milestone.py:5:8: C0103: Attribute name "_milestoneId" doesn't conform to snake_case naming style (invalid-name)
Project/Milestone.py:1:0: C0115: Missing class docstring (missing-class-docstring)
Project/Milestone.py:9:4: C0103: Attribute name "projectName" doesn't conform to snake_case naming style (invalid-name)
Project/Milestone.py:9:4: C0116: Missing function or method docstring (missing-function-docstring)
Project/Milestone.py:13:4: C0103: Attribute name "milestoneId" doesn't conform to snake_case naming style (invalid-name)
Project/Milestone.py:13:4: C0116: Missing function or method docstring (missing-function-docstring)
Project/Milestone.py:16:0: C0115: Missing class docstring (missing-class-docstring)
Project/Milestone.py:17:0: W0613: Unused argument 'args' (unused-argument)
Project/Milestone.py:17:0: W0613: Unused argument 'kwargs' (unused-argument)

-----------------------------------
Your code has been rated at 0.00/10
```

Un 0, bueno, es un necesita mejorar. Pero como se ve hay todo tipo de
warnings, desde que no se usa *snake_case* (bueno, vale) hasta
argumentos sin usar. Habrá que emplear un rato en mejorarlo. Por lo
anterior, también, se aconseja que cuando se añada cualquier tipo de
sistema de integración continua se incorpore de forma inmediata un linter.


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

> Este hito corresponderá a la versión 8 `v8.x.x` del proyecto.

Esencialmente, se trata de continuar con el desarrollo de las clases
anteriores, usando todas las técnicas posibles para asegurarse de que
el diseño de las clases captura, en tiempo de compilación, todos los
posibles errores (o simplemente no permite que se produzcan).

Se tendrá que añadir una clave más, `linter`, a `agil.yaml`, con el
nombre del *linter* que se ha usado para comprobar el código. La
ejecución de este linter, como cualquier otra tarea asociada al
proyecto, tendrá que añadirse como tarea para el sistema de gestor de
tareas, usando, por ejemplo, el target "check" (por ejemplo, que haya
que ejecutar `make check` para ejecutar el linter con las opciones
correspondientes).


