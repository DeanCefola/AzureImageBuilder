

##########################################
#    Set up environment and variables    #
##########################################
$imageResourceGroup = 'AIB-Rg'
$location           = 'eastus'
$imageTemplateName  = 'wvd10ImageTemplate01'
$templateFilePath = "armTemplateWVD.json"
Import-Module -Name Az.ImageBuilder


#############################
#    Submit the template    #
#############################
New-AzResourceGroupDeployment `
    -ResourceGroupName $imageResourceGroup `
    -TemplateFile $templateFilePath `
    -api-version "2020-02-14" `
    -imageTemplateName $imageTemplateName `
    -svclocation $location
$getStatus = $(Get-AzImageBuilderTemplate -ResourceGroupName $imageResourceGroup -Name $imageTemplateName)
$getStatus.ProvisioningErrorCode 
$getStatus.ProvisioningErrorMessage


#########################
#    Build the image    #
#########################
Start-AzImageBuilderTemplate `
    -ResourceGroupName $imageResourceGroup `
    -Name $imageTemplateName `
    -NoWait
$getStatus = $(Get-AzImageBuilderTemplate -ResourceGroupName $imageResourceGroup -Name $imageTemplateName)
$getStatus | Format-List -Property *
cls
$getStatus.LastRunStatusRunState 
$getStatus.LastRunStatusMessage
$getStatus.LastRunStatusRunSubState
