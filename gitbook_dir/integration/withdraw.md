# 提现

# 一、说明
- 第一步

> `商户通过组装提现HTTP请求发往我司提供的支付网关地址(Endpoint)`

- 第二步

> `支付网关检查商户发起的提现请求，响应成功或失败`

- 第三步

> `回调服务通过HTTP POST形式发起请求至商户端回调地址，通知商户端提现结果详情。`


# 二、发起提现请求
> `当前仅支持获取波场USDT地址的获取`

- Endpoint
  `请联系商务获取`
- Path
  `/v1/withdraw`
- METHOD
  `HTTP POST`
- CONTENT_TYPE
  `application/json`

- 请求体

|参数|类型|描述|
|:-------|:-------|:-------|
|app_id|int64| 商户ID|
|api_key|string| 请联系商务获取|
|signature|string|签名 |
|data|object|数据实体 |
|data.identify|string| 商户端用户唯一ID|
|data.order_id|string|商户端提现订单唯一ID |
|data.amount|float64|提现金额 |


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

|参数|类型| 描述                                                   |
|:-------|:-------|:-----------------------------------------------------|
|code|int| 请参照 [全局错误码](../errcode/global_error_code.md "全局错误码") |

- CURL 示例
```shell
curl --location 'https://www.paygateway.com/v1/withdraw' \
--header 'Content-Type: application/json' \
--data '{
    "app_id": 1003,
    "api_key": "api_key",
    "signature":"M6Nwd4jPCa4rkr4BtytXkIIDl2qO2Pm+/Gzr237IZOxR7WUgaGTHH2LSspR+7mItSMMo+VhE4poXTbLTA9rfikgnnYRCEd9OrVhlqq2OV/7j2f4u9+oOsdGwNzVGNG9tN3yUII1EGtuBk7qyAdMOGbbsjkG6/BbOhKa6EtEzkpU=",
    "data": {
        "identify": "9",
        "order_id":"hello1",
        "withdraw_address":"TUWtBt3EwuCAxfVW36V88fhhE6Vnak2mLU",
        "amount":0.58
    }
}'
```

# 三、回调

> `待支付网关处理完成提现请求会通知至商户提供的回调地址`

- Endpoint
  `由商户提供`
- Path
  `由商户提供，注意充值和提现为同一PATH,根据数据实体字段subject区分充值或提现`
- METHOD
  `HTTP POST`
- CONTENT_TYPE
  `application/json`

| 参数                 |类型| 描述                               |
|:-------------------|:-------|:---------------------------------|
| signature          |string| 签名，请参照 [签名](./signature.md "签名") |
| subject            |string| 提现回调主题为 `withdraw_callback`      |
| data               |object| 数据实体                             |
| data.identify      |string| 商户端用户唯一ID                        |
| data.chain_type    |int| 链类型，当前默认`3`,代表 `tron波场`          |
| data.contract_type |int| 合约类型，当前默认`32` 代表 `usdt`          |
| data.retry_id      |string| 回调服务重试ID，主要为追踪回调请求               |
| data.order_id      |string| 商户发起提现请求时提供的订单ID                 |
| data.transaction_id|string| 提现订单区块订单事务ID                     |
| data.amount        |float64| 提现金额                             |

- 商户端成功响应
    - CONTENT_TYPE
      `application/json`

|参数|类型|描述|
|:-------|:-------|:-------|
|code|int| 1 成功响应代表商户端处理成功|

- 商户端失败响应
    - CONTENT_TYPE
      `any`

    - 商户端处理失败或无响应，会在商户通知服务中进行提醒，待商户修复接口后，客服会手动触发回调。

