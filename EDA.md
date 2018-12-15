Datos: Entendimiento y Análisis Exploratorio
================

-   [Entendimiento de los datos.](#entendimiento-de-los-datos.)
    -   [Recolección de los datos iniciales](#recolección-de-los-datos-iniciales)
    -   [Descripción de los datos](#descripción-de-los-datos)
    -   [Exploración de los datos](#exploración-de-los-datos)
        -   [Traducción del ruso al inglés](#traducción-del-ruso-al-inglés)
        -   [Cargar catálogos y datos entrenamiento](#cargar-catálogos-y-datos-entrenamiento)
        -   [Catálogo de artículos y categorías](#catálogo-de-artículos-y-categorías)

``` r
source('02_Utils.R')
```

Entendimiento de los datos.
===========================

Recolección de los datos iniciales
----------------------------------

La recolección de los datos iniciales se realiza directamente desde la terminal. Para ello es necesario realizar los siguientes pasos:

1.  Asegurarse de que se tiene una versión de python 3 o superior. De no ser así, actualizar python (por ejemplo, se pueden seguir las instrucciones en <https://docs.python-guide.org/starting/install3/osx/>).

2.  Acceder a su cuenta de Kaggle. De no tener una, es necesario registrarse en <https://www.kaggle.com/>.

3.  Una vez que se accedió a la cuenta, ingresar a la sección **"My Account"**

    <img src="img/fig_kaggle1.png" width="300" />

4.  Obtener un token en formato .json en la sección **API** seleccionando el boton **"Create New API Token"**. Guardar este token en la carpeta de **"Downloads"** del directorio raíz. ![](img/fig_kaggle2.png)

5.  Correr el archivo **DescargaDatos.sh** en la terminal. Este archivo:

    1.  Installa la API de Kaggle.

    2.  Crea el directorio **.kaggle** en la raíz.

    3.  Transfiere el token a la carpeta del paso anterior.

    4.  Crea la carpeta **Proyecto\_Final** en dentro del directorio **Documents**.

    5.  Crea las carpetas **Datos**, **Datos\_trad** y **Datos\_clean** dentro del directorio del proyecto final.

    6.  Descarga los datos de la competencia *Predict Future Sales* en la carpeta **Datos**.

    7.  Descomprime los archivos con extensión **.gz**

Descripción de los datos
------------------------

Se obtuvieron datos históricos de las ventas diarias de la compañía "1C Company" (en adelante 1C únicamente). A continuación se describe cada uno de los sets de datos.

1.  **items.csv**. Contiene información suplementaria sobre los artículos de vendidos por 1C. Este archivo contiene 22,171 observaciones para 3 variables. Las variables que incluye son:

    1.  *item\_name*: nombre del artículo (en ruso).

    2.  *item\_id*: identificador único del artículo.

    3.  *item\_category\_id*: identificador único de la categoría a la que pertenece el artículo.

2.  **item\_categories.csv**. Contiene información suplementaria sobre las categorías de los artículos vendidos por 1C. Este archivo contiene 84 observaciones para 2 variables. Las variables que incluye son:

    1.  *item\_category\_name*: nombre de la categoría (en ruso).

    2.  *item\_cateogry\_id*: identificador único de la categoría.

3.  **shops.csv**. Contiene información suplementaria sobre las tiendas de 1C. Este archivo contiene 60 observaciones para 2 variables. Las variables que incluye son:

    1.  *shop\_name*: nombre de la tienda (en ruso).

    2.  *shop\_id*: identificador único de las tiendas de 1C.

4.  **sales\_train.csv**. Contiene los datos de entrenamiento para el proyecto. Este archivo contiene 1,048,575 de observaciones para 6 variables. Las variables que incluye son:

    1.  *date*: fecha en que se registró la compra/devolución en el formato dd/mm/yyyy.

    2.  *date\_block\_num*: número consecutivo para el mes de venta. Es decir, enero 2013 es igual a 0, febrero 2013 es igual a 1, ..., octubre 2015 es igual a 33.

    3.  *shop\_id*: identificador único de las tiendas de 1C en que se vendió/devolvió el artículo.

    4.  *item\_id*: identificador único del artículo de 1C que se vendió/devolvió.

    5.  *item\_price*: precio en el que se vendió el artículo. No se menciona la moneda en que realizó la transacción, posiblemente fueron dólares o rublos rusos.

    6.  *item\_cnt\_day*: número de unidades vendidas del artículo. Números negativos indican una devolución del artículo. Se va a predecir una cantidad mensual de esta medida.

5.  **test.csv**. Contiene los datos de las tiendas y artículos para los cuales se tiene que predecir las ventas mensuales. Este archivo contiene 214,200 observaciones para 3 variables. Las variables que incluye son:

    1.  *ID*: identificador único para la dupla (tienda,artículo).

    2.  *shop\_id*: identificador único de la tienda.

    3.  *item\_id*: identificador único del artículo.

6.  **sample\_submission\_csv**. Contiene la muestra de la forma en que se deben ingresar las predicciones en el concurso. Contiene 214,200 observaciones para 2 variables. Las variables que incluye son:

    1.  *ID*: identificador único para la dupla (tienda,artículo).

    2.  *item\_cnt\_month*: predicción mensual del artículo en la tienda representada por ID.

Exploración de los datos
------------------------

Para poder realizar una exploración de los datos, primero es necesario convertir los campos en ruso a un idioma que podamos entender. Elegimos la traducción al inglés para tratar de ganar la mayor precisión posible.

### Traducción del ruso al inglés

Para la traducción de los catálogos del ruso al inglés se utilizó la librería translateR de R y la API de Google Translate. Los datos traducidos se almacenaron en el objeto **transdata.RData**. Dentro de este objeto se encuentran los siguientes data\_frames:

1.  **item\_category\_ru**: corresponde al archivo **item\_category.csv** original. Es decir, con el nombre de las categorías sólo en ruso.

2.  **item\_category\_en**: correpsonde al archivo **item\_category.csv** con los nombres de las categorías tanto en ruso como en inglés.

3.  **item\_category**: corresponde al archivo **item\_category.csv** con los nombres de las categorías únicamente en inglés.

4.  **items\_ru**: corresponde al archivo **items.csv** original. Es decir, con el nombre de los artículos sólo en ruso.

5.  **items\_en**: correpsonde al archivo **items.csv** con los nombres de los artículos tanto en ruso como en inglés.

6.  **items**: corresponde al archivo **items.csv** con los nombres de los artículos únicamente en inglés.

7.  **shops\_ru**: corresponde al archivo **shops.csv** original. Es decir, con el nombre de las tiendas sólo en ruso.

8.  **shops\_en**: correpsonde al archivo **shops.csv** con los nombres de las tiendas tanto en ruso como en inglés.

9.  **shops**: corresponde al archivo **shops.csv** con los nombres de las tiendas únicamente en inglés.

El proceso para la traducción de los catálogos se puede encontrar en el archivo **Traduccion.Rmd**. Cabe destacar que para poder utilizar la API de Google Translate es necesario generar una llave y esto puede ocasionar costos, por lo que se decide no incluir la llave en el archivo. Si desea realizar la traducción para nuevos datos, es necesario reemplazar el caracter *"Please\_use\_your\_own\_API\_key"* del archivo **Traduccion.Rmd** por una llave válida de Google Translate.

Para generar una llave de la API de Google Translate, se requieren los siguientes pasos:

1.  <span style="color:red">PEDIR A JOSE CARLOS QUE ME DIGA QUÉ PASOS REALIZÓ Y TERMINAR DE EDITAR EL ARCHIVO Traduccion.Rmd. </span>

### Cargar catálogos y datos entrenamiento

``` r
# Cargamos catálogos traducidos
load('datos_trad/transdata.RData')


# Eliminamos los catalogos en ruso, así como los de ruso e inglés para que no ocupen memoria. 
rm(item_category_en,item_category_ru,items_en,items_ru,shops_en,shops_ru)


# Cargamos los datos de entrenamiento y prueba. Estos no contienen campos en ruso. 
train<-read_csv("datos/sales_train.csv")
test<-read_csv("datos/test.csv")
```

### Catálogo de artículos y categorías

El catálogo de artículos y de categorías se pueden juntar. Se hace un left join de éstos y se almacena en el data\_frame **datos\_items**.

``` r
# Unimos items y item_category con la variable item_category_id. 
datos_items<-left_join(items,item_category,by="item_category_id")%>%
  select(item_id, item_name, item_category_id, item_category_name)
```

Hechamos un vistazo a los datos. Los identificadores se leen con variables enteras y los nombres de los artículos y las categorías como caracteres. Por lo tanto, no hay que reasignar tipos de variables por el momento.

``` r
glimpse(datos_items)
```

    ## Observations: 22,170
    ## Variables: 4
    ## $ item_id            <int> 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 1...
    ## $ item_name          <chr> "! IN POWER OF OVERVIEW (PLASTIC) D", "! AB...
    ## $ item_category_id   <int> 40, 76, 40, 40, 40, 40, 40, 40, 40, 40, 40,...
    ## $ item_category_name <chr> "Cinema - DVD", "Programs - Home and Office...

Verificamos que existan 22,170 artículos distintos y 84 categorías distintas para los mismos como se observó en la descripción de los datos.

``` r
# No. de artículos distintos 
nrow(datos_items %>% select(item_name) %>% unique())
```

    ## [1] 22143

``` r
# No. de cateogrías distintas. 
nrow(datos_items %>% select(item_category_name) %>% unique())
```

    ## [1] 84

<!-- Obtenemos el número de artículos en cada categoría  -->
<!-- ```{r} -->
<!-- productos_por_categoria <- datos_items %>% -->
<!--   group_by(item_category_name) %>% -->
<!--   summarise(conteo = n()) %>% -->
<!--   arrange(desc(conteo))  -->
<!-- ``` -->
<!-- La lista de las 10 categorías con mayor número de artículos de la tienda son: -->
<!-- ```{r BarPlotTop} -->
<!-- productos_por_categoria%>% -->
<!--   top_n(10)%>% -->
<!--   ggplot(aes(x = factor(item_category_name,c(productos_por_categoria$item_category_name[1:10])), y = conteo)) +  -->
<!--     geom_bar(stat = "identity")+ -->
<!--   theme(axis.text.x=element_text(angle=90))+ -->
<!--   ggtitle('Top 10 de categorías por número de elementos en cada categoría')+ -->
<!--   xlab('Categoría')+ -->
<!--   ylab('No. de artículos') -->
<!-- ``` -->
<!-- La lista de las 10 categorías con mayor número de artículos de la tienda son: -->
<!-- ```{r BarPlotBottom} -->
<!-- productos_por_categoria%>% -->
<!--   top_n(-10)%>% -->
<!--   ggplot(aes(x = factor(item_category_name,c(productos_por_categoria$item_category_name[(nrow(productos_por_categoria)-10):nrow(productos_por_categoria)])), y = conteo)) +  -->
<!--     geom_bar(stat = "identity")+ -->
<!--   theme(axis.text.x=element_text(angle=90))+ -->
<!--   ggtitle('Bottom 10 de categorías por número de elementos en cada categoría')+ -->
<!--   xlab('Categoría')+ -->
<!--   ylab('No. de artículos') -->
<!-- ``` -->
<!-- # Catalogo Tiendas -->
<!-- Hechamos un vistazo a los datos. -->
<!-- ```{r} -->
<!-- glimpse(shops) -->
<!-- ``` -->
<!-- El catálogo de tiene 60 tiendas distintas.  -->
<!-- ```{r} -->
<!-- nrow(shops %>% select(shop_name) %>% unique()) -->
<!-- ``` -->
<!-- # Datos de entrenamiento  -->
<!-- ```{r} -->
<!-- glimpse(train) -->
<!-- ``` -->
<!-- Generamos un ID para la dupla (art,tienda) -->
<!-- ```{r} -->
<!-- duplas<-list(item_id=unique(datos_items$item_id), -->
<!--              shop_id=unique(shops$shop_id))%>% -->
<!--   expand.grid -->
<!-- duplas<-duplas%>% -->
<!--   mutate(ID=1:nrow(duplas))%>% -->
<!--   select(ID,everything()) -->
<!-- ``` -->
<!-- Hacemos el left join de los datos de entrenamiento con el catalogo de artículos y de tiendas. También hacemos un left join con el ID de la dupla (artículo,tienda) -->
<!-- ```{r JoinTrainCatalogos,warning=FALSE, message=FALSE} -->
<!-- datos_train<-left_join(train,datos_items,by='item_id')%>% -->
<!--   left_join(shops,by='shop_id')%>% -->
<!--   left_join(duplas,by=c('item_id','shop_id')) -->
<!-- ``` -->
<!-- ```{r} -->
<!-- glimpse(datos_train) -->
<!-- ``` -->
<!-- Se tienen 424124 duplas (art., tienda) en el set de entrenamiento de las 1,330,200.  -->
<!-- ```{r} -->
<!-- length(unique(datos_train$ID)) -->
<!-- ``` -->
<!-- # Limpieza de datos -->
<!-- ## Arreglamos tipo de variables (la fecha, precio) -->
<!-- ```{r} -->
<!-- datos_train<-datos_train%>% -->
<!--   mutate(date=as.Date(date,format="%d.%m.%Y"), -->
<!--          item_cnt_day=as.integer(item_cnt_day))%>% -->
<!--   select(date,everything()) -->
<!-- ``` -->
<!-- ## Checamos tipo de variables -->
<!-- Todas las variables tienen el tipo de dato correcto. -->
<!-- ```{r} -->
<!-- glimpse(datos_train) -->
<!-- ``` -->
<!-- ## Checar la prescencia de datos faltantes  -->
<!-- No hay datos faltantes en ninguna de las variables  -->
<!-- ```{r} -->
<!-- summary(datos_train) -->
<!-- ``` -->
<!-- # Feature Engineering  -->
<!-- ## Separar día mes y año -->
<!-- ```{r} -->
<!-- datos_train<-datos_train%>% -->
<!--   mutate(day=as.integer(substring(as.character(date),9,10)), -->
<!--          month=as.integer(substring(as.character(date),6,7)), -->
<!--          year=as.integer(substring(as.character(date),1,4)))%>% -->
<!--   select(date,day,month,year,everything()) -->
<!-- ``` -->
<!-- ## Hacer one hot encoding de variables: -->
<!-- * día -->
<!-- * mes -->
<!-- * año -->
<!-- * shop_id -->
<!-- * item_id -->
<!-- * item_category -->
<!-- ```{r} -->
<!-- glimpse(datos_train) -->
<!-- ``` -->
<!-- La base de datos tiene información diaría para tres años. -->
<!-- ```{r} -->
<!-- unique(datos_train$year) -->
<!-- ``` -->
<!-- ## Arreglar precios negativos -->
<!-- ```{r} -->
<!-- datos_train$devuelto<-as.integer(ifelse(datos_train$item_price==-1,1,0)) -->
<!-- ``` -->
<!-- sólo hay un artículo que se ha devuelto, es el 2973. Su precio está marcado con -1. Dado que ya se hizo una dummie de devolucion, se busca su precio regular y se reemplaza  -->
<!-- ```{r ArreglaPrecioNeg,warning=FALSE, message=FALSE} -->
<!-- # extraemos los items devueltos  -->
<!-- items_devueltos<-datos_train%>% -->
<!--   filter(item_price==-1)%>% -->
<!--   select(item_id)%>% -->
<!--   unique()%>% -->
<!--   as.numeric -->
<!-- # extraemos la fecha de devolucion -->
<!-- fechas_devueltos<-datos_train%>% -->
<!--   filter(item_price==-1)%>% -->
<!--   select(date)%>% -->
<!--   unique() -->
<!-- # Extraemso el precio promedio del objeto en la misma fecha -->
<!-- precio_devueltos<-datos_train%>% -->
<!--   filter(item_id==items_devueltos)%>% -->
<!--   filter(date==fechas_devueltos)%>% -->
<!--   filter(item_price!=-1)%>% -->
<!--   select(item_price)%>% -->
<!--   unlist()%>% -->
<!--   mean() -->
<!-- <<<<<<< HEAD -->
<!-- fechas_devueltos<-datos_train%>% -->
<!--   filter(item_price==-1)%>% -->
<!--   select(date)%>% -->
<!--   unique -->
<!-- ======= -->
<!-- datos_train$item_price[which(datos_train$item_id==items_devueltos & datos_train$item_price==-1)]<-precio_devueltos -->
<!-- >>>>>>> 5680b7bed7aa6902326e035aec3cd75d77ce49f0 -->
<!-- ``` -->
<!-- ## Datos Mensuales -->
<!-- ```{r} -->
<!-- # hacemos el agregado mensual por dupla (art, tienda) y fecha mensual (date_block_num) -->
<!-- train_mensuales<-datos_train%>% -->
<!--   group_by(ID,date_block_num)%>% -->
<!--   summarise(month=unique(month), -->
<!--             year=unique(year), -->
<!--             shop_id=unique(shop_id), -->
<!--             item_id=unique(item_id), -->
<!--             item_price_min=min(item_price), -->
<!--             item_price_max=max(item_price), -->
<!--             item_price_mean=mean(item_price), -->
<!--             item_price_median=quantile(item_price,prob=0.5), -->
<!--             item_price_mode=getmode(item_price), -->
<!--             item_price_range=max(item_price)-min(item_price), -->
<!--             item_cnt_day=sum(item_cnt_day), -->
<!--             item_name=unique(item_name), -->
<!--             item_category_id=unique(item_category_id), -->
<!--             item_category_name=unique(item_category_name), -->
<!--             shop_name=unique(shop_name)) -->
<!-- train_mensuales<-arrange(train_mensuales,ID) -->
<!-- # Guardamos como Rds -->
<!-- saveRDS(train_mensuales,"Datos_clean/train_mensuales.rds") -->
<!-- ``` -->
