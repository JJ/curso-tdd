# Curso de programación para QA -3ª edición

[![Build Status](https://travis-ci.com/JJ/curso-tdd.svg?branch=master)](https://travis-ci.com/JJ/curso-tdd)
💟
[![CircleCI](https://circleci.com/gh/JJ/curso-tdd/tree/master.svg?style=svg)](https://circleci.com/gh/JJ/curso-tdd/tree/master)
💟
[![DevQAGRX](https://img.shields.io/badge/DevQAGRX-blueviolet?style=for-the-badge&logo=Git)](https://github.com/JJ/curso-tdd)
💟
![Comprueba README](https://github.com/JJ/curso-tdd/workflows/Comprueba%20README/badge.svg)

En este curso trataremos de aprender las técnicas necesarias para
trabajar en un entorno de desarrollo, para aplicaciones nativas en la
nube o cualquier otra cosa. Será un curso conceptual, pero también
práctico donde aprenderemos a desarrollar diferentes técnicas en
cualquier lenguaje de programación y diferentes microframeworks. La idea principal es que este curso sirva de introducción a la asignatura de infraestructura virtual o cualquier otra asignatura de informática avanzada.

Cada sesión contendrá una parte teórica y una práctica; la parte
teórica será una clase magistral de 20-30 minutos, seguida de una
parte práctica. Durante el curso se irá elaborando un proyecto en
equipo de dos o tres personas. Cada dos o tres sesiones se tendrá que
alcanzar un hito del proyecto que se haya elegido, que se tendrá que
entregar (y se evaluará de forma más o menos automática) al final de
las mismas. Cuando se completen todas las sesiones y objetivos
generaré un badge para el repo donde se haya cumplido todo (y
dependiendo del nivel en el que se haya alcanzado, se hará también una
recomendación en LinkedIn o donde se solicite).


## Planificación del curso

* **Sesión 1**: Git y GitHub/GitLab. Uso básico y avanzado de sistemas de control de fuentes y de sitios web para desarrollo colaborativo.
  * Conceptos básicos: pull, pull request, push, clone.
  * *Releases* y *tagging*.
  * [Material](temas/git.md).

* **Sesión 2**: Resolviendo problemas usando la informática.
  * Temática: hay vida más allá de cliente-servidor.
  * [Material](temas/aplicaciones.md).

* **Sesión 3**: Servicios avanzados en informática.
  * Configuración distribuida.
  * Logs.
  * Almacenamiento de datos.
  * [Material](temas/servicios.md).
  
* **Sesión vermut**: Análisis de RadarCovid. Aprovechando que han "liberado" RadarCOVID, vamos a ver qué se puede aprender del código publicado sobre lo que se debe (y no se debe hacer) en desarrollo de software de calidad.
  * Dejar claves privadas en el repo
  * Tests
  * Ficheros diversos abandonados.
  * Reproducibilidad de la compilación.
  * ... 

* **Sesión 4**: Requisitos funcionales,
  *personas* (usuarios ficticios), desarrollo por capas y todo lo que necesitamos para empezar.
  * Uso de issues/hitos en el desarrollo basado en test.
  * [Material](temas/diseño.md).

* **Sesión 5**: Comienzo de la implementación "defensiva".
    * Cómo organizar un proyecto: canvas, milestones, issues.
    * Documentación de las historias de usuario y traslado a issues.
    * Comienzo del diseño, en general, de las clases (y excepciones).
    * [Material](temas/a-programar.md).

* **Sesión 6**: Task runners y cómo usarlos.
  * Diferentes tipos de task runners y por qué son útiles para todo.
  * [Material](temas/hacia-tests-unitarios.md).

* **Sesión 7**: Preparando tu aplicación para testear: *separation of concerns*, inversión de dependencias, diseño.
  * Cómo asegurarnos desde el diseño de que se cumplen las historias de usuario.
  * [Material](temas/hacia-tests-unitarios.md).

* **Sesión 8**:  *objetos de test*, aserciones, marcos de pruebas,
  fases del test.
  * [Material](temas/tests-unitarios.md).

* **Sesión 9**: Qué es la integración continua y cómo usarla para ejecutar los tests automáticamente.
  * *Hooks* de git y cómo usarlos para testear todo el tiempo.
  * Diferentes sistemas de integración continua: Travis, GitHub Actions...
  * [Material](temas/CI.md).

* **Sesión 10**:  CI: Acelerando con Dockerfiles.
  * [Material](temas/CI.md#acelerando-los-tests).

* **Sesiones 11**: Tests de cobertura y por qué son importantes.
  * [Material](temas/cobertura.md).

* **Sesión 12**: Tests funcionales/de integración
  * Cómo testear microservicios y sistemas basados en tareas.
  * BDD y algunos frameworks.
  * [Material](temas/integración.md).

* **Sesión 13**: Inversión de dependencias.
  * Mocks.
  * [Material](temas/inversión.md).

* **Sesión 14**: Tests adicionales
  * Tests de prestaciones.
  * Tests de front-end.
  * Tests de regresión.
  * [Material](temas/qa.md).

* **Sesión 15**: Última sesión.
  * Aclaración de dudas.


## Proyectos inicialmente propuestos

* [DEIIT-bot](proyectos/deiit-bot.md), bot para los apuntes de DEIIT.
* [Conversaciones](proyectos/conversaciones.md), escucha y analiza.
  conversaciones en canales de Telegram.
* [Notas](proyectos/notas.md), bot para comunicar notas a estudiantes.
* [Rastreador medios sociales](proyectos/rastreador-social-media.md), escucha y analiza
  conversaciones en medios sociales.
* [Porra](proyectos/porra.md), porras deportivas.
* [Medioambiental](proyectos/medioambiental.md), API para datos
  abiertos medioambientales.
* [Programador de actividades](proyectos/programador-actividades.md),
  para programar actividades accesibles a través de un API.
* [Tráfico](proyectos/tráfico.md), análisis de los mensajes de tráfico
  de Granada.
* [Datos económicos](proyectos/económicos.md), análisis de datos económicos macro o por localidad.

Se puede
usar
[esta plantilla para los proyectos](https://github.com/JJ/curso-qa-template).

## Lugar

Se hará de forma virtual usando Jitsi, Rocket Chat o alguna plataforma libre.

## Clases

De lunes a viernes, 7 al 11 y 14 al 18 de septiembre de 12:30 a 2 de la tarde, 21 al 25 de septiembre 13:45 a 15:00.

## Título

A los que superen todos los hitos y actividades planteados en el curso se les hará una recomendación en LinkedIn por parte del profesor.

## Inscripción

Añade tu nick de GitHub y perfil de LinkedIn [a esta tabla](asistentes.md) mediante un *pull request*. La inscripción es gratuita y abierta a quien lo desee, pero los asistentes tendrán que traer su propio portátil y conexión a Internet (si no tienen acceso al WiFi de la universidad).

## Proyectos realizados

Los proyectos en elaboración se enlazarán en [en esta página](proyectos).


## Instrucciones de uso

`make` y `pandoc` deben estar presentes para generar los PDFs.

    make

o

	make doc

generará los proyectos en un solo PDF.
