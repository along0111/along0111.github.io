# PHP SDK

- payment-php-sdk
  <a href="./payment-php-sdk.zip" target="_blank">payment-php-sdk.zip</a>

- 第一步，在原有项目 composer.json中加入
```json
{
    "repositories": [
        {
            "type": "path", 
            "url": "<local_package_path>/asen/payment-php-sdk"
        }
    ]
}
```
- 第二步执行以下shell安装
```shell
composer require asen/payment-php-sdk:*@dev 
```
- 更多使用请关注pay_test.php、signature_test.php