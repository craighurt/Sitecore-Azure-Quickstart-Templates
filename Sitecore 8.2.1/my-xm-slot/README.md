__/!\ IMPORTANT: The main Azure Web App of this Slot should be created before running this templates (in this case you have to deploy the [MY-XM template](../my-xm)).__

# Sitecore XM Slot Environment (customized, non official!)

This template creates a Sitecore XM Environment with all resources necessary to run Sitecore.

Resources provisioned:
 
  * Azure SQL databases : core, master, web
  * Azure Search Service for content search
  * Azure Redis Cache for session state
  * Application Insights for diagnostics and monitoring
  * 2 Sitecore roles on Slot: Content Delivery, Content Management

    * Hosting plans: one per role
    * Preconfigured Web Applications, based on the provided WebDeploy packages
    
# What are the differences with the XM-SLOT template/repo?

Here is the list of the differences:
* Format the files (tab, space, newline, etc.).
* Add the PowerShell script files to be reused.
* Have the `parameters` in Camel Casing like explained in this PR #3
* Remove some extra `dependsOn` to have a faster deployment like explained in this PR #4
* Integrate Connection Strings on the Azure Web Apps on itself.
* Add the "Deploy on Azure" button accordingly.
* Split the azuredeploy.json to have separately 2 deployments: Azure services and the MSDeploy (PR #6).
* Add the `allowedValues` when possible (PR #8).
* Fix the Search service `replicacount` property name + `apiVersion` date value (PR #8).
* Assign `alwaysOn` and `use32BitWorkerProcess` according the `web.sku.name` value (PR #8).
* Take into account the `linkedTemplate` pattern with this PR #9.

# Deployments

In this folder, the deployments are split into 3 main files:
* [azuredeploy.json](./azuredeploy.json) - manage both the Azure services deployment and the MSDeploy deployment.
* [azuredeploy-services.json](./azuredeploy-services.json) - manage just the Azure services deployment (without the MSDeploy).
* [azuredeploy-msdeploy.json](./azuredeploy-msdeploy.json) - manage just the MSDeploy (CM and CD) deployments.

# Full deployment

Important note: before running this "Full deployment" the Azure Web App should have been created by running the [my-xm](../my-xm) "Full deployment" or "Azure services only deployment".

You could use [this script](./deploy.ps1) and adapt it for your own deployments.

This will deploy first [azuredeploy-services.json](./azuredeploy-services.json) and then [azuredeploy-msdeploy.json](./azuredeploy-msdeploy.json).

# Azure services only deployment

Important note: before running this "Azure services deployment" the Azure Web App should have been created by running the [my-xm](../my-xm) "Full deployment" or "Azure services only deployment".

You could use [this script](./deploy-services.ps1) and adapt it for your own deployments.

Furthermore, to deploy just the Azure services (without deploying the MSDeploy packages nor restoring the DACPAC files) you could use this button:

<a href="https://portal.azure.com/#create/Microsoft.Template/uri/https%3A%2F%2Fraw.githubusercontent.com%2Fmathieu-benoit%2FSitecore-Azure-Quickstart-Templates%2Fmaster%2FSitecore%208.2.1%2Fmy-xm-slot%2Fazuredeploy-services.json" target="_blank">![Deploy to Azure](http://azuredeploy.net/deploybutton.png)</a>

# MSDeploy only deployment

Important note: before running this "MSDeploy deployment" the Azure Web App Slot should have been created by running the above "Azure services only deployment".

You could use [this script](./deploy-msdeploy.ps1) and adapt it for your own deployments.