# Sitecore XM Environment (customized, non official!)

<a href="http://armviz.io/#/?load=https%3A%2F%2Fraw.githubusercontent.com%2FSitecore%2Fsitecore-azure-quickstart-templates%2Fmaster%2FSitecore%208.2.1%2Fxm%2Fazuredeploy.json%3Ftoken=AVW1Ug5RN1ZFpjUwqAajiNyO-D8COvpzks5YL89jwA%3D%3D" target="_blank">
    <img src="http://armviz.io/visualizebutton.png"/>
</a>

This template creates a Sitecore XM Environment with all resources necessary to run Sitecore.

Resources provisioned:
 
  * Azure SQL databases : core, master, web
  * Azure Search Service for content search
  * Azure Redis Cache for session state
  * Application Insights for diagnostics and monitoring
  * 2 Sitecore roles: Content Delivery, Content Management

    * Hosting plans: one per role
    * Preconfigured Web Applications, based on the provided WebDeploy packages
    
## What are the differences with the official XM template/repo?

Here is the list of the differences:
* Format the files (tab, space, newline, etc.).
* Add the [deploy.ps1](/deploy.ps1) script file to be reused.
* Have the parameters in Camel Casing like explained in this PR #3.
* Remove some extra `dependsOn` to have a faster deployment like explained in this PR #4.

Here is the list of the other changes I would like to do:
* Integrate [my slot template](../xm-slot) into this folder.
* Integrate the App Settings and Connection Strings on the Azure Web Apps on itself.
* Integrate some Alert Rules on the Azure Web Apps on itself.
* Split the main template into different nested deployment (separation of services and msdeploy provision).
* Add the "Deploy on Azure" button accordingly.

## Parameters
The **deploymentId** and **licenseXml** parameters are filled in by the PowerShell script.

| Parameter               | Description
--------------------------|------------------------------------------------
| sqlserverLogin          | The name of the administrator account for the newly created Azure SQL server.
| sqlserverPassword       | The password for the administrator account for Azure SQL server.
| sitecoreAdminPassword   | The new password for the Sitecore **admin** account.
| cmMsdeployPackageurl    | The blob storage url to a Sitecore XM Content Management Web Deploy package.
| cdMsdeployPackageurl    | The blob storage url to a Sitecore XM Content Delivery Web Deploy package.

## Script to deploy

You could use [this script](./deploy.ps1) and adapt it for your deployments.
