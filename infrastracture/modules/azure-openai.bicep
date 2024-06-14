/*
  Parameters
*/
param openAiName string
param sku string = 'S0'
param tags object = {}

// ---------------------------------------------------------------------
// Azure OpenAI Resource
// ---------------------------------------------------------------------
resource cognitiveService 'Microsoft.CognitiveServices/accounts@2023-05-01' = {
  name: openAiName
  location: resourceGroup().location
  sku: {
    name: sku
  }
  tags: tags
  kind: 'OpenAI'
  properties: {    
    apiProperties: {
      statisticsEnabled: false
    }
  }
}
