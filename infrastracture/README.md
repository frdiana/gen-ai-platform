# Getting Started
All the platform is deployable via a mix of az cli and bicep files.

# Infrastracture creation
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

# CI/CD configuration

Run the following script in order to obtain the required parameters for the github action.

``` bash
az ad sp create-for-rbac \
  --name my-app-credentials \
  --role contributor \
  --scopes /subscriptions/<SUBSCRIPTION_ID>/resourceGroups/my-container-app-rg \
  --json-auth \
  --output json
```


