# Azure KeyVault integration for my-xm and my-xm-slot ARM Templates

This folder contains the script to store the secrets necessary for my-xm and my-xm-slot deployments.

Secrets stored:
 
  * SitecoreLicense
  * SqlServerLogin
  * SqlServerPassword
  * SitecoreAdminPassword
  * SitecoreXmCdMsDeployPackageUrl
  * SitecoreXmCmMsDeployPackageUrl
    
You could use [this script](./deploy-keyvault.ps1) and adapt it for your own deployments.