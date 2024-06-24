# 准备工作


# 一、生成商户端RSA公钥
- 打开终端输入以下命令，生成RSA 1024位私钥
```shell
openssl genrsa -out private_key.pem 1024
```
- 使用上一步命令生成的私钥生成公钥
```shell
openssl rsa -in private_key.pem -pubout -out public_key.pem
```
通过以上命令会在当前目录下生成private_key.pem，public_key.pem 文件，其中private_key.pem请贵司自行保存，public_key.pem需要与其它接入档案一并发送给我方。

# 二、必须信息

|名称|必须|示例|说明|
|:----    |:---|:----- |-----   |
|商户名 |是  |通信商城 |商户简称   |
|回调地址 |是  |https://www.goshop.com/pay/callback | 必须为https连接，用以充值和代付通知    |
|归集地址 |是  |TQqAHUzBE8wgrcjk5cjKqWbMoJjjwiXE9A | 自动归集和手动归集都会发往此收款地址，请谨慎填写    |
|自动归集触发余额 |是  |35.2 | 当用户余额达到此设定值，将触发余额 - 1的自动归集    |
|单笔最大提现余额 |是  |20.5 | 安全设定，当提现金额超过此设定值，提现请求将会被拒绝   |
|请求白名单IP列表 |是  |1.1.1.1 <br> 8.8.8.8 | 安全设定，所有请求必须使用白名单IP列表内IP请求，一般为服务器IP   |
|商户后台白名单IP列表 |是  |1.1.1.1 <br> 8.8.8.8 | 安全设定，商户后台为商户相关信息和操作平台，需要以白名单IP进行访问，一般为办公网络IP地址  |

- 请按以上要求填写附件中表格
<a href="./table.xlsx" target="_blank">contact.xlsx</a>


# 三、联系商务
待您完成必须信息后，请联系商务获得接入公钥和其它接入所须信息
[联系商务](./contact.md "联系商务")
