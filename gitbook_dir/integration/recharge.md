# 充值


# 一、说明
- 第一步

> `商户通过组装充值HTTP请求发往我司提供支付网关地址(Endpoint)获取波场USDT充值地址`



- 第二步

> `商户通过二维码展示第一步获得充值地址，用户扫码转账`

- 第三步

> `回调服务通过HTTP POST形式发起商户端回调地址，通知商户端用户充值成功，`


# 二、获取充值地址
> `当前仅支持获取波场USDT地址的获取`

- Endpoint
  `请联系商务获取`
- Path
  `/v1/recharge`
- METHOD
  `HTTP POST`
- CONTENT_TYPE
  `application/json`

- 请求体

|参数|类型|描述|
|:-------|:-------|:-------|
|app_id|int|商户ID,联系商务获取 |
|api_key|string| 通讯密钥，联系商务获取|
|signature|string| 签名，请参照 [签名](http://127.0.0.1:4999/web/#/p/e471e3f0502ac815f14ba08a1bbd89d9 "签名") |
|data|json object|数据实体 |
|data.identify|string| 商户端用户唯一ID |

- 成功响应
    - CONTENT_TYPE
      `application/json`

|参数|类型|描述|
|:-------|:-------|:-------|
|code|int| 8001|
|data|json object|数据实体 |
|data.address|string| 充值地址|

- 失败响应
    - CONTENT_TYPE
      `application/json`

|参数|类型|描述|
|:-------|:-------|:-------|
|code|int| 请参照 [全局错误码](../errcode/global_error_code.md "全局错误码") |

- CURL 示例
```shell
curl --location 'http://www.paygateway.com/v1/recharge' \
--header 'Content-Type: application/json' \
--data '{
    "app_id": 1003,
    "api_key": "api_key",
    "signature":"mT9zuYkDgm1yOKni4/5uJyam63Vh6UM0Gm0XargzQgQ5ImLqe+QC0YwJkQrQzqn4K608ut2fLCvHd/C1bdhZteeyBuyEg3oafgEYaTMTiEZAxwdFMp1LWmlPArBAf/2G5l9WJMFGiZUaKYdvo16oodTq1FwQSxssYsmjmyGSRQw=",
    "data": {
        "identify": "9",
    }
}'
```

# 三、回调

> `当前仅通知波场USDT地址的充值`

- Endpoint
  `由商户提供`
- Path
  `由商户提供，注意充值和提现为同一PATH,根据数据实体字段区分充值或提现`
- METHOD
  `HTTP POST`
- CONTENT_TYPE
  `application/json`

| 参数                 |类型| 描述                               |
|:-------------------|:-------|:---------------------------------|
| signature          |string| 签名，请参照 [签名](./signature.md "签名") |
| subject            |string| 充值回调主题为 `recharge_callback`      |
| data               |object| 数据实体                             |
| data.identify      |string| 商户端用户唯一ID                        |
| data.chain_type    |int| 链类型，当前默认`3`,代表 `tron波场`          |
| data.contract_type |int| 合约类型，当前默认`32` 代表 `usdt`          |
| data.retry_id      |string| 回调服务重试ID，主要为追踪回调请求               |
| data.order_id      |string| 充值订单支付网关唯一ID，主要为追踪订单             |
| data.transaction_id|string| 充值订单区块订单事务ID                     |
| data.amount        |float64| 充值金额                             |

- 商户短成功响应
    - CONTENT_TYPE
      `application/json`

|参数|类型|描述|
|:-------|:-------|:-------|
|code|int| 1 成功响应代表商户端处理成功|

- 商户端失败响应
    - CONTENT_TYPE
      `any`

    - 商户端处理失败或无响应，会在商户通知服务中进行提醒，待商户修复接口后，客服会手动触发回调。

