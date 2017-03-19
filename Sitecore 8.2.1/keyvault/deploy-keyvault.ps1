Param(
    [string] [Parameter(Mandatory=$true)] $ResourceGroupName,
    [string] [Parameter(Mandatory=$true)] $KeyVaultName,
    [string] $Location = "East US",
    [string] $LicenseFile = ".\license.xml",
    [string] $SitecoreCdMsDeployPackageUrl = 'TODO/xm1/Sitecore%208.2%20rev.%20161221_cd.scwdp.zip',
    [string] $SitecoreCmMsDeployPackageUrl = 'TODO/xm1/Sitecore%208.2%20rev.%20161221_cm.scwdp.zip',
    [securestring] [Parameter(Mandatory=$true)] $SqlServerPassword,
    [securestring] [Parameter(Mandatory=$true)] $SitecoreAdminPassword
)

Function Zip
{
    param([byte[]]$content)
    $output = New-Object System.IO.MemoryStream; 
    $gzipStream = New-Object System.IO.Compression.GzipStream ($output , ([IO.Compression.CompressionMode]::Compress));
    $gzipStream.Write($content, 0, $content.Length);
    $gzipStream.Close();
    return $output.ToArray();
}

#Login-AzureRmAccount;
#Select-AzureRmSubscription -SubscriptionName "TODO"
#New-AzureRmResourceGroup -Name $ResourceGroupName -Location $Location;

New-AzureRmKeyVault -VaultName $KeyVaultName -ResourceGroupName $ResourceGroupName -Location $Location;
$zipContent = Zip([IO.File]::ReadAllBytes($LicenseFile));
$zipString=[System.Convert]::ToBase64String($zipContent);
$secretLicense = ConvertTo-SecureString $zipString -AsPlainText -Force;
$secretSitecoreCdMsDeployPackageUrl = ConvertTo-SecureString $SitecoreCdMsDeployPackageUrl -AsPlainText -Force;
$secretSitecoreCmMsDeployPackageUrl = ConvertTo-SecureString $SitecoreCmMsDeployPackageUrl -AsPlainText -Force;
Set-AzureKeyVaultSecret -VaultName $KeyVaultName -Name 'SitecoreLicense' -SecretValue $secretLicense;
Set-AzureKeyVaultSecret -VaultName $KeyVaultName -Name 'SqlServerPassword' -SecretValue $SqlServerPassword;
Set-AzureKeyVaultSecret -VaultName $KeyVaultName -Name 'SitecoreAdminPassword' -SecretValue $SitecoreAdminPassword;
Set-AzureKeyVaultSecret -VaultName $KeyVaultName -Name 'SitecoreCdMsDeployPackageUrl' -SecretValue $secretSitecoreCdMsDeployPackageUrl;
Set-AzureKeyVaultSecret -VaultName $KeyVaultName -Name 'SitecoreCmMsDeployPackageUrl' -SecretValue $secretSitecoreCmMsDeployPackageUrl;