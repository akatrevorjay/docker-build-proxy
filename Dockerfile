FROM ubuntu:xenial

RUN apt-get update -q \
    # base reqs + compiled python deps
    && apt-get install -qy squid-deb-proxy squid3 \
    # Cleanup
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* \
    && :

RUN echo "HACK Symlink for xenial squid-deb-proxy:" \
    && ln -sfv /usr/sbin/squid3 /usr/sbin/squid \
    && :

ENV DATA_ROOT /data
VOLUME $DATA_ROOT

ENV CONFIG_DIR /etc/squid-deb-proxy
ENV CACHE_DIR $DATA_ROOT/cache
ENV LOG_DIR $DATA_ROOT/logs

COPY squid.conf $CONFIG_DIR/squid-deb-proxy.conf

COPY entrypoint /
ENTRYPOINT ["/entrypoint"]
CMD squid3 -N -f $CONFIG_DIR/squid-deb-proxy.conf

