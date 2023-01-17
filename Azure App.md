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


  
