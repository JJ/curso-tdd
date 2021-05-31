# Curso de desarrollo ágil - 5ª edición

[![Build Status](https://travis-ci.com/JJ/curso-tdd.svg?branch=master)](https://travis-ci.com/JJ/curso-tdd)
💟
[![CircleCI](https://circleci.com/gh/JJ/curso-tdd/tree/master.svg?style=svg)](https://circleci.com/gh/JJ/curso-tdd/tree/master)
💟
[![DevQAGRX](https://img.shields.io/badge/DevQAGRX-blueviolet?style=for-the-badge&logo=Git)](https://github.com/JJ/curso-tdd)
💟
[![Comprueba texto](https://github.com/JJ/curso-tdd/actions/workflows/check-readme.yml/badge.svg)](https://github.com/JJ/curso-tdd/actions/workflows/check-readme.yml)
💟
[![Test
Nim](https://github.com/JJ/curso-tdd/actions/workflows/nim-test.yaml/badge.svg)](https://github.com/JJ/curso-tdd/actions/workflows/nim-test.yaml)
💟
[![Test Raku](https://github.com/JJ/curso-tdd/actions/workflows/raku-test.yaml/badge.svg)](https://github.com/JJ/curso-tdd/actions/workflows/raku-test.yaml)


## Índice
- [Introducción](#Introducción)
- [Planificación del curso](#Planificación-del-curso)
- [Hitos](#Hitos)
- [Posibles ideas para proyectos](#ideas)
- [Lugar](#Lugar)
- [Título](#titulo)
- [Inscripción](#Inscripción)
- [Proyectos realizados](#Proyectos-realizados)
- [Instrucciones de uso](#Instrucciones-de-uso)


## Introducción

En este curso trataremos de aprender las técnicas necesarias para
trabajar en un entorno ágil de desarrollo, para aplicaciones nativas en la
nube o cualquier otra cosa. Será un curso conceptual, pero también
práctico donde aprenderemos a desarrollar diferentes técnicas en
cualquier lenguaje de programación y diferentes microframeworks. La
idea principal es que este curso sirva de introducción a la asignatura
de infraestructura virtual o cualquier otra asignatura de informática
avanzada.

Cada sesión durará unos 20-30 minutos; el resto del trabajo se hace de
forma asíncrona interaccionando a través de un grupo de
Telegram. Durante el curso se irá elaborando un proyecto en
equipo de dos o tres personas. Se tendrán que alcanzar hitos del
proyecto que se haya elegido que se evaluarán automáticamente usando
tests. Cuando se completen todas las sesiones y objetivos
generaré un badge para el repo donde se haya cumplido todo (y
dependiendo del nivel en el que se haya alcanzado, se hará también una
recomendación en LinkedIn o donde se solicite).


## Planificación del curso

La tercera edición ha [quedado grabada en esta lista de
reproducción](https://www.youtube.com/playlist?list=PLsYEfmwhBQdKVFqzk9VzujTuyiNOKIy2x). El
planteamiento general del curso está en [esta
presentación](/curso-tdd/preso/).

La cuarta edición del curso, ya completa, está en [esta lista de
reproducción](https://www.youtube.com/playlist?list=PLsYEfmwhBQdJJsCTshZw8Ae67lU48wkaA).

Tendremos estas sesiones:

1. Introducción
   * Qué vamos a hacer en el resto del curso, cómo nos vamos a
     organizar
   * Grupos de Telegram, bots en los grupos.
   * [Presentación](preso/index).

2. Git y GitHub/GitLab. Uso básico y avanzado de sistemas de control
   de fuentes y de sitios web para desarrollo colaborativo.
  * Conceptos básicos: pull, pull request, push, clone.
  * *Releases* y *tagging*.
  * [Material](temas/git.md).
  * [Presentación](preso/git).

3. Diseño de una aplicación
   * *Domain driven design*.
   * *Personas* o personajes.
   * [Material](temas/ágil.md#empatizando-con-los-clientes).
   * [Presentación](preso/ddd.html)

4. Resolviendo problemas usando la informática.
  * Temática: hay vida más allá de cliente-servidor.
  * [Material](temas/aplicaciones.md).
  * [Presentación](preso/aplicaciones.md).

5. Servicios avanzados en informática.
  * Configuración distribuida.
  * Logs.
  * Almacenamiento de datos.
  * [Material](temas/servicios.md).
  * [Presentación](preso/servicios.html).

6. Desarrollo ágil
  * Cómo organizar un proyecto: canvas, épicas.
  * Desarrollo por capas y todo lo  que necesitamos para empezar.
  * Historias de usuario, *user journeys* y todo eso.
  * [Material](temas/ágil.md).
  * [Presentación](preso/ágil.html).

7. Diseñando la aplicación
   * Historias de usuario
   * Uso de issues/hitos en el desarrollo basado en test.
   * Diseño dirigido por el dominio
   * [Material](temas/diseño.md).
   * [Presentación](preso/diseño.html).

8. Refinando el diseño y organizando el desarrollo
   * Algunos principios de diseño
   * [Material](temas/organizando.md).
   * [Presentación](temas/organizando.html)

9. Comienzo de la implementación "defensiva".
   * Documentación de las historias de usuario y traslado a issues.
   * Comienzo del diseño, en general, de las clases.
   * Diseño de excepciones.
   * [Material](temas/a-programar.md).
   * [Presentación](preso/a-programar.html).

10. Task runners y cómo usarlos.
  * Diferentes tipos de task runners y por qué son útiles para todo.
  * [Material](temas/gestores-tareas.md).
  * [Presentación](preso/gestores-tareas.md).

11. Preparando tu aplicación para testear: *separation of concerns*, diseño.
  * Cómo asegurarnos desde el diseño de que se cumplen las historias de usuario.
  * [Material](temas/hacia-tests-unitarios.md).
  * [Presentación](preso/hacia-tests-unitarios.html).

12. *Objetos de test*
  * Organización de los tests.
  * Fases de tests.
  * Aserciones
  * [Material](temas/tests-unitarios-organización.md).
  * [Presentación](preso/tests-unitarios-organización.html).

13. Ejecución de tests
  * *Hooks* de git y cómo usarlos para testear todo el tiempo.
  * Marcos de pruebas
  * [Material](temas/tests-unitarios.md).
  * [Presentación](preso/tests-unitarios.html).

14. Qué es la integración continua y cómo usarla para ejecutar los tests automáticamente.
  * Diferentes sistemas de integración continua: Travis, GitHub
    Actions...
  * Acelerando con Dockerfiles.
  * [Material](temas/CI.md).
  * [Presentación](preso/CI.html).

15. Inversión de dependencias.
  * Mocks.
  * [Material](temas/inversión.md).
  * [Presentación](preso/inversión.html).

16. Tests de cobertura y por qué son importantes.
  * Último en la cuarta edición
  * [Material](temas/cobertura.md).
  * [Presentación](preso/cobertura.html).

17. Tests funcionales/de integración/end to end
  * Cómo testear microservicios y sistemas basados en tareas.
  * BDD y algunos frameworks.
  * [Material](temas/integración.md).

18. Tests adicionales
  * Tests de prestaciones.
  * Tests de front-end.
  * Tests de regresión.
  * [Material](temas/qa.md).


## Hitos

Las entregas se organizan en hitos, que corresponden (en general) a
una sesión. Este es el esquema de lo que hay que hacer en cada hito
con enlaces

| Hito | Sesión(es) | Descripción y enlace |
|------|------------|----------------------|
|  0   | 2          | [Crear repo con componentes](https://jj.github.io/curso-tdd/temas/git#Actividad)|
|  1   | 3          | [Idea de problema a resolver](https://jj.github.io/curso-tdd/temas/ágil#Actividad)|
|  2   | 4          | [Gama de aplicaciones](https://jj.github.io/curso-tdd/temas/aplicaciones#Actividad)|
|  3   | 5          | [Servicios](https://jj.github.io/curso-tdd/temas/servicios#Actividad)|
|  4   | 6          | [Desarrollo ágil](https://jj.github.io/curso-tdd/temas/ágil#Actividad)|
|  5   | 7          | [Historias de usuario](https://jj.github.io/curso-tdd/temas/diseño#Actividad)|
|  6   | 8          | [Hitos](https://jj.github.io/curso-tdd/temas/organizando#Actividad)|
|  7   | 8          | [Excepciones](https://jj.github.io/curso-tdd/temas/a-programar#Actividad)|
|  8   | 10          | [Gestor de tareas](https://jj.github.io/curso-tdd/temas/gestores-tareas#Actividad)|
|  9   | 11         | [Linter](https://jj.github.io/curso-tdd/temas/hacia-tests-unitarios#Actividad)|
|  10  | 12         | [Tests y aserciones](https://jj.github.io/curso-tdd/temas/tests-unitarios-organización#Actividad)|
|  11  | 13         | [Marcos de test](https://jj.github.io/curso-tdd/temas/tests-unitarios#Actividad)|
|  12  | 14         | [Integración continua](https://jj.github.io/curso-tdd/temas/CI#Actividad)|
|  13  | 15         | [Inyección de dependencias](https://jj.github.io/curso-tdd/temas/inversión#Actividad)|
|  14  | 16         | [Tests de cobertura](https://jj.github.io/curso-tdd/temas/cobertura#Actividad)|

Esta información te la da el bot `kke`, añadido al grupo de Telegram
del curso, o con una conversación directa con él.

## <a name="ideas">Posibles ideas para proyectos, problemas para resolver </a>

La informática consiste en resolver problemas del usuario mediante un
ordenador. Estos son algunos de los problemas con los que se podría tratar.

* [DEIIT-bot](problemas/deiit-bot.md), resuelve problemas de búsqueda
  en apuntes.
* [Conversaciones](problemas/conversaciones.md), trata de buscar
  patrones en conversaciones en canales de Telegram.
* [Notas](problemas/notas.md), comunicar las notas a estudiantes..
* [Rastreador medios sociales](problemas/rastreador-social-media.md),
  encontrar patrones en medios sociales.
* [Porra](problemas/porra.md), resuelve el problema de organizar
  porras entre amigos..
* [Medioambiental](problemas/medioambiental.md), visualizar datos medioambientales.
* [Programador de actividades](problemas/programador-actividades.md),
  programación de actividades accesibles.
* [Tráfico](problemas/tráfico.md), análisis de los mensajes de tráfico
  de Granada.
* [Datos económicos](problemas/económicos.md), análisis de datos económicos macro o por localidad.

Se puede
usar
[esta plantilla para los proyectos](https://github.com/JJ/curso-qa-template).

## Lugar

Se hará en la plataforma de [Spain AI](https://spain-ai.com). El
enlace se proporcionará en el grupo de Telegram en el que están los
inscritos.


## "Título" o acreditación de haber realizado el curso. <a name="titulo"></a>

[Spain AI](https://spain-ai.com) proporcionará un título en PDF al
final del curso.

## Inscripción

Inscríbete en
[EventBrite](https://www.eventbrite.es/e/entradas-ai-tech-learning-curso-de-desarrollo-agil-4a-edicion-151778007105). La
inscripción es gratuita.

## Proyectos realizados

Los proyectos en elaboración se enlazarán en [en esta
página](proyectos). Los de las ediciones anteriores están en [este directorio](otras-ediciones/).

## Instrucciones de uso

`make` y `pandoc` deben estar presentes para generar los PDFs.

    make

o

	make doc

generará los proyectos en un solo PDF.

Si tienes instalado [`mask`](https://github.com/jakedeichert/mask),
puedes usarlo también.
