# Azure Service Catalog Based Application  

参考サイト  
https://learn.microsoft.com/ja-jp/azure/azure-resource-manager/managed-applications/publish-service-catalog-app?tabs=azure-powershell  

引用：  
サービスカタログにマネージドアプリケーションを発行するには以下の手順が必要です。  

- マネージド アプリケーションでデプロイするリソースを定義する Azure Resource Manager テンプレート (ARM テンプレート) を作成します。  
- マネージド アプリケーションをデプロイするときに、ポータルのユーザー インターフェイス要素を定義する。  
- 必要なテンプレート ファイルを含む .zip パッケージを作成する。 .zip パッケージ ファイルには、サービス カタログのマネージド アプリケーション定義に対して 120 MB の制限があります。  
- どのユーザー、グループ、またはアプリケーションがユーザーのサブスクリプションのリソース グループにアクセスする必要があるかを決める。  
- .zip パッケージを指定して ID アクセスを要求するマネージド アプリケーション定義を作成する。  

```
〇サービスカタログ
　エンドユーザー向けのサービス。
　自社のサービスについて分かりやすく情報を提供することを目的としたもの
```

## ARMテンプレートを作成する  

mainTemplate.jsonの作成  
→このファイルでストレージアカウントを作成するパラメータを定義し、ストレージアカウントのプロパティを指定します。  

createUiDefinition.jsonの作成  
→このJSONの説明は[こちら](https://learn.microsoft.com/ja-jp/azure/azure-resource-manager/managed-applications/create-uidefinition-overview)  

## Azure powershellでログイン  

Connect-AzAccount -Subscription "xxxx" -Tenant "yyyy"

## ファイルのパッケージ化  
↓今回用に設定  
```
New-AzResourceGroup -Name storageGroup -Location JapanEast

$storageAccount = New-AzStorageAccount `
  -ResourceGroupName storageGroup `
  -Name "tanakastrageacount" `
  -Location JapanEast `
  -SkuName Standard_LRS `
  -Kind StorageV2

$ctx = $storageAccount.Context

New-AzStorageContainer -Name appcontainer -Context $ctx -Permission blob

Set-AzStorageBlobContent `
  -File "C:\tanaka_file\04_勉強\Azure\file\app.zip" `
  -Container appcontainer `
  -Blob "app.zip" `
  -Context $ctx
```

Locationは「japaneast」でも「JapanEast」でもいける  
app.zipはフォルダを圧縮しないで、ファイルを圧縮すること。（のちにエラーになります）  

## マネージドアプリケーション定義の作成  

引用：  
このセクションでは、Azure Active Directory から ID 情報を取得し、リソース グループを作成して、マネージド アプリケーション定義を作成します。  

### Azure Active Directory ユーザー グループまたはアプリケーションの作成  
```
$groupID=(Get-AzADGroup -DisplayName ksaplabo-org).Id
```
↑グループ名「ksaplabo-org」を入れる  

### ロール定義 ID の取得  
```
$roleid=(Get-AzRoleDefinition -Name Owner).Id
```

### マネージドアプリケーション定義の作成  
```
New-AzResourceGroup -Name appDefinitionGroup -Location japaneast
```

```
$blob = Get-AzStorageBlob -Container appcontainer -Blob app.zip -Context $ctx

New-AzManagedApplicationDefinition `
  -Name "ManagedStorage" `
  -Location "JapanEast" `
  -ResourceGroupName appDefinitionGroup `
  -LockLevel ReadOnly `
  -DisplayName "Managed Storage Account" `
  -Description "Managed Azure Storage Account" `
  -Authorization "${groupID}:$roleid" `
  -PackageFileUri $blob.ICloudBlob.StorageUri.PrimaryUri.AbsoluteUri
```

appcontainerというコンテナができる  
一応これでマネージドアプリケーション画面から、JSONで定義したストレージ作成が行える  



