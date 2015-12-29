FROM ubuntu:xenial

RUN apt-get update -q \
    # base reqs + compiled python deps
    && apt-get install -qy squid-deb-proxy \
    # Cleanup
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* \
    && :

ENV DATA_ROOT /data
VOLUME $DATA_ROOT

ENV CONFIG_DIR /etc/squid-deb-proxy
ENV CACHE_DIR $DATA_ROOT/cache
ENV LOG_DIR $DATA_ROOT/logs

COPY squid.conf $CONFIG_DIR/squid-deb-proxy.conf

COPY entrypoint /
ENTRYPOINT ["/entrypoint"]
CMD ["squid3", "-N"]

