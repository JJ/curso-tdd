# Curso de programación para QA -2ª edición

[![Build Status](https://travis-ci.com/JJ/curso-tdd.svg?branch=master)](https://travis-ci.com/JJ/curso-tdd) 💟 [![CircleCI](https://circleci.com/gh/JJ/curso-tdd/tree/master.svg?style=svg)](https://circleci.com/gh/JJ/curso-tdd/tree/master) [![DevQAGRX](https://img.shields.io/badge/DevQAGRX-blueviolet?style=for-the-badge&logo=Git)](https://github.com/JJ/curso-tdd)

En este curso trataremos de aprender las técnicas necesarias para
tabajar en un entorno de desarrollo, para aplicaciones nativas en la
nube o cualquier otra cosas. Será un curso conceptual, pero también
práctico donde aprenderemos a desarrollar diferentes técnicas en
cualquier lenguaje de programación y diferentes microframeworks.

Cada sesión será una parte teórica y una parte práctica; durante el
curso se irá elaborando un proyecto en equipo de 2 o tres
personas. Cada hito del proyecto se tendrá
que entregar (y se evaluará de forma más o menos automática) al final de
la misma. Cuando se completen todas las sesiones y objetivos generaré
un badge para el repo donde se haya cumplido todo (y dependiendo del
nivel en el que se haya alcanzado, se hará también una recomendación
en LinkedIn o donde se solicite).


## Planificación del curso

* Historias de usuario, requisitos funcionales, *personas* y todo lo que necesitamos para empezar.
  * Uso de issues/hitos en el desarrollo basado en test.
  * [Material](temas/diseño.md).

* Preparando tu aplicación para testear: herramientas de construcción,
  desarrollo por capas, *separation of concerns*, inversión de
  dependencias, *objetos de test*, aserciones, marcos de pruebas,
  fases del test.
  * [Material](temas/test-unitarios.md).

* Qué es la integración continua y cómo usarla para ejecutar los tests automáticamente.
  * *Hooks* de git y cómo usarlos para testear todo el tiempo.
  * Diferentes sistemas de integración continua.
  * Acelerando con Dockerfiles.
  * [Material](temas/CI.md).

* Tests de cobertura y por qué son importantes.
  * [Material](temas/cobertura.md).

* Tests funcionales/de integración
  * Cómo testear microservicios y sistemas basados en tareas.
  * BDD y algunos frameworks.
  * Mocks.
  * [Material](temas/integración.md).

* Tests adicionales
  * Tests de front-end
  * Tests de regresión.
  * [Material](temas/qa.md).

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

Aula de usos múltiples, 5ª planta de la [ETSIIT](https://etsiit.ugr.es)

## Clases

Presenciales, martes 2 a viernes 6 de marzo, jueves y viernes 12 y 13 de marzo, 13:30 a 15:00.

## Título

A los que superen todos los hitos y actividades planteados en el curso el curso se les hará una recomendación en LinkedIn por parte del profesor.

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
