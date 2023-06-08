unzip
sudo
apt-get install xz-utils
apt-get install libssl-dev
apt-get install libldap2-dev
libpcre3-dev

pcre_prefix=/usr/local/openresty/pcre
HOSTNAME=95920d8a6e73
PWD=/apisix-3.2.0
zlib_prefix=/usr/local/openresty/zlib
OR_PREFIX=/usr/local/openresty
HOME=/root
ld_opt=-L/usr/local/openresty/zlib/lib -L/usr/local/openresty/pcre/lib -L/usr/local/tongsuo/lib64 -Wl,-rpath,/usr/local/openresty/zlib/lib:/usr/local/openresty/pcre/lib:/usr/local/tongsuo/lib64
TERM=xterm
SHLVL=1
openssl_prefix=/usr/local/tongsuo
PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/local/openresty/bin
cc_opt=-DNGX_LUA_ABORT_AT_PANIC -I/usr/local/openresty/zlib/include -I/usr/local/openresty/pcre/include -I/usr/local/tongsuo/include
OLDPWD=/
_=/usr/bin/env

