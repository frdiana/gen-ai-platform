param containerRegistryName string
param containerRegistryUserAssignedIdentityName string

param containerAppsEnvironmentName string
param appInsightsName string
param logAnalyticsWorkspaceName string

param azureOpenAPIName string

// ---------------------------------------------------------------------
// Container Registry Module
// --------------------------------------------------------------------- 
module containerRegistry 'modules/container-registry.bicep' = {
  name: containerRegistryName
  params: {
    containerRegistryName: containerRegistryName
    acrSku: 'Standard'
    containerRegistryUserAssignedIdentityName: containerRegistryUserAssignedIdentityName
  }
}

// ---------------------------------------------------------------------
// Container Apps Environment Module
// --------------------------------------------------------------------- 
module containerAppsEnvironment 'modules/container-apps-environment.bicep' = {
  name: containerAppsEnvironmentName
  params: {
    containerAppsEnvironmentName: containerAppsEnvironmentName
    appInsightsName:appInsightsName
    logAnalyticsWorkspaceName:logAnalyticsWorkspaceName
  }
}

// ---------------------------------------------------------------------
// Azure OpenAPI Module
// ---------------------------------------------------------------------
module azureOpenAPI 'modules/azure-openai.bicep' = {
  name: azureOpenAPIName
  params: {
    openAiName: azureOpenAPIName
  }
}
