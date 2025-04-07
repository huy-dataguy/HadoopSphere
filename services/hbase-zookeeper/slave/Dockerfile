FROM hdsphere-slave

USER hadoopquochuy026
WORKDIR /home/hadoopquochuy026

RUN sudo apt-get update

RUN wget https://dlcdn.apache.org/hbase/2.5.11/hbase-2.5.11-bin.tar.gz && \
    tar -xvzf hbase-2.5.11-bin.tar.gz && \
    mv hbase-2.5.11 hbase && \
    rm hbase-2.5.11-bin.tar.gz

COPY /services/.bashrc /home/hadoopquochuy026/.bashrc

COPY /services/hbase-zookeeper/slave/hbase-site.xml /home/hadoopquochuy026/hbase/conf/hbase-site.xml

RUN echo "export JAVA_HOME=/usr/lib/jvm/java-11-openjdk-amd64" >> /home/hadoopquochuy026/hbase/conf/hbase-env.sh

USER root
RUN chown hadoopquochuy026:hadoopquochuy026 /home/hadoopquochuy026/.bashrc
RUN dos2unix /home/hadoopquochuy026/.bashrc 
RUN dos2unix /home/hadoopquochuy026/hbase/conf/hbase-site.xml

CMD ["/bin/bash", "-c", "service ssh start && bash"]

