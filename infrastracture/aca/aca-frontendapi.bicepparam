using './aca-frontendapi.bicep'

param containerAppName = 'frontend-api'
param containerRegistryUserAssignedIdentityName = 'acr-identity-pull'
param containerAppsEnvironmentName = 'dev-genaiplatform-cae'
param containerRegistryName = 'genaiplatformacr'
param imageName = 'genaiplatform/frontend-api'
param imageTag = 'latest'
