FROM sequenceiq/hadoop-docker:latest


VOLUME [ "/source" ]

EXPOSE 50070-50080
EXPOSE 8088

COPY Correos.txt .
COPY Puntuacion.txt .
COPY ./java/WordCount.java .
COPY ./java/Manifest .


ENV HADDOOP_HOME /usr/local/hadoop
ENV CLASSPATH /usr/local/hadoop/etc/hadoop/:/usr/local/hadoop/share/hadoop/common/lib/*:/usr/local/hadoop/share/hadoop/common/*:/usr/local/hadoop/share/hadoop/hdfs:/usr/local/hadoop/share/hadoop/hdfs/lib/*:/usr/local/hadoop/share/hadoop/hdfs/*:/usr/local/hadoop/share/hadoop/yarn/lib/*:/usr/local/hadoop/share/hadoop/yarn/*:/usr/local/hadoop/share/hadoop/mapreduce/lib/*:/usr/local/hadoop/share/hadoop/mapreduce/*:/usr/local/hadoop/contrib/capacity-scheduler/*.jar

RUN bash /etc/bootstrap.sh

RUN javac -d . WordCount.java
RUN jar cfm WordCount.jar Manifest *.class

RUN mkdir ~/input
RUN mkdir ~/output

RUN cp Correos.txt ~/input
RUN cp Puntuacion.txt ~/input


# RUN /usr/local/hadoop/bin/hdfs dfs -copyFromLocal ~/input /
# RUN /usr/local/hadoop/bin/hdfs dfs -ls /input
# RUN /usr/local/hadoop/bin/hadoop jar WordCount.jar /input /output

