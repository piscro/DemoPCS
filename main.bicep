param serverName string = 'azpipedbdemosvr'
param sqlDBName string = 'azpipedbdemo'
param location string = 'eastus'
param storagename string = 'pcsdatalake'
param datafactoryname string = 'pcsdatafactory'
param administratorLogin string = 'pcsadmin'
param administratorLoginPassword string = 'fX^%a^074Qua'
param containerNames array = [
'raw'
'curated'
]

resource sqlServer 'Microsoft.Sql/servers@2021-08-01-preview' = {
  name: serverName
  location: location
  properties: {
    administratorLogin: administratorLogin
    administratorLoginPassword: administratorLoginPassword
  }
}
resource sqlDB 'Microsoft.Sql/servers/databases@2021-08-01-preview' = {
  parent: sqlServer
  name: sqlDBName
  location: location
  sku: {
    name: 'Standard'
    tier: 'Standard'
  }
}

resource stg 'Microsoft.Storage/storageAccount@2019-06-01' = {
name: storagename
location: location
kind: 'StorageV2'
sku: {
  name: 'Standard_LRS'
}
properties: {
accessTier: 'Hot'
isHnsEnabled:true
 }
}

resource blob 'Microsoft.Storage/storageAccounts/blobServices/container@2019-06-01' = [for storagename in containerNames: {
name: '${stg.name}/default/${storagename}'
}]

output storagekey string = listKeys(resourceId('Microsft.Storage/storageAccounts',storagename),'2019-06-01').keys[0].value

resource adf 'Microsoft.DataFactory/factories@2018-06-01' = {
name: datafactoryname
location: location
identity: {
   type: 'SystemAssigned'
  }
 properties: {
 }
 }

