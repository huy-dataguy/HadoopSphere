FROM hdsphere-spark

USER hadoopquochuy026
WORKDIR /home/hadoopquochuy026


COPY master/config/workers /home/hadoopquochuy026/hadoop/etc/hadoop/workers

USER root
# Convert files to Unix format
RUN dos2unix /home/hadoopquochuy026/hadoop/etc/hadoop/workers

# Format HDFS
USER hadoopquochuy026
RUN hdfs namenode -format

USER root
# Start SSH and Hadoop services
CMD ["/bin/bash", "-c", "service ssh start && su - hadoopquochuy026 && bash"]
