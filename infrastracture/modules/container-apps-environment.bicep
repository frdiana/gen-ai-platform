/*
  Deployment script for creating a Log Analytics workspace, Application Insights, and a Container Apps Environment.
*/

/*
  Parameters
*/
param logAnalyticsWorkspaceName string
param appInsightsName string
param containerAppsEnvironmentName string

// ---------------------------------------------------------------------
// Log Analytics workspace
// --------------------------------------------------------------------- 
resource logAnalyticsWorkspace 'Microsoft.OperationalInsights/workspaces@2023-09-01' = {
  name: logAnalyticsWorkspaceName
  location: resourceGroup().location
  properties: {
    retentionInDays: 30
    sku: {
      name: 'PerGB2018'
    }
  }
}
// --------------------------------------------------------------------- 
//  Application Insights
// --------------------------------------------------------------------- 
resource appInsights 'Microsoft.Insights/components@2020-02-02' = {
  name: appInsightsName
  location: resourceGroup().location
  kind: 'web'
  properties: {
    Application_Type: 'web'
    WorkspaceResourceId: logAnalyticsWorkspace.id
  }
}
// --------------------------------------------------------------------- 
//  Container Apps Environment
// --------------------------------------------------------------------- 
resource appEnvironment 'Microsoft.App/managedEnvironments@2024-03-01' = {
  name: containerAppsEnvironmentName
  location: resourceGroup().location
  properties: {
    appLogsConfiguration: {
      destination: 'log-analytics'
      logAnalyticsConfiguration: {
        customerId: logAnalyticsWorkspace.properties.customerId
        sharedKey: logAnalyticsWorkspace.listKeys().primarySharedKey
      }
    }
  }
}

