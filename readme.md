# 初めてのAzure  

## Azureのリージョン  

日本には東日本と西日本の2つがある。  
地理的に近いほうのリージョンを使用したほうが、応答速度はよくなる。  
しかし、東西で異なる点もある  
- 東にはあるが、西にはないサービスがある。みたいに、どちらかにしかないサービスがある。  
- 東西でサービスの価格が異なる場合がある。  

## 勉強したいサービス  
- Azure Service Catalog Based Application  
- Azure Backup  
- Azure Update Management  
- Azure Plolicy
- Powershell / Azure Powershell  

〇Azure DevOps  
   - Repo  
   - Pipeline

〇アプリケーション実行基盤  
   - Azure Logic Apps  
   - Azure Functions  
   - Azure Automation  
 
〇Azure Monitor  
  - Application Insights  
  - Log Analytics  
  - Azure Monitor Metric  

## 無料アカウントの作成  

Microsoftアカウントを使用する。  
登録にはクレジットカードが必須。  
使い始めてから30日以内は22,500円分が無料で使える。  
従量課金制。(使った分だけお金がかかる)  

30日を過ぎる or 22,500円を超えたら、アップグレードしないと使えなくなる。  
このお試し期間を過ぎると、無料サービスを使おうとしてもアップグレードする必要がある。  

## 料金計算ツールの使い方  

https://azure.microsoft.com/ja-jp/pricing/calculator/  

かなり細かく見積もりをすることができる。  

## IoT研修（AWS編）をAzureでやってみる。  

AWSで使用していたサービスは、「IoT core」「DynamoDB」「Lambda」「EC2」「VPN」  
これらのサービスをAzureではどのようになるか、以下に示す。  
 
「IoT core」→「IoT Hub」  
「DynamoDB」→「Auzre Cosmos DB」  
「Lambda」→「Azure Functions」  
「EC2」→「Virtual Machines」  

## 「IoT Hub」  

https://qiita.com/linyixian/items/0795ff2ab038ea0a3517