Param(
    [string] [Parameter(Mandatory=$true)] $ResourceGroupName,
    [string] $ResourceGroupLocation = "East US",
    [string] [Parameter(Mandatory=$true)] $SlotName,
    [string] $TemplateFile = ".\azuredeploy.json",
    [string] [Parameter(Mandatory=$true)] $KeyVaultName,
    [string] [Parameter(Mandatory=$true)] $SqlServerLogin
)

$sqlServerPasswordKeyVaultSecret = Get-AzureKeyVaultSecret -VaultName $SecureKeyVault -Name "SqlServerPassword";
$sqlServerPassword = ConvertTo-SecureString ($sqlServerPasswordKeyVaultSecret.SecretValueText) -AsPlainText -Force;

#Login-AzureRmAccount
#Select-AzureRmSubscription -SubscriptionName "TODO"
New-AzureRmResourceGroupDeployment -Name $ResourceGroupName -ResourceGroupName $ResourceGroupName -TemplateFile $TemplateFile -slotName $SlotName -sqlserverLogin $SqlServerLogin -sqlserverPassword $sqlServerPassword;
                                    