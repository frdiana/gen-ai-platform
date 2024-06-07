targetScope = 'resourceGroup'

// ------------------
//    PARAMETERS
// ------------------

@description('The location where the resources will be created.')
param location string = resourceGroup().location

@description('The tags to be assigned to the created resources.')
param tags object = {}

@description('The name of the container apps environment.')
param containerAppsEnvironmentName string

// Services
@description('The name of the service for the frontend web app service. The name is use as Dapr App ID.')
param frontendWebApiServiceName string

// Container Registry & Images
@description('The name of the container registry.')
param containerRegistryName string

@description('The image for the frontend web app service.')
param frontendWebApiServiceImage string

@description('The name of the application insights.')
param applicationInsightsName string

// App Ports
@description('The target and dapr port for the frontend web app service.')
param frontendWebApiPortNumber int

// ------------------
// VARIABLES
// ------------------

var containerRegistryPullRoleGuid='7f951dda-4ed3-4680-a7ca-43fe172d538d'

// ------------------
// RESOURCES
// ------------------

resource containerAppsEnvironment 'Microsoft.App/managedEnvironments@2022-03-01' existing = {
  name: containerAppsEnvironmentName
}

//Reference to AppInsights resource
resource applicationInsights 'Microsoft.Insights/components@2020-02-02' existing = {
  name: applicationInsightsName
}

resource containerRegistry 'Microsoft.ContainerRegistry/registries@2023-01-01-preview' existing = {
  name: containerRegistryName
}

resource containerRegistryUserAssignedIdentity 'Microsoft.ManagedIdentity/userAssignedIdentities@2023-01-31' = {
  name: 'aca-user-identity-${uniqueString(resourceGroup().id)}'
  location: location
  tags: tags
}

resource containerRegistryPullRoleAssignment 'Microsoft.Authorization/roleAssignments@2022-04-01' = if(!empty(containerRegistryName)) {
  name: guid(subscription().id, containerRegistry.id, containerRegistryUserAssignedIdentity.id) 
  scope: containerRegistry
  properties: {
    principalId: containerRegistryUserAssignedIdentity.properties.principalId
    roleDefinitionId: resourceId('Microsoft.Authorization/roleDefinitions', containerRegistryPullRoleGuid)
    principalType: 'ServicePrincipal'
  }
}

module frontendWebApiService 'container-apps/webapi-frontent-app.bicep' = {
  name: 'frontendWebApiService-${uniqueString(resourceGroup().id)}'
  params: {
    frontendWebApiServiceName: frontendWebApiServiceName
    location: location
    tags: tags
    containerAppsEnvironmentId: containerAppsEnvironment.id
    containerRegistryName: containerRegistryName
    containerRegistryUserAssignedIdentityId: containerRegistryUserAssignedIdentity.id
    appInsightsInstrumentationKey: applicationInsights.properties.InstrumentationKey
    frontendWebApiPortNumber: frontendWebApiPortNumber    
  }
}



// ------------------
// OUTPUTS
// ------------------


@description('The name of the container app for the front end web app service.')
output frontendWebApiServiceContainerAppName string = frontendWebApiService.outputs.frontendWebApiServiceContainerAppName

@description('The FQDN of the front end web app.')
output frontendWebApiServiceFQDN string = frontendWebApiService.outputs.frontendWebApiServiceFQDN

