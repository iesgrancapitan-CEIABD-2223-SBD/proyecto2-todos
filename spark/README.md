# Spark

Compuesto por:

- Spark master, en puerto 8080 (7077 conexiones python)
- 2 spark worker, worker1 en puerto 8081, y worker2 en puerto 8082
- servidor jupyter, en el puerto 8888

para levantar el cluster:

- ejecutar build.sh ( chmod 755  previo )  para generar las imagenes de Docker
- despues levantar con docker-compose up -d

el hdfs es simulado y es un volumen compartido por todos los dockers

# MARIADB

- se usa la base de datos chinook, que parece ser una base de datos de venta en iTunes.
- se pueden ver datos más completos aqui  https://github.com/lerocha/chinook-database ( incluyendo enlace de descarga al fichero de mariadb ). La descarga está en el repo.
- La versión de mariadb es la FIXME y se ha descargado el Dockerfile de aquí FIXME, y está en el repositorio.
- Se ha tenido que hacer un cambio en el script original por errores de permisos.

## Importar la base de datos en mariadb

- a falta de encontrar un método para añadir de forma automática la base de datos al levantar el docker-compose, se realiza los siguiente:
  - se crea un VOLUME para el Docker de mariadb, distinto de los de Spark.
  - se levanta manualmente el docker y se hace una carga bien por línea de comandos, o usando una aplicación gráfica de gestión de base de datos la base de datos en cuestión.
  - recomendamos DBEAVER, al poder interactuar con distintas bases de datos, y ser multiplataforma, https://dbeaver.io/

FIXME:

- añadir al docker-compose el docker de mariadb. Pero en su volumen particular.
- 
