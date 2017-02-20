Param(
    [string] [Parameter(Mandatory=$true)] $ResourceGroupName,
    [string] $ResourceGroupLocation = "East US",
    [string] [Parameter(Mandatory=$true)] $SlotName,
    [string] $TemplateFile = ".\azuredeploy.json",
    [string] [Parameter(Mandatory=$true)] $SqlServerLogin,
    [securestring] [Parameter(Mandatory=$true)] $SqlServerPassword
)

#Login-AzureRmAccount
#Select-AzureRmSubscription -SubscriptionName "TODO"
New-AzureRmResourceGroupDeployment -Name $ResourceGroupName -ResourceGroupName $ResourceGroupName -TemplateFile $TemplateFile -slotName $SlotName -sqlserverLogin $SqlServerLogin -sqlserverPassword $SqlServerPassword;
                                    