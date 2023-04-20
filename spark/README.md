# Spark

Compuesto por:

- Spark master
- 2 spark worker
- servidor jupyter

para levantar el cluster:

- ejecutar build.sh ( chmod 755  previo )  para generar las imagenes de Docker
- despues levantar con docker-compose up -d

el hdfs es simulado y es un volumen compartido por todos los dockers


FIXME:

- añadir al docker-compose el docker de mariadb. Pero en su volumen particular.
- 
