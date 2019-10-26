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
especificaciones y comenzar la implemtación de forma que probar estas
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

* ¿Funcionará si Internet no está conectada?
* ¿Qué pasa si no hay acceso a almacenamiento permanente?
* Si uso una constante en varios sitios, ¿qué pasa si varían las circunstancias? 

Por ejemplo, la [programación
defensiva](https://en.wikipedia.org/wiki/Defensive_programming) trata
de crear código más seguro. 

 En realidad la programación defensiva incluye todas las demás prácticas indicadas aquí, desde los principios de diseño, hasta la metodología SOLID, hasta otras, pero es más una filosofía que consiste en prevenir todos los casos, incluso los imposibles, en el diseño de la lógica de negocio o en los tests. Cosas como

## Actividad

Esencialmente, en esta primera fase se llevarán a cabo las actividades
de diseño para el resto del curso.

1. Elegir un proyecto o un equipo o las dos cosas a la vez, y crear un
   repositorio [usando esta
   plantilla](https://github.com/JJ/curso-qa-template). 
   1. Solicitar el acceso a la beta de [GitHub
      Actions](https://github.com/features/actions) para que se pueda
      usar en el repo.
	  
2. Elaborar una cantidad aceptable de historias de usuario y crear a
   partir de ellas una serie de issues en GitHub. Los hitos deberán
   estar relacionados con estas historias de usuario.
   
3. Describir en el README.md el microservicio que se va a crear,
   explicando las tecnologías que se van a usar en el mismo.
