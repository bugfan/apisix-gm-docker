# apisix-gm-docker
支持国密版本的apisix的Dockerfile

编译后同时支持国际标准加密以及国密

已经ok了，最后构建出来的镜像才274M,比官网的小一点😄

## apisix依赖的服务可以用桥接模式启动，apisix服务用host模式启动

## 用tongsuo编译后的openssl测试sm链接是否可用
- 请求
```
./openssl2 s_client -connect xxxxxx:9443 -servername xxxxxx -cipher ECDHE-SM2-WITH-SM4-SM3 -enable_ntls -ntls -verifyCAfile t/certs/gm_ca.crt -sign_cert t/certs/client_sign.crt -sign_key t/certs/client_sign.key -enc_cert t/certs/client_enc.crt -enc_key t/certs/client_enc.key
```
- 返回
```
CONNECTED(00000003)
depth=2 C = AA, ST = BB, O = CC, OU = DD, CN = root ca
verify return:1
depth=1 C = AA, ST = BB, O = CC, OU = DD, CN = sub ca
verify return:1
depth=0 C = AA, ST = BB, O = CC, OU = DD, CN = server enc
verify return:1
depth=2 C = AA, ST = BB, O = CC, OU = DD, CN = root ca
verify return:1
depth=1 C = AA, ST = BB, O = CC, OU = DD, CN = sub ca
verify return:1
depth=0 C = AA, ST = BB, O = CC, OU = DD, CN = server sign
verify return:1
---
Certificate chain
 0 s:C = AA, ST = BB, O = CC, OU = DD, CN = server sign
   i:C = AA, ST = BB, O = CC, OU = DD, CN = sub ca
   a:PKEY: id-ecPublicKey, 256 (bit); sigalg: SM2-SM3
   v:NotBefore: Feb 22 02:30:14 2023 GMT; NotAfter: Jan 29 02:30:14 2123 GMT
 1 s:C = AA, ST = BB, O = CC, OU = DD, CN = server enc
   i:C = AA, ST = BB, O = CC, OU = DD, CN = sub ca
   a:PKEY: UNDEF, 256 (bit); sigalg: SM2-SM3
   v:NotBefore: Feb 22 02:30:14 2023 GMT; NotAfter: Jan 29 02:30:14 2123 GMT
---
Server certificate
-----BEGIN CERTIFICATE-----
MIIB7jCCAZOgAwIBAgIUcbKTlc6+CNoHglmEk+xm+WIqZcAwCgYIKoEcz1UBg3Uw
RTELMAkGA1UEBhMCQUExCzAJBgNVBAgMAkJCMQswCQYDVQQKDAJDQzELMAkGA1UE
CwwCREQxDzANBgNVBAMMBnN1YiBjYTAgFw0yMzAyMjIwMjMwMTRaGA8yMTIzMDEy
OTAyMzAxNFowSjELMAkGA1UEBhMCQUExCzAJBgNVBAgMAkJCMQswCQYDVQQKDAJD
QzELMAkGA1UECwwCREQxFDASBgNVBAMMC3NlcnZlciBzaWduMFkwEwYHKoZIzj0C
AQYIKoEcz1UBgi0DQgAEBb/67sQGyPP1gKbjnFKEdsDfK2EGXUp09HavD7ZokPiW
rMSyHYsDbRPxe9TTgjSQi+23f44+rocGVPxvqASNDKNaMFgwCQYDVR0TBAIwADAL
BgNVHQ8EBAMCBsAwHQYDVR0OBBYEFH3uBqkdowIvk//P7n5UtnpV9TR6MB8GA1Ud
IwQYMBaAFKxh6yKAYlkIPpbI0X/OdFwCrzyZMAoGCCqBHM9VAYN1A0kAMEYCIQCz
W/6Z/d/IJUTrO0o8nCxNle6R0AkRCKUFhW9zbIRlNwIhAJZxg4gs2cV2QF37oHs6
9TD+MkRbql4Yb47+jLf8f247
-----END CERTIFICATE-----
subject=C = AA, ST = BB, O = CC, OU = DD, CN = server sign
issuer=C = AA, ST = BB, O = CC, OU = DD, CN = sub ca
---
No client certificate CA names sent
Client Certificate Types: RSA sign, ECDSA sign
Peer signing digest: SM3
Peer signature type: SM2
Server Temp Key: SM2, 256 bits
---
SSL handshake has read 1361 bytes and written 1341 bytes
Verification: OK
---
New, NTLSv1.1, Cipher is ECDHE-SM2-SM4-CBC-SM3
Server public key is 256 bit
Secure Renegotiation IS NOT supported
Compression: NONE
Expansion: NONE
No ALPN negotiated
SSL-Session:
    Protocol  : NTLSv1.1
    Cipher    : ECDHE-SM2-SM4-CBC-SM3

```
