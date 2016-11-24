FROM greatbsky/centos7
MAINTAINER architect.bian
LABEL name="redis" license="GPLv2" build-date="20161124"

ENV redis_VERSION 3.2.5

RUN yum clean all && yum update -y && groupadd -r redis && useradd -r -g redis redis && cd /data/softs && wget -O redis.tar.gz http://download.redis.io/releases/redis-$redis_VERSION.tar.gz && tar -zxf redis.tar.gz && cd redis-$redis_VERSION && make && mkdir -p /data/env/redis && cp /data/softs/redis-$redis_VERSION/src/redis-server /usr/bin/redis-server && cp /data/softs/redis-$redis_VERSION/src/redis-cli /usr/bin/redis-cli && sed 's/bind 127.0.0.1/#bind 127.0.0.1/' /data/softs/redis-$redis_VERSION/redis.conf | sed 's/protected-mode yes/protected-mode no/' > /data/env/redis/redis.conf

USER redis
WORKDIR /data/env/redis
EXPOSE 6379

CMD ["redis-server", "/data/env/redis/redis.conf"]
