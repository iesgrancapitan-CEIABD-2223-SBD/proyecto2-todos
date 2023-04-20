# Spark

Compuesto por:

- Spark master, en puerto 8080 (7077 conexiones python)
- 2 spark worker, worker1 en puerto 8081, y worker2 en puerto 8082
- servidor jupyter, en el puerto 8888

para levantar el cluster:

- ejecutar build.sh ( chmod 755  previo )  para generar las imagenes de Docker
- despues levantar con docker-compose up -d

el hdfs es simulado y es un volumen compartido por todos los dockers


FIXME:

- añadir al docker-compose el docker de mariadb. Pero en su volumen particular.
- 
