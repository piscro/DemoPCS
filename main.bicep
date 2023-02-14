param serverName string = 'azpipedbdemosvr'
param sqlDBName string = 'azpipedbdemo'
param location string = 'eastus'
param storagename string = 'pcsdatalakedemo'
param datafactoryname string = 'pcsdatafactorydemo'
param administratorLogin string = 'pcsadmin'
param administratorLoginPassword string = 'fX^%a^074Qua'



@description('Storage SKU')
param storageSkuName string = 'Standard_LRS'



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

resource storage 'Microsoft.Storage/storageAccounts@2021-09-01' = {
  name: storagename
  location: location
  sku: {
    name: storageSkuName
  }
  kind: 'StorageV2'
  properties: {
    accessTier: 'Hot'
    allowBlobPublicAccess: false
    allowCrossTenantReplication: false
    allowSharedKeyAccess: true
    encryption: {
      keySource: 'Microsoft.Storage'
      requireInfrastructureEncryption: false
      services: {
        blob: {
          enabled: true
          keyType: 'Account'
        }
        file: {
          enabled: true
          keyType: 'Account'
        }
        queue: {
          enabled: true
          keyType: 'Service'
        }
        table: {
          enabled: true
          keyType: 'Service'
        }
      }
    }
    isHnsEnabled: false
    isNfsV3Enabled: false
    keyPolicy: {
      keyExpirationPeriodInDays: 7
    }
    largeFileSharesState: 'Disabled'
    minimumTlsVersion: 'TLS1_2'
    networkAcls: {
      bypass: 'AzureServices'
      defaultAction: 'Deny'
    }
    supportsHttpsTrafficOnly: true
  }
}


resource adf 'Microsoft.DataFactory/factories@2018-06-01' = {
name: datafactoryname
location: location
identity: {
   type: 'SystemAssigned'
  }
 properties: {
 }
 }

