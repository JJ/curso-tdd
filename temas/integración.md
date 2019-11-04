# Tests de integración.


## Planteamiento

Mientras que los test unitarios se plantean a nivel de clase o de
función, los tests de integración o funcionales comprueban cómo se
integran varias clases en programas de orden superior y cómo se
integran estos con diferentes servicios: bases de datos y APIs que se
coloquen sobre las clases, por ejemplo.

Aunque las técnicas básicas que se usan para este tipo de pruebas son
las mismas, la implementación, en general, será diferente y sobre todo
habrá técnicas específicas para simular partes de la aplicación que no
estén todavía programadas o donde sea complicado o pesado testear a la
vez. 

## Al final de esta sesión

El proyecto tendrá funcionalidad adicional, integrará varias clases o
servicios e incluirá los tests correspondientes para probar que
efectivamente funciona.

## Criterio de aceptación

El repositorio tiene que estar corriendo los tests en Travis, y esos
tests deben pasar.

## Tests funcionales y de integración

Los tests de
integración
[prueban grupos de módulos y clases](https://en.wikipedia.org/wiki/Integration_testing) como
un grupo, de forma que se compruebe que los requisitos funcionales
expresados en las historias de usuario, se cumplan.

En general, los tests de integración son de tipo [caja negra](https://searchsoftwarequality.techtarget.com/answer/Integration-testing-Is-it-black-box-or-white-box-testing), es decir, no pretendemos conseguir una cobertura total de todo el código de lo que estamos integrando (como en el caso de los tests unitarios). Lo que nos interesa es que se *integre* bien con nuestro propio software.

Los tests de integración, a nivel básico, usan las mismas técnicas que los tests unitarios: aserciones y marcos de test. Únicamente se diferencia en lo que se va a sondear. Por ejemplo, escribiremos una serie de tests para comprobar que el API de una clase de la que dependemos no ha variado, y lo haremos al nivel más alto posible.

En el programa en Raku anterior, por ejemplo, necesitamos conocer las estadísticas de issues cerrados de cada uno de los hitos. Añadimos esta función a [`Project.pm6`](../code/lib/Project.pm6):

```
use Stats;
# Más cosas
method completion-summary() {
    my %percentage-completed = self.percentage-completed();
    return summary( %percentage-completed.values.list );
}
```

La función `summary` está en el módulo `Stats`. Tendremos que escribir los tests de integración correspondientes:

```
my $summary = $p.completion-summary();
isa-ok( $summary, List, "Returns a hash");
isa-ok( $summary[0]<mean>, 0.5, "Returns correct average");
```

Estos tests están enfocados principalmente a evitar que el API de la clase integrada derive a algo diferente. Los APIs cambian, y lo pueden hacer de forma inesperada, así que primero nos aseguramos de que lo que devuelve tiene el tipo correcto, y luego que la media está en el primer elemento de la lista y devuelve también el valor correcto.

> El interfaz de esta clase es, en realidad, un poco peculiar, porque sería más adecuado devolver un hash. En un momento determinado, puede que se dé cuenta el propietario y lo cambie, con lo cual este test de integración nos guarda de que tal cosa ocurra.

## Inversión de dependencias y cómo llevarla a cabo.

## Preparación de un módulo para los tests de integración.


## Actividad


