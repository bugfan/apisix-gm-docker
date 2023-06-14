# apisix-gm-docker
apisix gm 国密插件编译 docker Dockerfile

这两天陆续更新一下步骤

## apisix依赖的服务可以用桥接模式启动，apisix服务用host模式启动

## 用tongsuo编译后的openssl测试sm链接
./openssl2 s_client -connect xxxxxx:9443 -servername xxxxxx -cipher ECDHE-SM2-WITH-SM4-SM3 -enable_ntls -ntls -verifyCAfile t/certs/gm_ca.crt -sign_cert t/certs/client_sign.crt -sign_key t/certs/client_sign.key -enc_cert t/certs/client_enc.crt -enc_key t/certs/client_enc.key

# 注意！！！！！！！！ 依赖的文件不完整，最近几天我把依赖的文件，修改过的Makefile，shell，lua等上传到这里，尽情期待！！！！
