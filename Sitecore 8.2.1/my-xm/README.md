# Sitecore XM Environment (customized, non official!)

This template creates a Sitecore XM Environment with all resources necessary to run Sitecore.

Resources provisioned:
 
  * Azure SQL databases : core, master, web
  * Azure Search Service for content search
  * Azure Redis Cache for session state
  * Application Insights for diagnostics and monitoring
  * 2 Sitecore roles: Content Delivery, Content Management

    * Hosting plans: one per role
    * Preconfigured Web Applications, based on the provided WebDeploy packages
    
# What are the differences with the official XM template/repo?

Here is the list of the differences:
* Format the files (tab, space, newline, etc.).
* Add the PowerShell script files to be reused.
* Have the parameters in Camel Casing like explained in this PR #3
* Remove some extra `dependsOn` to have a faster deployment like explained in this PR #4
* Integrate Connection Strings on the Azure Web Apps on itself.
* Add the "Deploy on Azure" button accordingly.
* Split the azuredeploy.json to have separately 2 deployments: Azure services and the MSDeploy (PR #6).

# Deployments

In this folder, the deployments are split into 2 file:
* [azuredeploy.json](./azuredeploy.json) - manage just the Azure services deployment (without the MSDeploy).
* [azuredeploy-msdeploy.json](./azuredeploy-msdeploy.json) - manage just the MSDeploy (CM and CD) deployments.

# Azure services deployment

You could use [this script](./deploy.ps1) and adapt it for your own deployments.

Furthermore, to deploy just the Azure services (without deploying the MSDeploy packages nor restoring the DACPAC files) you could use this button:

<a href="https://portal.azure.com/#create/Microsoft.Template/uri/https%3A%2F%2Fraw.githubusercontent.com%2Fmathieu-benoit%2FSitecore-Azure-Quickstart-Templates%2Fmaster%2FSitecore%208.2.1%2Fmy-xm%2Fazuredeploy.json" target="_blank">![Deploy to Azure](http://azuredeploy.net/deploybutton.png)</a>

# MSDeploy deployment

Important note: before running this "MSDeploy deployment" the Azure Web App should have been created by running the above "Azure services deployment".

You could use [this script](./deploy-msdeploy.ps1) and adapt it for your own deployments.