FROM hdsphere-master-hbase-zookeeper

USER hadoopquochuy026
WORKDIR /home/hadoopquochuy026


COPY master/config/workers /home/hadoopquochuy026/hadoop/etc/hadoop/workers

COPY master/config/workers /home/hadoopquochuy026/hbase/conf/regionservers

USER root
# Convert files to Unix format
RUN dos2unix /home/hadoopquochuy026/hadoop/etc/hadoop/workers
RUN dos2unix  /home/hadoopquochuy026/hbase/conf/regionservers


# Format HDFS
USER hadoopquochuy026

RUN mkdir -p /home/hadoopquochuy026/hive/data/ && \
    chown hadoopquochuy026:hadoopquochuy026 /home/hadoopquochuy026/hive/data/

RUN mkdir -p /home/hadoopquochuy026/hive/warehouse/ && \
    chown hadoopquochuy026:hadoopquochuy026 /home/hadoopquochuy026/hive/warehouse/

RUN mkdir -p /home/hadoopquochuy026/zookeeper/data/ && \
    chown hadoopquochuy026:hadoopquochuy026 /home/hadoopquochuy026/zookeeper/data/

RUN rm -rf /home/hadoopquochuy026/hive/data/metastore_db


RUN hdfs namenode -format

USER root
# Start SSH and Hadoop services
CMD ["/bin/bash", "-c", "service ssh start && su - hadoopquochuy026 && bash"]
