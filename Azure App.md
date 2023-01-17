# Azure アプリケーション実行基盤  

以下のサービスを利用する。  
- Azure Functions  
- Azure Logic Apps  
- Azure Automation  

〇Azure Function  
  AWSでいう、Lambdaのこと。  

〇Azure Logic Apps  
  Azureの運用を管理するサービス。  
  簡単な例だと、日中帯はVMを起動させて夜間は停止させたいとき、VMの起動・停止の設定と、スケジュールリング設定を行うことができる。  

〇Azure Automation  
  Azure Logic Appとできることは同じ。（https://test-fuc.azurewebsites.net/api/HttpTrigger1?code=B4HZIDr8LQxgcFm2u1MnGZMx3jBHSalDc8VPIS7JfkaSAzFuD2KL8g==）  
  ざっくりどう違うかというと  
  Azure AutomationはAzureの管理者が利用する。GUI出の設定が基本となる。  
  Azure Logic Appは開発者が利用する。CUIでの設定が基本となる。(とはいってもワークフローの作成はGUI)  


# 各サービスを軽く使ってみる  

## Azure Function  

POSTすると、レスポンスが帰ってくる簡単な関数を作成する。  

Functionの利用には「関数アプリ」というサービスを利用する。  
※Azure Functionで検索しても出てこないので注意。  

リソースグループ、関数名、ランタイムを選択し作成する。  
[image](/image/20.png)  

完了後、リソースへ移動し左のメニューから関数を作成する。  
開発環境を「ポータルでの開発」にし、テンプレートは「HTTP trigger」を選択し、作成する。  
[image](/image/21.png)  

作成後、「コードとテスト」を選択しする。
ここには、HTTPリクエストがBodyにメッセージを入れ、返却するプログラムが記載されている。  
[image](/image/22.png)  

「テストと実行」を押すと、ブラウザ上でテストを行うことができる。  
VScodeのREST Clientを利用した場合だと
コードとテストの画面から、関数URLの取得を選択する。
[image](/image/23.png)  

上記のURLを用いて、POSTを行うと結果を取得することができる。  


## Azure Logic apps  

POSTを行うと、VMが起動するロジックを作成する。  

サービスから「ロジックアプリ」を選択し、新規作成を行う。  

https://test-function-0117.azurewebsites.net/api/HttpTrigger1?code=2IbD-lm9gHQ0TeIot2Bwjr-ce3kE7rSRMZJ5u9vcfHHmAzFuhQb6yg==
上記の設定項目に従って、各パラメータの設定を行い作成する。  
[image](/image/24.png)  

作成後、リソースへ移動し左のメニューから「ワークフロー」を選択  
ワークフローを新規作成する。  
[image](/image/25.png)  

作成したワークフローを選択して、左のメニューからデザイナーを選択する。  
トリガーでは、「要求」を選択、保存時に作成されるURLを保持しておく。  

追加のアクションでVMの起動を設定し、ワークフローを保存する。  
[image](/image/26.png)  

vscodeで先ほど保持したURLへPOSTを行うと、VMが開始される。  
ワークフローの概要からトリガーの実行履歴を確認することもできる。  
[image](/image/27.png)  


## Azure Automation  

サービスから「Automation アカウント」を選択し、Automationアカウントを新規作成する。  
[image](/image/28.png)  

作成後、リソースへ移動し左のメニューから「Runbook」を選択する。  

このRunbookの画面からどう運用するかを設定し（GUIのみ）  
そのRunbookのトリガーとなるWebhookやスケジュールを設定することができる。  
(Runbookの設定方法が不明)  


