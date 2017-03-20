FROM aleozlx/tkstack-basic:research
RUN pip install --upgrade pip

# Flask and Celery as model serving stack
RUN pip --no-cache-dir install Flask Celery redis

# Install Redis (ref: https://www.digitalocean.com/community/tutorials/how-to-install-and-configure-redis-on-ubuntu-16-04)
RUN cd /tmp && curl -O http://download.redis.io/redis-stable.tar.gz && tar xzvf redis-stable.tar.gz
RUN cd /tmp/redis-stable && make && make install
RUN mkdir -p /etc/redis /var/lib/redis
# RUN cp /tmp/redis-stable/redis.conf /etc/redis/
# COPY redis.conf /etc/redis/redis.conf
# COPY redis.service /etc/systemd/system/redis.service
# RUN adduser --system --group --no-create-home redis
# RUN chown redis:redis /var/lib/redis && chmod 770 /var/lib/redis
# RUN systemctl enable redis

# For Ubuntu 14.04 (ref: https://www.digitalocean.com/community/tutorials/how-to-install-and-use-redis)
RUN yes '' | /tmp/redis-stable/utils/install_server.sh
RUN update-rc.d redis_6379 defaults

WORKDIR /app
CMD /bin/bash
