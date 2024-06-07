targetScope = 'resourceGroup'

// ------------------
//    PARAMETERS
// ------------------

@description('The location where the resources will be created.')
param location string = resourceGroup().location

@description('Optional. The tags to be assigned to the created resources.')
param tags object = {}

@description('The resource Id of the container apps environment.')
param containerAppsEnvironmentId string

@description('The name of the service for the frontend web app service. The name is use as Dapr App ID.')
param frontendWebApiServiceName string

// Container Registry & Image
@description('The name of the container registry.')
param containerRegistryName string

@description('The resource ID of the user assigned managed identity for the container registry to be able to pull images from it.')
param containerRegistryUserAssignedIdentityId string

@secure()
@description('The Application Insights Instrumentation.')
param appInsightsInstrumentationKey string

@description('The target and dapr port for the frontend web app service.')
param frontendWebApiPortNumber int

// ------------------
// RESOURCES
// ------------------

resource frontendWebAppService 'Microsoft.App/containerApps@2024-03-01' = {
  name: frontendWebApiServiceName
  location: location
  tags: tags
  identity: {
    type: 'UserAssigned'
    userAssignedIdentities: {
        '${containerRegistryUserAssignedIdentityId}': {}
    }
  }
  properties: {
    managedEnvironmentId: containerAppsEnvironmentId
    configuration: {
      activeRevisionsMode: 'Multiple'
      ingress: {
        external: true
        targetPort: frontendWebApiPortNumber
      }
      registries: !empty(containerRegistryName) ? [
        {
          server: '${containerRegistryName}.azurecr.io'
          identity: containerRegistryUserAssignedIdentityId
        }
      ] : []
    }
    template: {
      scale: {
        minReplicas: 1
        maxReplicas: 1
      }
    }
  }
}

// ------------------
// OUTPUTS
// ------------------

@description('The name of the container app for the frontend web app service.')
output frontendWebApiServiceContainerAppName string = frontendWebAppService.name

@description('The FQDN of the frontend web app service.')
output frontendWebApiServiceFQDN string = frontendWebAppService.properties.configuration.ingress.fqdn
