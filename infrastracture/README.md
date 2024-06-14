# Getting Started
All the platform is deployable via a mix of az cli and bicep files.

Open the file **deploy.ps1** and replace the following parameters:
``` powershell
$rsgName = ""
$regionName = ""
$acrName = ""
```

Open the file **main.bicepparam** and replace the following parameters:
``` bicep
param containerRegistryName = ''
param containerRegistryUserAssignedIdentityName = ''
param containerAppsEnvironmentName = ''
param appInsightsName = ''
param logAnalyticsWorkspaceName = ''
param azureOpenAPIName = ''
```

Run the file **deploy.ps1**

The script will create the needed resources and push also the required images.


