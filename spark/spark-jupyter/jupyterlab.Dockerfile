## Selección de imagen base
# Especificamos como imagen base una imagen Debian ligera con Java 8 JRE
FROM openjdk:8-jre-slim


## Descarga e instalación de dependencias
# Definimos las variables del Dockerfile
ARG hdfs_simulado=/opt/workspace
ARG spark_version=3.4.0
ARG jupyterlab_version=3.6.3

ARG jupyterlab_web=8888 # Puerto para interfaz web de JupyterLab

# Definimos la variable de entorno conteniendo el puerto de JupyterLab
ENV HDFS_SIMULADO=${hdfs_simulado}

# Definimos las variables de entorno conteniendo el directorio de HDFS
ENV JUPYTERLAB_PORT=${jupyterlab_web}

# Realizamos la instalación de la última versión estable de Python3
RUN mkdir -p ${hdfs_simulado} && \
    apt-get update -y && \
    apt-get install -y python3 && \
    ln -s /usr/bin/python3 /usr/bin/python && \
    rm -rf /var/lib/apt/lists/*
RUN apt-get update -y && \
    apt-get install -y python3-pip && \
    pip3 install gdown numpy matplotlib scipy scikit-learn

# Realizamos la instalación de la versión especificada de Pyspark y JupyterLab
RUN pip3 install wget pyspark==${spark_version} jupyterlab==${jupyterlab_version}


# instalamos R, openjdk:8-jre-slim está basado en Debian Bullseye. Debian tiene los paquetes de R los añadimos 
# tomamos como referencia la URLs siguiente https://github.com/saagie/jupyter-r-notebook/blob/master/Dockerfile

# R install

RUN apt-get install -y --no-install-recommends r-base r-base-dev && apt-get clean

# Utilities for R Jupyter Kernel

RUN echo 'install.packages(c("base64enc","evaluate","IRdisplay","jsonlite","uuid","digest"), \
repos="http://cran.us.r-project.org", dependencies=TRUE)' > /tmp/packages.R \
   && Rscript /tmp/packages.R

RUN apt-get update && apt-get install -y --no-install-recommends libzmq3-dev git libcurl4-openssl-dev libssl-dev && apt-get clean


# Database Libraries

RUN echo 'install.packages(c("RODBC","elastic","mongolite","rmongobd","RMySQL","RPostgreSQL","RJDBC","rredis","RCassandra","RHive","RNeo4j","RImpala"),repos="http://cran.us.r-project.org", dependencies=TRUE)' > /tmp/packages.R && Rscript /tmp/packages.R


# Machine Learning Libraries

RUN echo 'install.packages(c("dplyr","shiny","foreach","microbenchmark","parallel","runit","arules","arulesSequences","neuralnet","RSNNS","AUC","sprint","recommenderlab","acepack","addinexamples","clv","cubature","dtw","Formula","git2r","googleVis","gridExtra","gsubfn","hash","Hmisc","ifultools","latticeExtra","locpol","longitudinalData","lubridate","miniUI","misc3d","mvtsplot","np","openssl","packrat","pdc","PKI","rsconnect","splus2R","sqldf","TaoTeProgramming","TraMineR","TSclust","withr","wmtsa"), repos="http://cran.us.r-project.org", dependencies=TRUE)' > /tmp/packages.R && Rscript /tmp/packages.R

# Install R Jupyter Kernel

RUN echo 'install.packages(c("repr", "IRdisplay", "crayon", "pbdZMQ","devtools"),repos="http://cran.us.r-project.org", dependencies=TRUE)' > /tmp/packages.R && Rscript /tmp/packages.R
RUN echo 'remotes::install_github("IRkernel/IRkernel")' > /tmp/packages.R && Rscript /tmp/packages.R

# Install R kernel

RUN echo 'IRkernel::installspec()' > /tmp/temp.R && Rscript /tmp/temp.R


## Ejecución de comandos al arrancar el contenedor
# Montamos el HDFS simulado en una carpeta con datos persistentes
VOLUME ${hdfs_simulado}
CMD ["bash"]

# Exponemos el puerto utilizado por JupyterLab
EXPOSE ${jupyterlab_web}

# Especificamos la ruta de trabajo dentro del contenedor
WORKDIR ${HDFS_SIMULADO}

# Ejecutamos JupyterLab utilizando el puerto especificado
CMD jupyter lab --ip=0.0.0.0 --port=${JUPYTERLAB_PORT} --no-browser --allow-root --NotebookApp.token=
