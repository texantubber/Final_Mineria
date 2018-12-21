# Minería y Análisis de Datos Proyecto Final: Predict Future Sales 
## Alejandra Lelo de Larrea Ibarra 000124433,  Dante Ruiz Martínez 183340,  José Carlos Escobar Gutiérrez 175895

Para replicar, hacer pull de los archivos Min_Final.7z.001 al Min_Final.7z009 y
descomprimir con "Descompresion.sh".

### Objetivo

El objetivo de este trabajo es predecir las ventas totales mensuales para cada producto en cada tienda de la compañía *1C Company* (http://1c.ru/eng/title.htm), una de las compañías de software más grandes de Rusia, fundada en 1991 que se especializa en el desarrollo, distribución, publicación y soporte de software de mercado masivo. En sentido sentido, se busca responder a la pregunta ¿cuántos artículos del tipo $j$ se venden en la tienda $k$ al tiempo $t$?


Este problema forma parte de una competencia de Kaggle como examen final del curso "How to win a data science competition" de Coursera. Para más información del concurso consultar la página https://www.kaggle.com/c/competitive-data-science-predict-future-sales


### Metodología y Documentación

Para resolver este problema, seguiremos la metodología CRISP-DM. De esta manera, el proyecto está dividido en 6 secciones: Entendiendo el Negocio, Comprensión de los Datos, Preparación de los Datos, Modelado, Evaluación e Implantación. A continuación se describe cada una de estas fases. 



#### 1. Entendiendo el Negocio

Esta fase del proyecto se encuentra documentada en el archivo **Entendiendo_el_Negocio.html** y su respectivo archivo de origen **Entendiendo_el_Negocio.Rmd**. En dicho archivo se describe lo siguiente: 

1. Información sobre la empresa 1C
    
2. Objetivos del negocio
    
3. Evaluación de la situación
    
4. Objetivos de minería de datos
    
5. Plan de trabajo siguiendo la metodología CRISP-DM
  

Para reproducir el reporte, basta con abrir en RStudio el archivo **Entendiendo_el_Negocio.Rmd** y dar click en el botón *Knit*.



#### 2. Comprensión de los Datos

Esta fase del proyecto se encuentra documentada en el archivo **Comprension_Datos.html** y su respectivo archivo de origen **Comprension_Datos.Rmd**. En dicho archivo se describe lo siguiente: 

1. Proceso de recolección de los datos iniciales: Los datos iniciales se descargaron directamente en bash utilizando la API de Kaggle. Se requiere del archivo **DescargaDatos.sh** para poder reproducir la descarga de los datos.  
    
2. Descripción de los datos: Descripción detallada de cada una de las bases de datos descargadas y las variables que contiene. 

3. Exploración de los datos: En esta fase se incluye la traducción de los catálogos del ruso al inglés utilizando la API de Google Translate (ver el archivo **Traduccion.html** para la documentación del proceso de traducción). Además se incluye la carga de los catálogos, así como de los datos de entrenamiento. Nota: se requiere del archivo **Traduccion.Rmd** para reproducir la traducción de los datos. 

4. Almacenamiento de los datos: Los datos traducidos listos para su exploración se almacenan en el archivo **train\_trad.rds** dentro de la carpeta **Datos\_trad**. 
    
5. Análisis Exploratorio de Datos: En esta fase se incluye el análisis univariado, bivariado y multivariado de los datos. Se hace uso del archivo **01_Libraries.R** y del archivo **02_Utils.R** que contiene los paquetes a utilizar y las funciones auxiliares respectivamente.  
        

Para reproducir el reporte, se debe realizar lo siguiente: 

1. Generar una llave para la API de Kaggle (ver instrucciones en Comprension_Datos.html). 

2. Correr el archivo **DescargaDatos.sh** en la terminal. 

3. Generar una llave para la API de Google Translate (ver instrucciones en Traduccion.html) y sustituirla en el archivo **Traduccion.Rmd**. 

4. Abrir el archivo **Traduccion.Rmd** en RStudio y dar click en el botón *Knit*.

5. Abrir el archivo **Comprension_Datos.Rmd** y dar click en el botón *Knit*.



#### 3. Preparación de los Datos 

Esta fase del proyecto se encuentra documentada en el archivo **Preparacion_Datos.html** y su respectivo archivo de origen **Preparacion_Datos.Rmd**. En dicho archivo se describe lo siguiente: 

1. Selección de los datos: Describe los datos que se van a utilizar. Requiere de la base de datos generada en la fase anterior **train_trad.rds**. 

2. Limpieza de los datos: Se examinan los tipos de variables asignados, se imputan datos faltantes en caso de existir, se examinan los valores únicos en cada variable para detectar errores de dedo y decidir sobre la posible categorización.

3. Ingeniería de características: La base de datos tiene observaciones diarias de las ventas; por lo tanto, primero se realiza la agregación mensual de los datos para poder predecir ventas mensuales. El mayor problema de la base es que se tienen series de tiempo incompletas para la dupla (tienda, artículo). Al ser un problema de series de tiempo, los datos faltantes se completan creando variables de precio promedio y cantidad mensual vendida por artículo, por categoría y por tienda. Además, se crean variables rezagadas a uno, dos, tres, seis y doce meses de precios y cantidades observadas. 

4. Imputación de los datos faltantes: Al calcular rezagos de las series, se obtienen datos faltantes al inicio de las series. Por ser una serie de tiempo, éstos se imputan con el primer valor observado. 

5. Almacenamiento de los datos limpios: La base de datos limpia tiene 45,226,800 observaciones y 59 variables. Ésta se almacena en el archivo **train_mensuales_completo.rds** dentro de la carpeta **Datos_Clean.rds**.


Para reproducir el reporte de esta fase, basta con abrir en RStudio el archivo **Preparacion_Datos.Rmd** y dar click en el botón *Knit*. Nota: Se requiere un equipo de cómputo con al menos 20 GB de memoria RAM para poder reproducir este reporte; además, dependiendo del equipo puede tardar varios minutos en correr. 



#### 4. Modelado 

Se hicieron tres modelos ridge, lasso y xgboost. El que mejor se desempeñó fue el XGBOOST el cual superó en todas las ocasiones el benchmark de 1.67 en el RMSE sobre el conjunto de prueba. La predicción más alta que se obtuvo fue de 0.97 RMSE colocando el modelo en el lugar 667 de 1986. El mejor modelo superó el criterio de éxito del proyecto alcanzando un 0.97 del RMSE.

El procedimiento que se utilizó para obtener los modelos se basó en la metodología CRISP-DM. Una vez entendidas las necesidades del negocio de procedió a armar una base de datos, realizar un análisis exploratorio de datos, se generó una base de datos limpia y con nuevas características, se seleccionaron las variables necesarias para predecir en el futuro y se ajustaron modelos. Los mejores modelos fueron probados en Kaggle para verificar su desempeño y proceder a su optimización.


#### 5. Evaluación 

Se ajustaron los modelos de Regresión, Ridge y Lasso optimizados con el conjunto de prueba. En la siguiente tabla se muestra cómo se desempeñaron en el conjunto de prueba en Kaggle.  Se ajustaron los modelos de Regresión, Ridge y Lasso optimizados con el conjunto de prueba. En la siguiente tabla se muestra cómo se desempeñaron en el conjunto de prueba en Kaggle.

Una vez ajustado el modelo se procede a ajustar el modelo sobre el conjunto de prueba. Se puede observar que para el mes de noviembre de 2015 se predijó la cantidad de unidades vendidas para 214,200 productos por tienda. Algunos valores quedan fuera del rango de 0 y 20, por lo que se deberán ajustar los valores extremos. Se ajustan los valores predichos para que queden en un rango de 0 y 20 como se especificó en las instrucciones de la competencia.  
Las ventas totales de la empresa 1C durante el mes de noviembre de 2015 se proyectaron en 60,966 unidades. Se genera el archivo de predicciones para subir a Kaggle.

Ahora guardamos el modelo en Pickle para posteriormente utilizarlo en el WEB SERVICE en Flask.


#### 6. Implantación

Herramienta de flask para predecir ventas.

Flask es un microframework que permite crear aplicaciones web con pocas líneas de código, se enfoca en proporcionar lo mínimo necesario para poner a funcionar una aplicación básica, por ejemplo, para el prototipado rápido de proyectos.  Incluye un servidor web de desarrollo para prueba de aplicaciones sin tener que instalar mas aplicaciones. Flask cuenta con un depurador y soporte integrado para pruebas unitarias así como soporte para Unicode y es compatible con WSGI 1.0.Esta manera de operar es ideal para poder implementar aplicaciones en un celular o bien a través de una página web, por ejemplo.



#### 7. Presentables:

Comprension_Datos.html: Página web que describe los datos utilizados
Traduccion.html : Página web que describe el proceso para traducir la base de datos
Entendiendo_el_Negocio : Página web que describe el problema del negocio
EDA.html: Página web que presenta el análisis exploratorio de datos
Preparacion_Datos.html : Página web que describe cómo se llevó a cabo la limpieza de los datos y la ingeniería de características.
Modelado.ipynb : Página que describe cómo se llevó a cabo el proceso de modelado.
Evaluacion.ipynb : Página que describe cómo se evaluaron los modelos en Kaggle

Código reproducible:

README.md: Contiene instrucciones de cómo hacer reproducible el producto de ciencia de datos.
- DescargaDatos.sh : Código bash para descargar archivos
- Comprension_Datos.Rmd
- Traduccion.Rmd
- Entendiendo_el_Negocio.Rmd
- EDA.Rmd
- Preparacion_Datos.Rmd
- 01_Libraries.R: Script de R con toda la paquetería necesaria para reproducir el producto.
- 02_Utils.R: Script de R con herramientas para procesar los datos.

App
- predictor.py: el código que se monta como app y funciona como servicio web para predecir ventas.

Carpetas:
- Datos: Contiene los archivos con los datos crudos.
- Datos_trad: Aloja los datos traducidos del ruso al inglés
- Datos_clean: Aloja los datos limpios
- Data_Modelos: Aloja los datos del conjunto de entrenamiento y prueba de los modelos
- Modelo_Final: Aloja los datos del modelo final
- Flask: Aloja el código de la aplicación.