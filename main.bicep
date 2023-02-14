param location string = 'eastus'
param storagename string = 'pcsdatalakedemo'
param datafactoryname string = 'pcsdatafactorydemo'

@description('Storage SKU')
param storageSkuName string = 'Standard_LRS'



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

