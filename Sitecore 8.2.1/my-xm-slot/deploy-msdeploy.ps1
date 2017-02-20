Param(
    [string] [Parameter(Mandatory=$true)] $ResourceGroupName,
    [string] $ResourceGroupLocation = "East US",
    [string] $TemplateFile = ".\azuredeploy-msdeploy.json",
    [string] $LicenseFile = ".\license.xml",
    [string] $CdMsDeployPackageUrl = 'TODO/xm1/Sitecore%208.2%20rev.%20161221_cd.scwdp.zip',
    [string] $CmMsDeployPackageUrl = 'TODO/xm1/Sitecore%208.2%20rev.%20161221_cm.scwdp.zip',
    [string] [Parameter(Mandatory=$true)] $SqlServerLogin,
    [securestring] [Parameter(Mandatory=$true)] $SqlServerPassword,
    [securestring] [Parameter(Mandatory=$true)] $SitecoreAdminPassword
)

$licenseFileContent = Get-Content -Raw -Encoding UTF8 -Path $LicenseFile | Out-String;
$parameters = New-Object -TypeName Hashtable;
$parameters.Add("cdMsdeployPackageurl", $CdMsDeployPackageUrl);
$parameters.Add("cmMsdeployPackageurl", $CmMsDeployPackageUrl);
$parameters.Add("sqlserverLogin", $SqlServerLogin);
$parameters.Add("sqlserverPassword", $SqlServerPassword);
$parameters.Add("sitecoreAdminPassword", $SitecoreAdminPassword);
$parameters.Add("licenseXml", $licenseFileContent);

#Login-AzureRmAccount
#Select-AzureRmSubscription -SubcriptionName "TODO"
New-AzureRmResourceGroupDeployment -Name $ResourceGroupName -ResourceGroupName $ResourceGroupName -TemplateFile $TemplateFile -TemplateParameterObject $parameters;

                                    