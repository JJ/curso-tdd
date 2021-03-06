# Curso de desarrollo ágil - 4ª edición

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

La cuarta edición del curso está en [esta lista de
reproducción](https://www.youtube.com/playlist?list=PLsYEfmwhBQdJJsCTshZw8Ae67lU48wkaA).

Tendremos
estas sesiones:

1. Git y GitHub/GitLab. Uso básico y avanzado de sistemas de control de fuentes y de sitios web para desarrollo colaborativo.
  * Conceptos básicos: pull, pull request, push, clone.
  * *Releases* y *tagging*.
  * [Material](temas/git.md).
  * [Presentación](preso/git).

2. Desarrollo ágil
  * Historias de usuario, *user journeys* y todo eso.
  * Cómo organizar un proyecto: canvas, épicas.
  * *Personas* (usuarios ficticios), desarrollo por capas y todo lo
    que necesitamos para empezar.
  * [Material](temas/ágil.md).
  * [Presentación](preso/ágil.html).

3. Resolviendo problemas usando la informática.
  * Temática: hay vida más allá de cliente-servidor.
  * [Material](temas/aplicaciones.md).
  * [Presentación](preso/aplicaciones.md).

4. Servicios avanzados en informática.
  * Configuración distribuida.
  * Logs.
  * Almacenamiento de datos.
  * [Material](temas/servicios.md).
  * [Presentación](preso/servicios.html).

5. Diseñando la aplicación
   * Historias de usuario
   * Uso de issues/hitos en el desarrollo basado en test.
   * Diseño dirigido por el dominio
   * [Material](temas/diseño.md).
   * [Presentación](preso/diseño.html).

6. Puesta al día
   * Añadiendo *personas* al hito 1
   * [Presentación](preso/checkpoint.html)

7. Refinando el diseño y organizando el desarrollo
   * Algunos principios de diseño
   * [Material](temas/organizando.md).
   * [Presentación](temas/organizando.html)

8. Comienzo de la implementación "defensiva".
    * Documentación de las historias de usuario y traslado a issues.
    * Comienzo del diseño, en general, de las clases.
    * Diseño de excepciones.
    * [Material](temas/a-programar.md).
    * [Presentación](preso/a-programar.html).

9. Task runners y cómo usarlos.
  * Diferentes tipos de task runners y por qué son útiles para todo.
  * [Material](temas/gestores-tareas.md).

10. Preparando tu aplicación para testear: *separation of concerns*, diseño.
  * Cómo asegurarnos desde el diseño de que se cumplen las historias de usuario.
  * [Material](temas/hacia-tests-unitarios.md).

11. *Objetos de test*
  * Organización de los tests.
  * Fases de tests.
  * Aserciones
  * [Material](temas/tests-unitarios-organización.md).

12. Ejecución de tests
  * Marcos de pruebas
  * [Material](temas/tests-unitarios.md).

13. Qué es la integración continua y cómo usarla para ejecutar los tests automáticamente.
  * *Hooks* de git y cómo usarlos para testear todo el tiempo.
  * Diferentes sistemas de integración continua: Travis, GitHub
    Actions...
  * Acelerando con Dockerfiles.
  * [Material](temas/CI.md).

14. Tests de cobertura y por qué son importantes.
  * [Material](temas/cobertura.md).

15. Tests funcionales/de integración
  * Cómo testear microservicios y sistemas basados en tareas.
  * BDD y algunos frameworks.
  * [Material](temas/integración.md).

16. Inversión de dependencias.
  * Mocks.
  * [Material](temas/inversión.md).

17. Tests adicionales
  * Tests de prestaciones.
  * Tests de front-end.
  * Tests de regresión.
  * [Material](temas/qa.md).


## Hitos

Las entregas se organizan en hitos, que corresponden (en general) a
una sesión. Este es el esquema de lo que hay que hacer en cada hito
con enlaces

| Hito | Sesiones | Descripción y enlace |
|------|------------|----------------------|
|  0   | 1          | [Crear repo con componentes](https://jj.github.io/curso-tdd/temas/git#Actividad)|
|  1   | 2,6        | [Idea de problema a resolver](https://jj.github.io/curso-tdd/temas/ágil#Actividad)|
|  2   | 3          | [Épicas, problema a resolver](https://jj.github.io/curso-tdd/temas/aplicaciones#Actividad)|
|  3   | 4          | [Servicios](https://jj.github.io/curso-tdd/temas/servicios#Actividad)|
|  4   | 5          | [Historias de usuario](https://jj.github.io/curso-tdd/temas/diseño#Actividad)|
|  5   | 7          | [Hitos](https://jj.github.io/curso-tdd/temas/organizando#Actividad)|
|  6   | 8          | [Excepciones](https://jj.github.io/curso-tdd/temas/a-programar#Actividad)|
|  7   | 9          | [Gestor de tareas](https://jj.github.io/curso-tdd/temas/gestor-tareas#Actividad)|

## Ideas para resolver

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

Se hará de forma virtual usando [Jitsi](https://meet.jit.si). Las
clases se grabarán también (en la medida de lo posible).

## Clases

- 📅 22 de febrero - 15 de marzo.
  - 🕜 13:30 - 14:00 hora de Madrid (CET)

## Título

A los que superen todos los hitos y actividades planteados en el curso
se les hará una recomendación en LinkedIn por parte del profesor, por
eso se solicita el perfil de LinkedIn en la inscripción. Los
estudiantes tendrán que aceptar la conexión del profesor para poder
hacer esta recomendación.

## Inscripción

Añade tu nick de GitHub y perfil de LinkedIn [a esta
tabla](asistentes.md) mediante un *pull request*. La inscripción es
gratuita y abierta a quien lo desee, pero los asistentes tendrán que
usar su propio equipo.

## Proyectos realizados

Los proyectos en elaboración se enlazarán en [en esta página](proyectos).


## Instrucciones de uso

`make` y `pandoc` deben estar presentes para generar los PDFs.

    make

o

	make doc

generará los proyectos en un solo PDF.
