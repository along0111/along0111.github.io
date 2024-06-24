# 签名

# 一、调试信息

- app_id `1003`
- api_key `api_key`

- 商户端RSA私钥
```php
-----BEGIN PRIVATE KEY-----
MIICdwIBADANBgkqhkiG9w0BAQEFAASCAmEwggJdAgEAAoGBAMe2hs6Kr7PYsxiP
sRxU31YVzxHXY38QayiPny+F6UP1uJB84mmkrfhm5o3pO0t25BLkcnyuCQ3t5cf2
wbPpSg9IrEedtvthuKrRRLVp1dF7FG75YPa0kCtb5CYwomh+o0dGH5r3Cib6gdh3
K77W+QeCmzoixul+ei6afkmpzujZAgMBAAECgYBeBbq1pmlN3GmE2LFjSznSB3Zz
SdoXyh0I/YTOFNdbHWYE8CaP4e3dkmRczz8RKin6Ev8rX6v3mNajK7LKBrzMW8Ns
ocVd7h413nmF+jG4S68/9m2+/B8tpoAZdpfwd82PmMgSEZueSkpUpQct5J773LQq
jbH3wlGrpf9pnil6AQJBAPO6snoMtQpGMcMhMGVr3aMzg+L5eHUOEBRAb5ww2BAW
N0Fa/uKyUsYY4v86z9AxjcRBRM/O9p9jQKQnOnZUFrkCQQDRxIacAcMmxmPojsgC
vYiqbjz3ZFhZC6RRbqUd7qShFJOTRBA1fAWbTlV4xbbsQRdPEeU+0ZqWZQ5B6xEl
alMhAkEAvCzt9WtwL5GIhBZQzk1cns98STbBOOb1pR0mztmrR6hPWwdNeWuims3G
HLakkiJgSSD3ZtZs9RxlYRfkfE1qCQJAL7kkXs3P1jyAcmI5gtYYB5445JfBudB6
O8SOcDbg4XzK7lAn1+M1a1XxAB8LNMjCQszxeM86+khXbAvMxNRhwQJBALEPqIv2
8qzZuVm+wgcHdGpqeJnNN4Op5iN9RS1GiRdLvZ/rx5miiuMvbNQAQ4weomt4raeW
q16YDJpiTSjR6Nk=
-----END PRIVATE KEY-----
```

- 商户RSA公钥
```php
-----BEGIN PUBLIC KEY-----
MIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQDHtobOiq+z2LMYj7EcVN9WFc8R
12N/EGsoj58vhelD9biQfOJppK34ZuaN6TtLduQS5HJ8rgkN7eXH9sGz6UoPSKxH
nbb7Ybiq0US1adXRexRu+WD2tJArW+QmMKJofqNHRh+a9wom+oHYdyu+1vkHgps6
Isbpfnoumn5Jqc7o2QIDAQAB
-----END PUBLIC KEY-----
```

- 支付网关RSA公钥
```php
-----BEGIN RSA PUBLIC KEY-----
MIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQDBMcWLwitjAj1OMqpOStl0iqNP
uWYmKzhBbWbgTFw0klkN3Ebz/Ewz0zvrwgIYWEK6o6qAZGcUh3IiAAVlTaCVzHiT
NlM7bPn2S3jn6SJAwfG591EwT/B+7ZzgIKrsnrMFtwrmCQIF+lOf22PuA1DiTsF6
Q5nOt2q1K5cQntc59QIDAQAB
-----END RSA PUBLIC KEY-----
```

# 二、签名规则

- 出于安全考虑和信息加密所有请求均需要RSA签名，对所有callback回调均需要验证签名
- 请求时需对请求JSON中data JSON_OBJECT类型转换为字符串，使用【商户端RSA私钥】进行签名并放置在signature字段，签名算法为`RSA_1024(sha512(dataString))`，签名结果为对签名bytes的base64Encode。

- 例如以下`充值请求`中`signature`字段为签名字段，值`mT9zuYkDgm1yOKni4/5uJyam63Vh6UM0Gm0XargzQgQ5ImLqe+QC0YwJkQrQzqn4K608ut2fLCvHd/C1bdhZteeyBuyEg3oafgEYaTMTiEZAxwdFMp1LWmlPArBAf/2G5l9WJMFGiZUaKYdvo16oodTq1FwQSxssYsmjmyGSRQw=`为对data字段JSON字符串`{"identify": "88"}`使用`RSA_1024(sha512('{"identify": "88"}'))`进行签名的结果，签名请使用`商户端RSA私钥`,支付网关将使用`商户RSA公钥`对签名进行验证。
```json
{
    "app_id": 1003,
    "api_key": "api_key",
    "signature":"mT9zuYkDgm1yOKni4/5uJyam63Vh6UM0Gm0XargzQgQ5ImLqe+QC0YwJkQrQzqn4K608ut2fLCvHd/C1bdhZteeyBuyEg3oafgEYaTMTiEZAxwdFMp1LWmlPArBAf/2G5l9WJMFGiZUaKYdvo16oodTq1FwQSxssYsmjmyGSRQw=",
    "data": {
        "identify": "88"
    }
}
```

- 例如以下`充值回调`中`signature`字段为签名字段，值`jcffwn6/HqQIP6IJdIWZWkhn8hVE8PWVTFiz+FG/EzPZMJqZH0AQkH4YUZ+hmYFI82QJJqdR52GP71tflG6TWrpChKHsawW9iechsUKUS3HDTTXMGFiH5XheOdPN0RT5nMrJSN8Pw7ifZuSeAFnbSbkkLEiHNiFoIxabPjLxM64=`为对`data`字段JSON字符串`{"subject":"rechargeCallback","identify":"20","chain_type":3,"contract_type":32,"retry_id":"auto_1802624130034462720_8bc5c6dae1b0d2a8207f6275a532e733fd8304a8e572e4a9899fbbe3b5af85b7_20","order_id":"1802624130034462720","transaction_id":"8bc5c6dae1b0d2a8207f6275a532e733fd8304a8e572e4a9899fbbe3b5af85b7","amount":51}`使用`RSA_1024(sha512(string data))`进行签名的结果,需要商户使用`支付网关RSA公钥`对签名进行验证，
```json
{
	"data": {
		"subject": "rechargeCallback",
		"identify": "20",
		"chain_type": 3,
		"contract_type": 32,
		"retry_id": "auto_1802624130034462720_8bc5c6dae1b0d2a8207f6275a532e733fd8304a8e572e4a9899fbbe3b5af85b7_20",
		"order_id": "1802624130034462720",
		"transaction_id": "8bc5c6dae1b0d2a8207f6275a532e733fd8304a8e572e4a9899fbbe3b5af85b7",
		"amount": 51
	},
	"signature": "jcffwn6/HqQIP6IJdIWZWkhn8hVE8PWVTFiz+FG/EzPZMJqZH0AQkH4YUZ+hmYFI82QJJqdR52GP71tflG6TWrpChKHsawW9iechsUKUS3HDTTXMGFiH5XheOdPN0RT5nMrJSN8Pw7ifZuSeAFnbSbkkLEiHNiFoIxabPjLxM64="
}
```




# 三、签名验证参考

- 使用【商户端RSA私钥】对以下JSON字符串签名，
```json
{"name":"helloKitty"}
```
应得到签名
```json
v+Ap38ZYT92X6cbTHhvCjGa2B4vNVQQKv6AeRMc6rKCjvh/4vAz7BHfS+EbAoZej1LpAv5X3wG+CLqCA5X1DjG3hrDG7xxqBJZIwEIlZMGWcNj5xjxYxcKcad8PI3Ch5VyA3ZIzaQDyisp3quLOagUfCugf8MkuaQO4oeBB0k+I=
```

- 使用【支付网关RSA公钥】对以下JSON字符串和签名进行验证
```json
{"name":"helloKitty"}
```
- 签名
```json
fC6QtJRJlHQLnWDQFai1CneNNKGdXqtD+YbMYOYueGDed7TWuyf7HQtqLXi0vpK4cgJ7lEOMpIeWZKrDhratm5000Q7fip5ANSdWwGa1QJ3OiCGaX+Cfx5wGwX9wrLJvTXdmQ+D3bJ6OegGsriN/DVzz7bjVNKyKMjC5FiOm+wo=
```
应验证通过




