
$rsgName = "dev-genai-platform-rg"
$regionName = "swedencentral"
$acrName = "genaiplatformacr"
# Create the resource group if it does not exist
$rsgExists = az group exists -n $rsgName
if ($rsgExists -eq 'false') {
    az group create -l $regionName -n $rsgName
}
else {
    Write-Host "Resource group $rsgName already exists, skipping creation..."
}
Write-Host "Deploying resources to resource group $rsgName" -ForegroundColor Blue
az deployment group create --resource-group $rsgName --template-file "main.bicep" --parameters "main.bicepparam"
if ($? -eq $true) {
    Write-Host "Resources deployed successfully to resource group $rsgName" -ForegroundColor Green
}
else {
    Write-Host "Resources deployment failed" -ForegroundColor Red
}
Write-Host "Building and pushing Frontend api to ACR" -ForegroundColor Blue
$frontEndApiImageName = "genaiplatform/frontend-api"
$frontEndApiDockerfilePath = "..\src\dotnet\frontendApi\Dockerfile"
$frontEndApiSourcePath = "..\src\dotnet\"
az acr build --registry $acrName --image $frontEndApiImageName --file $frontEndApiDockerfilePath $frontEndApiSourcePath

if ($? -eq $true) {
    Write-Host "Frontend api built and pushed to ACR" -ForegroundColor Green
}
else {
    Write-Host "Frontend api build and push failed" -ForegroundColor Red
    return
}

Write-Host "Creating frontend-api"
az deployment group create --resource-group $rsgName --template-file "./aca/aca-frontendapi.bicep" --parameters "./aca/aca-frontendapi.bicepparam"
if ($? -eq $true) {
    Write-Host "Frontend api deployed successfully" -ForegroundColor Green
}
else {
    Write-Host "Frontend api deployment failed" -ForegroundColor Red
    return
}
