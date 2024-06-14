using './main.bicep'

param containerRegistryName = 'genaiplatformacr'
param containerRegistryUserAssignedIdentityName = 'acr-identity-pull'
param containerAppsEnvironmentName = 'dev-genaiplatform-cae'
param appInsightsName = 'dev-genaiplatform-ai'
param logAnalyticsWorkspaceName = 'dev-genaiplatform-law'
param azureOpenAPIName = 'dev-genaiplatform-oai'
