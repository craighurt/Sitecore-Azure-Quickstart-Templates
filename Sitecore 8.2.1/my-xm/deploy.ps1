Param(
    [string] [Parameter(Mandatory=$true)] $ResourceGroupName,
    [string] $ResourceGroupLocation = "East US",
    [string] $TemplateFile = ".\azuredeploy.json",#".\azuredeploy-msdeploy.json",
    [string] [Parameter(Mandatory=$true)] $KeyVaultName
)

Function Unzip
{
    param([byte[]]$gzipContent)
    $input = New-Object System.IO.MemoryStream (,$zipContent); 
    $gzipStream = New-Object System.IO.Compression.GzipStream ($input, ([IO.Compression.CompressionMode]::Decompress));
    $output = New-Object System.IO.MemoryStream;
    $gzipStream.CopyTo($output);
    return $output.ToArray();
}

$secretLicense = Get-AzureKeyVaultSecret -VaultName $KeyVaultName -Name "SitecoreLicense";
$zipContent = [System.Convert]::FromBase64String($secretLicense.SecretValueText);
$licenseFile = Unzip($zipContent);
$licenseFileContent = [System.Text.Encoding]::UTF8.GetString($licenseFile);

$sitecoreAdminPasswordKeyVaultSecret = Get-AzureKeyVaultSecret -VaultName $KeyVaultName -Name "SitecoreAdminPassword";
$sitecoreAdminPassword = ConvertTo-SecureString ($sitecoreAdminPasswordKeyVaultSecret.SecretValueText) -AsPlainText -Force;

$sqlServerLoginKeyVaultSecret = Get-AzureKeyVaultSecret -VaultName $KeyVaultName -Name "SqlServerLogin";
$sqlServerLogin = $sqlServerLoginKeyVaultSecret.SecretValueText;

$sqlServerPasswordKeyVaultSecret = Get-AzureKeyVaultSecret -VaultName $KeyVaultName -Name "SqlServerPassword";
$sqlServerPassword = ConvertTo-SecureString ($sqlServerPasswordKeyVaultSecret.SecretValueText) -AsPlainText -Force;

$cdMsDeployPackageUrlKeyVaultSecret = Get-AzureKeyVaultSecret -VaultName $KeyVaultName -Name "SitecoreXmCdMsDeployPackageUrl";
$cdMsDeployPackageUrl = $cdMsDeployPackageUrlKeyVaultSecret.SecretValueText;

$cmMsDeployPackageUrlKeyVaultSecret = Get-AzureKeyVaultSecret -VaultName $KeyVaultName -Name "SitecoreXmCmMsDeployPackageUrl";
$cmMsDeployPackageUrl = $cmMsDeployPackageUrlKeyVaultSecret.SecretValueText;

$parameters = New-Object -TypeName Hashtable;
$parameters.Add("cdMsdeployPackageurl", $cdMsDeployPackageUrl);
$parameters.Add("cmMsdeployPackageurl", $cmMsDeployPackageUrl);
$parameters.Add("sqlserverLogin", $sqlServerLogin);
$parameters.Add("sqlserverPassword", $sqlServerPassword);
$parameters.Add("sitecoreAdminPassword", $sitecoreAdminPassword);
$parameters.Add("licenseXml", $licenseFileContent);

#Login-AzureRmAccount
#Select-AzureRmSubscription -SubscriptionName "TODO"

New-AzureRmResourceGroup -Name $ResourceGroupName -Location $ResourceGroupLocation;
New-AzureRmResourceGroupDeployment -Name $ResourceGroupName -ResourceGroupName $ResourceGroupName -TemplateFile $TemplateFile -TemplateParameterObject $parameters;
                                    