using './main.bicep'

param prefix = 'dev'
param tags = {}
param containerAppsEnvironmentName = '${prefix}-cae'
param logAnalyticsWorkspaceName = '${prefix}-law'
param applicationInsightName = '${prefix}-appi'
param KEYVAULT_NAME = '${prefix}-genai-platform-kv'
param containerRegistryName = '${prefix}genaiplatformacr'
param azureOpenAiResourceName = '${prefix}-genai-platform-ai-oai'
