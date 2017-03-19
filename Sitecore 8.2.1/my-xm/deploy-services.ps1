Param(
    [string] [Parameter(Mandatory=$true)] $ResourceGroupName,
    [string] $ResourceGroupLocation = "East US",
    [string] $TemplateFile = ".\azuredeploy-services.json",
    [string] [Parameter(Mandatory=$true)] $KeyVaultName
)

$sqlServerLoginKeyVaultSecret = Get-AzureKeyVaultSecret -VaultName $KeyVaultName -Name "SqlServerLogin";
$sqlServerLogin = ConvertTo-SecureString ($sqlServerLoginKeyVaultSecret.SecretValueText) -AsPlainText -Force;

$sqlServerPasswordKeyVaultSecret = Get-AzureKeyVaultSecret -VaultName $KeyVaultName -Name "SqlServerPassword";
$sqlServerPassword = ConvertTo-SecureString ($sqlServerPasswordKeyVaultSecret.SecretValueText) -AsPlainText -Force;

#Login-AzureRmAccount
#Select-AzureRmSubscription -SubscriptionName "TODO"
New-AzureRmResourceGroup -Name $ResourceGroupName -Location $ResourceGroupLocation;
New-AzureRmResourceGroupDeployment -Name $ResourceGroupName -ResourceGroupName $ResourceGroupName -TemplateFile $TemplateFile -sqlserverLogin $sqlServerLogin -sqlserverPassword $sqlServerPassword;