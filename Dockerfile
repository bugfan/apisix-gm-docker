FROM debian:bullseye-slim as base

RUN set -ex; \
	apt update; \
    	apt-get -y install --no-install-recommends wget gnupg ca-certificates git curl gcc g++ make libssl-dev xz-utils sudo libldap2-dev libpcre3-dev unzip patch zlib1g-dev;

WORKDIR /
RUN git clone https://github.com/api7/tongsuo --depth 1
WORKDIR  /tongsuo

RUN ./config shared enable-ntls -g --prefix=/usr/local/tongsuo \
	&& make -j2 \
	&& sudo make install_sw

ARG OR_PREFIX=/usr/local/openresty
ARG openssl_prefix=/usr/local/tongsuo
ARG zlib_prefix=$OR_PREFIX/zlib
ARG pcre_prefix=$OR_PREFIX/pcre
ARG cc_opt="-DNGX_LUA_ABORT_AT_PANIC -I${zlib_prefix}/include -I${pcre_prefix}/include -I${openssl_prefix}/include"
ARG ld_opt="-L${zlib_prefix}/lib -L${pcre_prefix}/lib -L${openssl_prefix}/lib64 -Wl,-rpath,${zlib_prefix}/lib:${pcre_prefix}/lib:${openssl_prefix}/lib64"

RUN git clone https://github.com/api7/apisix-build-tools.git /apisix-build-tools
WORKDIR /apisix-build-tools

RUN ./build-apisix-base.sh

ENV PATH=$PATH:/usr/local/openresty/luajit/bin:/usr/local/openresty/nginx/sbin:/usr/local/openresty/bin

#RUN curl https://raw.githubusercontent.com/apache/apisix/master/utils/install-dependencies.sh -sL | bash -

RUN cp -rf /usr/local/tongsuo /usr/local/openresty \
	&& mv /usr/local/openresty/tongsuo /usr/local/openresty/openssl \
	&& mv /usr/local/openresty/openssl/lib64 /usr/local/openresty/openssl/lib

COPY ./install-deps.sh /install-deps.sh
COPY ./install-luarocks.sh /install-luarocks.sh

WORKDIR /

RUN bash /install-luarocks.sh

COPY ./apisix /apisix

WORKDIR /apisix

RUN make deps \
	&& make install

WORKDIR /usr/local/apisix

RUN rm -rf /apisix-build-tools  /install-deps.sh /install-luarocks.sh /tongsuo

COPY ./apisix-inner /usr/local/apisix

FROM debian:bullseye-slim

COPY --from=base /usr/local /usr/local
COPY --from=base /usr/bin/apisix /usr/bin/apisix

RUN rm -rf /usr/local/go

ENV PATH=$PATH:/usr/local/openresty/luajit/bin:/usr/local/openresty/nginx/sbin:/usr/local/openresty/bin

# forward request and error logs to docker log collector
RUN ln -sf /dev/stdout /usr/local/apisix/logs/access.log \
    && ln -sf /dev/stderr /usr/local/apisix/logs/error.log

EXPOSE 9080 9443

COPY ./docker-entrypoint.sh /docker-entrypoint.sh

RUN chmod +x /docker-entrypoint.sh

ENTRYPOINT ["/docker-entrypoint.sh"]

CMD ["docker-start"]

STOPSIGNAL SIGQUIT
