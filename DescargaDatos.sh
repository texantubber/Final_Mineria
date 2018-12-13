# Minería y Análsiis de Datos
# Proyecto Final
# Alejandra Lelo de Larrea Ibarra 124433, Dante Ruiz Martínez 183340, José Carlos Escobar Gutiérrez 175895


# ---- En la terminal: Descargar API KAGGLE ----- 

#  Nota: Es necesario tener la versión python 3 para poder descargar la API de kaggel. 

# Descarga api Kaggle
pip install kaggle --upgrade


# ---- En el navegador: Obtener token Kaggel -------- 

# Ingresar a tu cuenta de Kaggle (requere usuario y contraseña)
# En la sección "My Account" obtener el token en formato .jason en la sección API y guardarlo en la carpeta de descargas


# ----- En la terminal: Descarga de datos -----

# Crear carpeta  kaggle
mkdir ~/.kaggle/

# Mover el archivo del token de descargas a la carpeta de kaggle
mv ~/Downloads/kaggle.json ~/.kaggle/

# Creamos la carpeta del proyecto
mkdir Proyecto_Final

# Moverse a la carpeta donde quiera descargar los datos 
cd Documents/Proyecto_Final

# Creamos la carpeta de datos crudos
mkdir Datos

# Creamos la carpeta de datos traducidos
mkdir Datos_trad

# Creamos la carpeta de datos limpios
mkdir Datos_clean

# Nos movemos a la carpeta de datos crudos
cd Datos 

# descargar los datos de la competencia
kaggle competitions download competitive-data-science-predict-future-sales

# descomprimir todos los archivos .gz
gunzip *.gz
