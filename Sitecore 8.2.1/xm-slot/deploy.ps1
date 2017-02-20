Param(
    [string] [Parameter(Mandatory=$true)] $ResourceGroupName,
    [string] $ResourceGroupLocation = "East US",
    [string] $SlotName = "dev",
    [string] $TemplateFile = ".\azuredeploy.json",
    [string] $LicenseFile = ".\license.xml",
    [string] $CdMsDeployPackageUrl = 'TODO/xm1/Sitecore%208.2%20rev.%20161221_cd.scwdp.zip',
    [string] $CmMsDeployPackageUrl = 'TODO/xm1/Sitecore%208.2%20rev.%20161221_cm.scwdp.zip',
    [string] [Parameter(Mandatory=$true)] $SqlServerLogin,
    [securestring] [Parameter(Mandatory=$true)] $SqlServerPassword,
    [securestring] [Parameter(Mandatory=$true)] $SitecoreAdminPassword
)

$licenseFileContent = Get-Content -Raw -Encoding UTF8 -Path $LicenseFile | Out-String;
$parameters = New-Object -TypeName Hashtable;
$parameters.Add("slotName", "dev");
$parameters.Add("cd.msdeploy.packageurl", $CdMsDeployPackageUrl);
$parameters.Add("cm.msdeploy.packageurl", $CmMsDeployPackageUrl);
$parameters.Add("sqlserver.login", $SqlServerLogin);
$parameters.Add("sqlserver.password", $SqlServerPassword);
$parameters.Add("sitecore.admin.password", $SitecoreAdminPassword);
$parameters.Add("licenseXml", $licenseFileContent);

#Login-AzureRmAccount
#Select-AzureRmSubscription -SubscriptionName "TODO"
New-AzureRmResourceGroup -Name $ResourceGroupName -Location $ResourceGroupLocation;
New-AzureRmResourceGroupDeployment -Name $ResourceGroupName -ResourceGroupName $ResourceGroupName -TemplateFile $TemplateFile -TemplateParameterObject $parameters;

                                    