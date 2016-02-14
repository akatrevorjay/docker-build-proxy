FROM ubuntu:xenial

RUN apt-get update -q \
    # base reqs + compiled python deps
    && apt-get install -qy squid3 curl \
    # clean
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* \
    && :

# So the docker hub doesn't support build time arguments even with a default set?
# That is nearing the epitome of stupid.
#ARG DOCKERIZE_VERSION 0.2.0
ENV DOCKERIZE_VERSION 0.2.0
RUN curl -sSL "https://github.com/jwilder/dockerize/releases/download/v${DOCKERIZE_VERSION}/dockerize-linux-amd64-v${DOCKERIZE_VERSION}.tar.gz" \
      | tar -C /usr/local/bin -xzv \
    && chmod +x /usr/local/bin/dockerize \
    && :

ENTRYPOINT ["/entrypoint"]
CMD ["squid3", "-N"]

ENV APP_ROOT="/app" \
    CONFIG_DIR="/etc/squid3" \
    LOG_DIR="/var/log/squid3" \
    LOG_FIFO=true \
    CACHE_DIR="/var/cache/squid3" \
    CACHE_MEM="64 MB" \
    MAX_OBJECT_SIZE_IN_MEMORY="10240 KB" \
    HTTP_PORT=3142

EXPOSE $HTTP_PORT

ENV PATH=$APP_ROOT/image/bin:$APP_ROOT/image/sbin:$PATH
RUN ln -sfv "$APP_ROOT/image/entrypoint" /

WORKDIR $APP_ROOT
COPY image image

