# Spark

Compuesto por:

- Spark master, en puerto 8080 (7077 conexiones python). Se puede acceder por http al puerto 8080
- 2 spark worker, worker1 en puerto 8081, y worker2 en puerto 8082. Se puede acceder por http al puerto 8081 y 8082
- servidor jupyter, en el puerto 8888. Se accede al puerto 8888 por http.

para levantar el cluster:

- ejecutar inicialmente build.sh ( chmod 755  previo si no está como ejecutable )  para generar las imagenes de Docker
- despues levantar con docker-compose up -d


el hdfs es simulado y es un volumen compartido por todos los dockers y se monta dentro de los docker como */opt/workspace/*

# MARIADB

- se usa la base de datos chinook, que parece ser una base de datos de venta en iTunes.
  - se adjuntan dos versiones: una con las claves primarias numero enteros, y una segunda donde esas mimas claves primarias son enteros y auto-incrementales.
- se pueden ver datos más completos aqui  https://github.com/lerocha/chinook-database ( incluyendo enlace de descarga al fichero de mariadb ).
- La versión de mariadb es la FIXME y se ha descargado el Dockerfile de aquí FIXME, y está en el repositorio.
- Se ha tenido que hacer un cambio en el script original por errores de permisos.
- Hay un docker-compose y un Dockerfile, junto a dos ficheros .sh para poder generar la imagen ( uso de variables de Entorno )
- *IMPORTANTE* debéis darle permisos al usuario root en la base de datos "castorjuan". Dadle todos los permisos, se hace así:
   - desde dbeaver, en el menu de la izquierda esta *Users*, desplegáis y está "root@%", lo seleccionáis. 
   - Aparace a la derecha todos los privilegios, en la pestaña "Schema Privileges". En la parte "Catalog" seleccionais la base de datos, y en la parte "Tables" seleccionais "%(All)". Y dáis click en Enable en la parte de "Table privileges" y "Other privileges"
   - Le dáis a "Save" abajo.
   

## Importar la base de datos en mariadb

- a falta de encontrar un método para añadir de forma automática la base de datos al levantar el docker-compose, se realiza los siguiente:
  - se crea un VOLUME para el Docker de mariadb, distinto de los de Spark.
  - se levanta manualmente el docker y se hace una carga bien por línea de comandos, o usando una aplicación gráfica de gestión de base de datos la base de datos en cuestión.
  - recomendamos DBEAVER, al poder interactuar con distintas bases de datos, y ser multiplataforma, https://dbeaver.io/


# Conexion Spark con Mariadb mediante JDBC


- *IMPORTANTE*: el driver para mariadb NO funciona. Se tiene que usar el driver para mysql. Lo he dejado aquí en el repositorio.
- la conexión debe hacerse como mysql, el nombre del driver sería *com.mysql.cj.jdbc.Driver*
- os dejo un Notebook de Jupyter "jbdc_spark.ipynb" y "jbdc_spark_paralelo.ipynb", que hacen la conexión correcta, el segundo de modo paralelo entre los dos workers.. El .jar para conectar a mysql lo he puesto en el volumen compartido y despues lo he llamado con la ruta completa "/opt/workspace/"
