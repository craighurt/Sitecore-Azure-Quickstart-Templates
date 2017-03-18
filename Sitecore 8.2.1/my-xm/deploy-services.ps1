Param(
    [string] [Parameter(Mandatory=$true)] $ResourceGroupName,
    [string] $ResourceGroupLocation = "East US",
    [string] $TemplateFile = ".\azuredeploy-services.json",
    [string] [Parameter(Mandatory=$true)] $KeyVaultName,
    [string] [Parameter(Mandatory=$true)] $SqlServerLogin
)

$sqlServerPasswordKeyVaultSecret = Get-AzureKeyVaultSecret -VaultName $SecureKeyVault -Name "SqlServerPassword";
$sqlServerPassword = ConvertTo-SecureString ($secretSqlPass.SecretValueText) -AsPlainText -Force;

#Login-AzureRmAccount
#Select-AzureRmSubscription -SubscriptionName "TODO"
New-AzureRmResourceGroup -Name $ResourceGroupName -Location $ResourceGroupLocation;
New-AzureRmResourceGroupDeployment -Name $ResourceGroupName -ResourceGroupName $ResourceGroupName -TemplateFile $TemplateFile -sqlserverLogin $SqlServerLogin -sqlserverPassword $sqlServerPassword;