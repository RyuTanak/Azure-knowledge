# 名称定義
# ---------------------------------------
$resourceGroupName = "ksapCatalogGroup"
$resourceGroupNameApp = $resourceGroupName
$storageAccountName = "tanakateststorageaccount"
$region = "japaneast"
$appContainerName = "ksapcontainer"
$azureADGroupName = "CatalogADGroup"
$role = "Owner"
$managedApplicationDefinitionName = "ksapApp"
# ---------------------------------------

# app.zip削除
#if (test-path .\app.zip){
#  Remove-Item -Path .\app.zip
#}

# app.zip作成
#zip -r .\app.zip .\createUiDefinition.json .\mainTemplate.json

# リソースグループを作成する
New-AzResourceGroup -Name $resourceGroupName -Location $region

# ストレージアカウントを作成する
$storageAccount = New-AzStorageAccount `
  -ResourceGroupName $resourceGroupName `
  -Name $storageAccountName `
  -Location $region `
  -SkuName Standard_LRS `
  -Kind StorageV2

# Contextを取得
$ctx = $storageAccount.Context

# ストレージコンテナを作成
New-AzStorageContainer -Name $appContainerName -Context $ctx -Permission blob

# zipファイルをアップロード
Set-AzStorageBlobContent `
  -File ".\app.zip" `
  -Container $appContainerName `
  -Blob "app.zip" `
  -Context $ctx

# -----

# AzureADのグループを取得
$groupID=(Get-AzADGroup -DisplayName $azureADGroupName).Id

# リソースグループ下に定義されたロールから選択
# [リソースグループ]-[アクセス制御(IAM)-[役割]
# ここでは「所有者」(=Owner)を指定する
$roleid=(Get-AzRoleDefinition -Name $role).Id

# リソースグループ作成（マネージドアプリケーションを格納するための領域）
# New-AzResourceGroup -Name $resourceGroupNameApp -Location $region

# zipを格納したblobストレージを取得
$blob = Get-AzStorageBlob -Container $appContainerName -Blob app.zip -Context $ctx

# マネージドアプリケーション定義を作成
New-AzManagedApplicationDefinition `
  -Name $managedApplicationDefinitionName `
  -Location $region `
  -ResourceGroupName $resourceGroupNameApp `
  -LockLevel ReadOnly `
  -DisplayName ($managedApplicationDefinitionName + " disp.") `
  -Description ($managedApplicationDefinitionName + " desc.") `
  -Authorization "${groupID}:$roleid" `
  -PackageFileUri $blob.ICloudBlob.StorageUri.PrimaryUri.AbsoluteUri
