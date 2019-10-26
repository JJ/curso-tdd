# Diseño de una aplicación


## Planteamiento

En general, la calidad es un proceso, y no simplemente una
característica que se añade en un momento determinado al producto. El
producto, en nuestro caso el software, debe estar diseñado y pensado
desde el principio para asegurar que funciona y que responde a todos
los requisitos funcionales y de otro tipo que se hayan planteado.

Por eso, en un curso principalmente dedicado al diseño de tests se
debe partir del planteamiento de la propia 
aplicación o biblioteca, porque se realizan pruebas sobre las
especificaciones de la aplicación, no se puede quedar en la sintaxis y
una enumeración de los frameworks disponibles.

## Al final de esta sesión

Los estudiantes sabrán como plantear una aplicación a partir de sus
especificaciones y comenzar la implementación de forma que probar estas
especificaciones sea sencilla y directa. También sabrán como plasmar
en plataformas de desarrollo colaborativo estos requisitos para llevar
a cabo el desarrollo de la aplicación. 


## Diseño dirigido por dominio

## SOLID

## Buenas prácticas en el diseño de código.

Durante el ciclo de vida del software, los programas van evolucionando
por muchas razones. Cambian las prácticas, cambian el software sobre
el que se han construido (bibliotecas, lenguajes), se encuentran
errores, cambia la comprensión del problema... Un programa debe
diseñarse de forma que no se rompa (totalmente) con este cambio.

Por ejemplo, la [programación defensiva](https://en.wikipedia.org/wiki/Defensive_programming) trata
de crear código más seguro.

 En realidad la programación defensiva incluye todas las demás prácticas indicadas aquí, desde los principios de diseño, hasta la metodología SOLID, hasta otras, pero es más una filosofía que consiste en prevenir todos los casos, incluso los imposibles, en el diseño de la lógica de negocio o en los tests. Cosas como

* ¿Funcionará si Internet no está conectada?
* ¿Qué pasa si no hay acceso a almacenamiento permanente?
* Si uso una constante en varios sitios, ¿qué pasa si varían las circunstancias?

Como la programación defensiva es más una filosofía, y una que deberíamos paracticar a lo largo del curso, hay técnicas específicas que se suelen usar. Por ejemplo, [*clean code*](https://medium.com/@sheyiogundijo/clean-code-in-a-nutshell-ac7aa5f80a99) o código limpio. Una serie de reglas nos invitarán a usar nombres razonables para las variables, a no repetir código "que ya modificaremos luego" o que debería ser parametrizado en una sola pieza, pero lo más importante desde el punto de vista de la calidad es

* Las funciones solo deberían hacer una cosa. Esto es importante desde el punto de vista de los tests unitarios: probar todas las opciones posibles de una función que hace un montón de cosas hace que los tests sean más complicados o incluso imposibles. Además, deberían tener un número limitado de argumentos, y deberían ser pequeñas, idealmente visibles en un solo pantallazo (aunque las pantallas de hoy en día pueden ser muy largas). Una regla es que deberían tener entre 5 y 15 líneas.
> Evidentemente, aquí también incluimos bloques de código, que deberían de ser naturalmente más pequeños, y métodos de clases.

* Los tipos de datos deberían usarse para lo que son. `False` es que no es verdadero, no que se ha producido un error dentro de una función. `-1` es el resultado de restar 1 a 0, no un índice imposible si no se encuentra algo dentro de una lista o cadena. 

## Actividad

Esencialmente, en esta primera fase se llevarán a cabo las actividades
de diseño para el resto del curso.

1. Elegir un proyecto o un equipo o las dos cosas a la vez, y crear un
   repositorio 
   [usando esta plantilla](https://github.com/JJ/curso-qa-template). 
   1. Solicitar el acceso a la beta de [GitHub Actions](https://github.com/features/actions) para que se pueda
      usar en el repo.
	  
2. Elaborar una cantidad aceptable de historias de usuario y crear a
   partir de ellas una serie de issues en GitHub. Los hitos deberán
   estar relacionados con estas historias de usuario.
   
3. Describir en el README.md el microservicio que se va a crear,
   explicando las tecnologías que se van a usar en el mismo.
