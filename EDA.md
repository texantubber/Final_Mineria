Análisis Exploratorio de Datos
================

Cargar catalogos y datos entrenamiento
======================================

``` r
# Cargamos catálogos traducidos 
load('datos_trad/transdata.RData')
rm(item_category_en,item_category_ru,items_en,items_ru,shops_en,shops_ru)

# Cargamos los datos de entrenamiento y prueba
train<-read_csv("datos/sales_train.csv")
```

    ## Parsed with column specification:
    ## cols(
    ##   date = col_character(),
    ##   date_block_num = col_integer(),
    ##   shop_id = col_integer(),
    ##   item_id = col_integer(),
    ##   item_price = col_double(),
    ##   item_cnt_day = col_double()
    ## )

``` r
test<-read_csv("datos/test.csv")
```

    ## Parsed with column specification:
    ## cols(
    ##   ID = col_integer(),
    ##   shop_id = col_integer(),
    ##   item_id = col_integer()
    ## )

Catalogo Artículos
==================

Se hace un left join de los catalogos de item y item\_category.

``` r
datos_items<-left_join(items,item_category,by="item_category_id")%>%
  select(item_id, item_name, item_category_id, item_category_name)
```

Hechamos un vistazo a los datos.

``` r
glimpse(datos_items)
```

    ## Observations: 22,170
    ## Variables: 4
    ## $ item_id            <int> 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 1...
    ## $ item_name          <chr> "! IN POWER OF OVERVIEW (PLASTIC) D", "! AB...
    ## $ item_category_id   <int> 40, 76, 40, 40, 40, 40, 40, 40, 40, 40, 40,...
    ## $ item_category_name <chr> "Cinema - DVD", "Programs - Home and Office...

El catálogo de items tiene 22,170 renglones que equivalen a los distintos artículos que tiene la tienda.

``` r
nrow(datos_items %>% select(item_name) %>% unique())
```

    ## [1] 22143

En la tienda existen 84 categorías de artículos.

``` r
nrow(datos_items %>% select(item_category_name) %>% unique())
```

    ## [1] 84

Obtenemos el número de artículos en cada categoría

``` r
productos_por_categoria <- datos_items %>%
  group_by(item_category_name) %>%
  summarise(conteo = n()) %>%
  arrange(desc(conteo)) 
```

La lista de las 10 categorías con mayor número de artículos de la tienda son:

``` r
productos_por_categoria%>%
  top_n(10)%>%
  ggplot(aes(x = factor(item_category_name,c(productos_por_categoria$item_category_name[1:10])), y = conteo)) + 
    geom_bar(stat = "identity")+
  theme(axis.text.x=element_text(angle=90))+
  ggtitle('Top 10 de categorías por número de elementos en cada categoría')+
  xlab('Categoría')+
  ylab('No. de artículos')
```

    ## Selecting by conteo

![](EDA_files/figure-markdown_github/BarPlotTop-1.png)

La lista de las 10 categorías con mayor número de artículos de la tienda son:

``` r
productos_por_categoria%>%
  top_n(-10)%>%
  ggplot(aes(x = factor(item_category_name,c(productos_por_categoria$item_category_name[(nrow(productos_por_categoria)-10):nrow(productos_por_categoria)])), y = conteo)) + 
    geom_bar(stat = "identity")+
  theme(axis.text.x=element_text(angle=90))+
  ggtitle('Bottom 10 de categorías por número de elementos en cada categoría')+
  xlab('Categoría')+
  ylab('No. de artículos')
```

    ## Selecting by conteo

![](EDA_files/figure-markdown_github/BarPlotBottom-1.png)

Catalogo Tiendas
================

Hechamos un vistazo a los datos.

``` r
glimpse(shops)
```

    ## Observations: 60
    ## Variables: 2
    ## $ shop_name <chr> "! Yakutsk Ordzhonikidze, 56 fran", "! Yakutsk Shopp...
    ## $ shop_id   <int> 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15...

El catálogo de tiene 60 tiendas distintas.

``` r
nrow(shops %>% select(shop_name) %>% unique())
```

    ## [1] 60

Datos de entrenamiento
======================

``` r
glimpse(train)
```

    ## Observations: 2,935,849
    ## Variables: 6
    ## $ date           <chr> "02.01.2013", "03.01.2013", "05.01.2013", "06.0...
    ## $ date_block_num <int> 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,...
    ## $ shop_id        <int> 59, 25, 25, 25, 25, 25, 25, 25, 25, 25, 25, 25,...
    ## $ item_id        <int> 22154, 2552, 2552, 2554, 2555, 2564, 2565, 2572...
    ## $ item_price     <dbl> 999.00, 899.00, 899.00, 1709.05, 1099.00, 349.0...
    ## $ item_cnt_day   <dbl> 1, 1, -1, 1, 1, 1, 1, 1, 1, 3, 2, 1, 1, 2, 1, 2...

Generamos un ID para la dupla (art,tienda)

``` r
duplas<-list(item_id=unique(datos_items$item_id),
             shop_id=unique(shops$shop_id))%>%
  expand.grid

duplas<-duplas%>%
  mutate(ID=1:nrow(duplas))%>%
  select(ID,everything())
```

Hacemos el left join de los datos de entrenamiento con el catalogo de artículos y de tiendas. También hacemos un left join con el ID de la dupla (artículo,tienda)

``` r
datos_train<-left_join(train,datos_items,by='item_id')%>%
  left_join(shops,by='shop_id')%>%
  left_join(duplas,by=c('item_id','shop_id'))
```

``` r
glimpse(datos_train)
```

    ## Observations: 2,935,849
    ## Variables: 11
    ## $ date               <chr> "02.01.2013", "03.01.2013", "05.01.2013", "...
    ## $ date_block_num     <int> 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0...
    ## $ shop_id            <int> 59, 25, 25, 25, 25, 25, 25, 25, 25, 25, 25,...
    ## $ item_id            <int> 22154, 2552, 2552, 2554, 2555, 2564, 2565, ...
    ## $ item_price         <dbl> 999.00, 899.00, 899.00, 1709.05, 1099.00, 3...
    ## $ item_cnt_day       <dbl> 1, 1, -1, 1, 1, 1, 1, 1, 1, 3, 2, 1, 1, 2, ...
    ## $ item_name          <chr> "Scene 2012 (BD)", "DEEP PURPLE The House O...
    ## $ item_category_id   <int> 37, 58, 58, 58, 56, 59, 56, 55, 55, 55, 55,...
    ## $ item_category_name <chr> "Cinema - Blu-ray", "Music - Vinyl", "Music...
    ## $ shop_name          <chr> "Yaroslavl shopping center &quot;Altair&quo...
    ## $ ID                 <int> 1330185, 556803, 556803, 556805, 556806, 55...

Se tienen 424124 duplas (art., tienda) en el set de entrenamiento de las 1,330,200.

``` r
length(unique(datos_train$ID))
```

    ## [1] 424124

Arreglamos la fecha
===================

``` r
datos_train<-datos_train%>%
  mutate(day=as.numeric(substring(date,1,2)),
         month=as.numeric(substring(date,4,5)),
         year=as.numeric(substring(date,7)),
         date=as.Date(date,format="%d.%m.%Y"))%>%
  select(date,day,month,year,everything())
```
