Param(
    [string] [Parameter(Mandatory=$true)] $ResourceGroupName,
    [string] $ResourceGroupLocation = "East US",
    [string] $TemplateFile = ".\azuredeploy.json",
    [string] [Parameter(Mandatory=$true)] $KeyVaultName,
    [string] [Parameter(Mandatory=$true)] $SqlServerLogin
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

$secretLicense = Get-AzureKeyVaultSecret $VaultName $SecureKeyVault -Name "SitecoreLicense" ;
$zipContent = [System.Convert]::FromBase64String($secretLicense.SecretValueText);
$licenseFile = Unzip($zipContent);
$licenseFileContent = [System.Text.Encoding]::UTF8.GetString($licenseFile);

$sitecoreAdminPasswordKeyVaultSecret = Get-AzureKeyVaultSecret $VaultName $SecureKeyVault -Name "SitecoreAdminPassword";
$sitecoreAdminPassword = ConvertTo-SecureString ($sitecoreAdminPasswordKeyVaultSecret.SecretValueText) -AsPlainText -Force;

$sqlServerPasswordKeyVaultSecret = Get-AzureKeyVaultSecret -VaultName $SecureKeyVault -Name "SqlServerPassword";
$sqlServerPassword = ConvertTo-SecureString ($sqlServerPasswordKeyVaultSecret.SecretValueText) -AsPlainText -Force;

$cdMsDeployPackageUrlKeyVaultSecret = Get-AzureKeyVaultSecret -VaultName $SecureKeyVault -Name "SqlServerPassword";
$cdMsDeployPackageUrl = $cdMsDeployPackageUrlKeyVaultSecret.SecretValueText;

$cmMsDeployPackageUrlKeyVaultSecret = Get-AzureKeyVaultSecret -VaultName $SecureKeyVault -Name "SqlServerPassword";
$cmMsDeployPackageUrl = $cmMsDeployPackageUrlKeyVaultSecret.SecretValueText;

$parameters = New-Object -TypeName Hashtable;
$parameters.Add("cdMsdeployPackageurl", $cdMsDeployPackageUrl);
$parameters.Add("cmMsdeployPackageurl", $cmMsDeployPackageUrl);
$parameters.Add("sqlserverLogin", $SqlServerLogin);
$parameters.Add("sqlserverPassword", $sqlServerPassword);
$parameters.Add("sitecoreAdminPassword", $sitecoreAdminPassword);
$parameters.Add("licenseXml", $licenseFileContent);

#Login-AzureRmAccount
#Select-AzureRmSubscription -SubscriptionName "TODO"

New-AzureRmResourceGroup -Name $ResourceGroupName -Location $ResourceGroupLocation;
New-AzureRmResourceGroupDeployment -Name $ResourceGroupName -ResourceGroupName $ResourceGroupName -TemplateFile $TemplateFile -TemplateParameterObject $parameters;
                                    