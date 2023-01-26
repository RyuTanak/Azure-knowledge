#  Azure Service Catalog Based ApplicationでVMを作成してみる  

二つのJSONを作成してVM(仮想マシン)作成画面を作成する。  
それぞれのJSONの概要説明は以下である。  

〇mainTemplate.json  
```
VMがどういう設定で作成されるかを記載するJSON。
createUiDefinition.jsonでoutputされた値を引き継いで、各設定項目に埋め込みVMを作成する。
```
〇createUiDefinition.json
```
UI画面の構成を設定できる。（HTMLとかのイメージ）
また、画面で入力された項目をmainTemplate.jsonにoutputする。
```  

mainTemplate.json作成時の[リファレンス])(https://learn.microsoft.com/ja-jp/azure/azure-resource-manager/templates/syntax)  
リファレンスはあるが、1から全てを作成するのは大変なのでVMを作る場合であれば、実際に仮想マシンのポータルから  
各設定値を入力して、最後作成確認画面からJSONをダウンロードできるので、それを使うと楽。  


```JSON
 "parameters": {
      "storageAccountNamePrefix": {
        "type": "string",
        "maxLength": 11,
        "metadata": {
          "description": "Storage prefix must be maximum of 11 characters with only lowercase letters or numbers."
        }
      },
      "storageAccountType": {
        "type": "string"
      },
      "location": {
        "type": "string",
        "defaultValue": "[resourceGroup().location]"
      }
    }
```

### parameters部分の説明  
3つのパラメータを定義（3つの変数を作っているイメージ）  
- storageAccountNamePrefix  
- storageAccountType  
- location  

テンプレート内で使用される関数の[リファレンス](https://learn.microsoft.com/ja-jp/azure/azure-resource-manager/templates/template-functions)  

例えば、「concat」という関数は  
複数の配列を結合し、連結された文字列を返す。または複数の文字列を連結し、連結文字列を返す関数である。  


# createUiDefinition.json  

リファレンスは[こちら](https://learn.microsoft.com/ja-jp/azure/azure-resource-manager/managed-applications/create-uidefinition-elements)  

createUiDefinition.jsonを作るときに参考になりそうな[Azure機能](https://portal.azure.com/?feature.customPortal=false#view/Microsoft_Azure_CreateUIDef/SandboxBlade)  

Virtual Machinのリソース部分の書き方は[こちら](https://learn.microsoft.com/ja-jp/azure/templates/microsoft.compute/2022-08-01/virtualmachinescalesets/virtualmachines?pivots=deployment-language-arm-template)  

ひとまずVMの名前だけを設定して、VM作成が行えるUIの作成は出来た。  
[mainTemplate.json](./file_makeVM/%E6%93%8D%E4%BD%9C1%E3%81%A4%E3%81%AEVM%E4%BD%9C%E6%88%90%E7%94%BB%E9%9D%A2/mainTemplate.json)  
[createUiDefinition.json](./file_makeVM/%E6%93%8D%E4%BD%9C1%E3%81%A4%E3%81%AEVM%E4%BD%9C%E6%88%90%E7%94%BB%E9%9D%A2/createUiDefinition.json)  


# VMを2台作成して、ElasticsearchとFilebeatを連携させる  

## 習得しる技術要素  

1. VM作成時にElasticsearch等をインストールする方法  
2. VM作成画面で2つのVMを立ち上げる方法  

## 1. VM作成時にElasticsearch等をインストールする方法  

外部からssh接続できるLinuxコンピュータを起動する。  
![image](./image/29.png)  

まず、簡単なFilebeatからインストールしてみる。  
(今回はubuntuを指定)  
[Filebeatダウンロードリファレンス](https://www.elastic.co/guide/en/beats/filebeat/7.17/setup-repositories.html#_apt)  
以下のコマンドを実行することで、Filebeatのインストールまでが完了する。  
```
wget -qO - https://artifacts.elastic.co/GPG-KEY-elasticsearch | sudo apt-key add -
sudo apt-get install apt-transport-https
echo "deb https://artifacts.elastic.co/packages/7.x/apt stable main" | sudo tee -a /etc/apt/sources.list.d/elastic-7.x.list
sudo apt-get update && sudo apt-get install filebeat
```
これをVM作成時に自動で実行できるようにするためには...  


