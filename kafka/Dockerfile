FROM openjdk:8-alpine

ENV KAFKA_VERSION 2.13-2.7.0
ENV INDEX_OF_KAFKA_VERSION 2.7.0
ENV ZOOKEEPER_VERSION 3.5.8
ENV TIME_ZONE "Etc/UTC"

RUN apk update && apk add --no-cache \
    bash \
    curl \
    supervisor \
    tzdata

RUN cp /usr/share/zoneinfo/"$TIME_ZONE"   /etc/localtime
RUN echo "TIME_ZONE" >  /etc/timezone
RUN apk del tzdata

RUN wget http://apache.mirrors.spacedump.net/kafka/"$INDEX_OF_KAFKA_VERSION"/kafka_"$KAFKA_VERSION".tgz -O /tmp/kafka_"$KAFKA_VERSION".tgz
RUN tar xfz /tmp/kafka_"$KAFKA_VERSION".tgz -C /opt \
&& mv /opt/kafka_"$KAFKA_VERSION" /opt/kafka \
&& rm /tmp/kafka_"$KAFKA_VERSION".tgz

RUN wget http://apache.mirrors.spacedump.net/zookeeper/stable/apache-zookeeper-"$ZOOKEEPER_VERSION"-bin.tar.gz -O /tmp/apache-zookeeper-"$ZOOKEEPER_VERSION"-bin.tar.gz
RUN tar xfz /tmp/apache-zookeeper-"$ZOOKEEPER_VERSION"-bin.tar.gz -C /opt \
&& mv /opt/apache-zookeeper-"$ZOOKEEPER_VERSION"-bin /opt/zookeeper \
&& rm /tmp/apache-zookeeper-"$ZOOKEEPER_VERSION"-bin.tar.gz
RUN cp /opt/zookeeper/conf/zoo_sample.cfg /opt/zookeeper/conf/zoo.cfg

RUN apk del tar curl libcurl libssh2 ca-certificates openssl
RUN rm -rf /var/cache/apk/*


ADD scripts/start.sh /usr/bin/start.sh
RUN chmod +x /usr/bin/start.sh

ADD supervisor/image.ini /etc/supervisor.d/

EXPOSE 2181 9092

CMD ["/usr/bin/supervisord", "-c", "/etc/supervisord.conf"]

WORKDIR /opt/kafka