Entendiendo el Negocio
================
12/12/2018

-   [Sobre la Empresa](#sobre-la-empresa)
-   [Objetivos del Negocio](#objetivos-del-negocio)
-   [Evaluando la situación](#evaluando-la-situación)
-   [Objetivos de Minería de Datos](#objetivos-de-minería-de-datos)
-   [Plan de Trabajo](#plan-de-trabajo)
-   [Página Web de la Empresa](#página-web-de-la-empresa)

Sobre la Empresa
================

1C Company, en adelante 1C únicamente, una de las compañías de software más grandes de Rusia. Fundada en 1991, esta compañía se especializa en el desarrollo, distribución, publicación y soporte de software de mercado masivo. Actualmente tiene 8,000 distribuidores en 600 ciudades, cerca de 7,500 socios de servicio (que proporcionan información y asistencia para los clientes de 1C) y más de un millon de empresas usurias de sus servicios.

1C es distribuidor oficial de proveedores famosos como Microsoft, Novell, Borland, Symantec, ABBYY, Kaspersky Lab, ProMT, Eset Software y más. Además, ofrece más de 10,000 licencias de software para oficina y uso doméstico.

El sistema de programas "1C: Enterprise 8" está destinado a la automatización de las actividades empresariales cotidianas que incluyen tareas como contabilidad de gestión, contabilidad empresarial, gestión de recursos humanos, etc. Este sistema consta de dos partes: un marco integrado y un conjunto de soluciones aplicadas que son creads y ejecutadas en el marco. Además, tienen más de 30 aplicaciones comerciales "off-the-shelf" (listas para usarse) para tareas de contabilidad, ventas y almacén, cálculo de nómina y gestión de recursos humanos, fabricación y planificación financiera, contabilidad e informes para empresarios privados, contabilidad del sector público, consolidación de informes, entre otros.

El software más importante producido por 1C es el Sistema Empresarial de Productos de Automatización del Negocio. Dentro de este sistema, "1C: Accounting" es el software informatico de contabilidad más exitoso en el CIS y se ha convertido en un estándar industrial en la automatización de la contabilidad empresarial. Otros productos que son famosos de 1C incluyen: 1C:Trade Management, 1C:Payroll&HR y 1C:Money, este último incluye la funcón de declaración de impuestos anual.

Adicionalmente, desde 1996 1C ha desarrollado software para el hogar y el entretenimiento. El software educativo desarrollado por 1C incluye una serie de programas que representan lecciones escolares de matemáticas, lengua rusa, física, química, etc. Además de las materias de educación básica, tienen programas para el estudio de posgrados. En cuanto a entretenimiento 1C ha lanzado títulos clave desarrollados por los principales estudios rusos; por ejemplo Hard Truck y Hard Truck 2 por SoftLab-NSK. La línea "1C: Game Collection" incluye los títulos más vendidos de Activision, Atari, Bethesda, Codemasters, entre otras. También es ampliamente reconocida como desarrollador de juegos incluyendo IL-2 Sturmovik, IL-2 Sturmovik: Forgotten Battles, Ace Expansion Pack y Pacific Fighters.

Objetivos del Negocio
=====================

En este proyecto se pide pronosticar las ventas totales mensuales para cada producto en cada tienda de la compañía *1C Company*. En sentido sentido, la pregunta a responder sería ¿Cuántos artículos del tipo *a* se venden en la tienda *j*?

Este proyecto es relevante ya que, para compañías de gran tamaño, pronosticar las ventas de forma correcta y oportunoa permite la implementación de estrategias de negocio, campañas de marketing, correcta adminstración de inventarios e identificación de áreas de oportunidad en el negocio.

Los datos al alcance contienen información histórica de las ventas diarias desde enero del 2013 y hasta octubre del 2015, por lo que el objetivo es pronósticar las ventas para noviembre 2015.

La lista de productos en cada tienda varía ligeramente cada mes, por lo que el criterio de éxito de este proyecto es la consturcción de un modelo robusto que pronostique adecuadamente las vents mensuales y que sea capaz de adaptarse a variaciones en el inventario.

Evaluando la situación
======================

Los únicos recursos disponibles por parte de la compañía son los datos provistos para el proyecto. Adicionalmente, contamos con nuestros propios equipos de cómputo y una máquina virtual en Azure provista por el profesor para analizar los datos y correr los modelos.

Las posibles contingencias en el desarrollo del proyecto, podrían incluir la imposibilidad de utilizar la máquina virtual de Azure, en cuyo caso se utilizarian simultáneamente los equipos propios para correr los distintos modelos y agilizar el proceso. Otra posible contingencia es agotar el cupón de Azure provisto por el profesor, en cuyo caso, se tendrían que disponer de recursos propios para pagar el tiempo de uso faltante.

En este sentido, y de implementarse de forma permanente el proyecto, el costo mensual de una máquina virtual en Azure sería superado por la ganancia en la predicción de las ventas; ya que, una predicción correcta y oportuna permitiría identificar áreas de oportunidad del negocio, la realización de campañas de marketing para incrementar las ventas, la esitamción del inventario a tener en stock, etc.

Objetivos de Minería de Datos
=============================

Como objetivo técnico se tiene básicamente una tarea de predicción. Para poder responder a la pregunta del negocio, se debe realizar una predicción para cada dupla de la forma (artículo, tienda).

Entre los modelos que se piensan utilizar se incluyen: modelo de regresión lineal, redes neuronales, árboles aleatorios y xgboost.

Para medir el éxito del proyecto en términos de minería de datos, se utilizará el criterio de la raíz del Error Cuadrático Medio (RMSE, por sus siglas en inglés) definido como

$$RMSE=\\sqrt{\\dfrac{1}{n}\\sum\_{i=1}^{n}(y\_i-\\hat{y}\_i)^2)}$$

En este sentido, se busca aquel modelo con el que se obtenga el menor valor de RMSE.

Como criterio de referencia se utilizará el benchmark fijado por la competencia "Predict Future Sales" de Kaggle (<https://www.kaggle.com/c/competitive-data-science-predict-future-sales/leaderboard>) que es de 1.1677. Otro criterio de referencia a utilizar sería el RMSE utilizando las ventas promedio de toda la base como predicción de cada observación.

Plan de Trabajo
===============

Para cumplir con los objetivos de la empresa y de minería de datos se tiene el siguiente plan de trabajo:

1.  Entendimiento de los datos

    1.  Automatizar la descarga de los datos de Kaggle y generar el reporte de recolección de datos iniciales.

    2.  Listar los sets de datos descargados y sus campos.

    3.  Explorar los datos para ver si todas las variables de la base son útiles, si se pueden extaer fácilmente nuevas variables, etc.

    4.  Crear una sóla base datos haciendo un merge de los distintos sets descargados.

    5.  Hacer la agregación mensual de los datos.

2.  Preparación de los datos

    1.  Seleccionar del set de datos completos las variables a utilizar.

    2.  Limpiar los datos

        1.  Dado que se tienen datos de una empresa rusa, revisar si se requieren realizar traducciones.

        2.  Revisar los tipos de variables y arreglar los que no sean correctos.

        3.  Revisar los valores únicos para cada variable y decidir si se categorizan alguna variable o no.

        4.  Revisar si existen datos faltantes. En caso afirmativo, decidir si se eliminan o si se imputan.

        5.  Realizar análisis univariado de los datos.

        6.  Realizar análisis bivariado de los datos.

        7.  Realizar análisis multivariado de los datos.

        8.  Si se detectan datos atípicos decidir si se eliminan o si se imputan.

    3.  Construir nuevas variables (feature engineering)

    4.  Decidir si las variables categóricas se deben convertir con one-hot-encoding.

    5.  Revisar nuevamente los tipos de variables.

    6.  Generar reporte de preparación de los datos.

3.  Modelado

    1.  Seleccionar los algoritmos que se utilizarán para predecir las ventas mensuales (por ahora regresión, redes neuronales, árboles aleatorios, xgboost)

    2.  Dado que los datos que se tienen corresponden a una serie de tiempo, se utilizará la técnica de validación cruzada para generar el diseño de prueba. La partición de los datos será de la siguiente manera: enero-2013 a diciembre-2014 para ajustar modelos y enero-2015 a octubre-2015 para validar los modelos.

    3.  Construir los distintos modelos.

        1.  Seleccionar parámetros adecuados para cada tipo de algoritmo.

        2.  Correr los modelos para obtener pronósticos de las ventas mensuales por dupla (art., tienda).

        3.  Evaluar los modelos con el RMSE.

        4.  Aplicar validación cruzada para elegir los mejores modelos con base en el menor RMSE de cada uno.

        5.  Escribir el reporte del modelado de los datos.

4.  Evaluación

    1.  Decidir si los modelos ajustados cumplen con el objetivo de minería de datos. En caso de que no, decidir qué otros modelos se estimarán.

    2.  Revisar el proceso seguido para ver si no se omitieron pasos importantes.

    3.  Revisar que todos los parámetros e hiperparámetros sean correctos.

5.  Implementación del proyecto.

    5.1 Utilizar fask?? para realizar la implementación del proyecto.

6.  Escribir el reporte final

7.  Realizar la presentación del proyecto.

Página Web de la Empresa
========================

Para mayor información de la empresa se puede consultar la página <http://1c.ru/eng/title.htm>
