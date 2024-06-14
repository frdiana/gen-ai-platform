/*
  Parameters
*/
param containerRegistryName string
param acrSku string = 'Standard'
param containerRegistryUserAssignedIdentityName string
param tags object = {}
/*
  Variables
*/
var containerRegistryPullRoleGuid='7f951dda-4ed3-4680-a7ca-43fe172d538d'

// ---------------------------------------------------------------------
// Container Registry
// --------------------------------------------------------------------- 
resource containerRegistry 'Microsoft.ContainerRegistry/registries@2023-07-01' = {
  name: containerRegistryName
  location: resourceGroup().location
  sku: {
    name: acrSku
  }
  properties: {
    adminUserEnabled: false
  }
}
// ---------------------------------------------------------------------
// User Assigned Identity
// --------------------------------------------------------------------- 
resource containerRegistryUserAssignedIdentity 'Microsoft.ManagedIdentity/userAssignedIdentities@2023-01-31' = {
  name: containerRegistryUserAssignedIdentityName
  location: resourceGroup().location
  tags: tags
}
// ---------------------------------------------------------------------
// Role Assignment
// --------------------------------------------------------------------- 
resource containerRegistryPullRoleAssignment 'Microsoft.Authorization/roleAssignments@2022-04-01' = {
  name: guid(subscription().id, containerRegistry.id, containerRegistryUserAssignedIdentity.id) 
  scope: containerRegistry
  properties: {
    principalId: containerRegistryUserAssignedIdentity.properties.principalId
    roleDefinitionId: resourceId('Microsoft.Authorization/roleDefinitions', containerRegistryPullRoleGuid)
    principalType: 'ServicePrincipal'
  }
}

output loginServer string = containerRegistry.properties.loginServer
