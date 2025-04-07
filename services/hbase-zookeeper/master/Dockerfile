FROM hdsphere-spark

USER hadoopquochuy026
WORKDIR /home/hadoopquochuy026

RUN sudo apt-get update

RUN wget https://dlcdn.apache.org/zookeeper/zookeeper-3.9.3/apache-zookeeper-3.9.3-bin.tar.gz && \
    tar -xvzf apache-zookeeper-3.9.3-bin.tar.gz && \
    mv apache-zookeeper-3.9.3-bin zookeeper && \
    rm apache-zookeeper-3.9.3-bin.tar.gz

RUN wget https://dlcdn.apache.org/hbase/2.5.11/hbase-2.5.11-bin.tar.gz && \
    tar -xvzf hbase-2.5.11-bin.tar.gz && \
    mv hbase-2.5.11 hbase && \
    rm hbase-2.5.11-bin.tar.gz

COPY /services/hbase-zookeeper/master/hbase-site.xml /home/hadoopquochuy026/hbase/conf/hbase-site.xml

COPY /services/hbase-zookeeper/master/zoo.cfg /home/hadoopquochuy026/zookeeper/conf/

COPY /services/.bashrc /home/hadoopquochuy026/.bashrc

RUN echo "export JAVA_HOME=/usr/lib/jvm/java-11-openjdk-amd64" >> /home/hadoopquochuy026/hbase/conf/hbase-env.sh


USER root
RUN chown hadoopquochuy026:hadoopquochuy026 /home/hadoopquochuy026/.bashrc
RUN dos2unix /home/hadoopquochuy026/.bashrc 
RUN dos2unix /home/hadoopquochuy026/hbase/conf/hbase-site.xml
RUN dos2unix /home/hadoopquochuy026/zookeeper/conf/zoo.cfg

CMD ["/bin/bash", "-c", "service ssh start && bash"]

