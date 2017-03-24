__/!\ Caution: non official repo for the Sitecore ARM Templates, official ones could be found [here](https://github.com/Sitecore/Sitecore-Azure-Quickstart-Templates).__

__This repo is my playground to customize what Sitecore provides by default and share other features and practices you could use for your own project and needs.__

__/!\ Caution: watch what is done here before using them, you are responsible for the cost in Azure and other consideration which could be generated and impacted by these templates.__

Please, if you have any suggestion or contribution in mind, feel free to share, fork, contribute, etc.

# Sitecore-Azure-Quickstart-Templates
This repo contains all currently available Azure Resource Manager templates for Sitecore

# Documentation
You can read all about Sitecore Azure AppService integration and ARM Template deployment at [Sitecore Documentation Site](https://doc.sitecore.net/cloud)

# Compatibility
Choose the compatible templates for your Sitecore version:

| Templates Folder | Compatible Sitecore versions                       |
|------------------|----------------------------------------------------|
| Sitecore 8.2.1   | Sitecore 8.2 Update-1 and Sitecore 8.2 Update-2    |

# Pre-deployment Checklist
1. Ensure you have the latest Azure PowerShell SDK installed
2. Ensure you have uploaded your Sitecore Web Deploy packages to a blob storage location 
3. Ensure you have a cloud-hosted instance of MongoDB for Experience Database in XP and XP0 configurations.
4. Download and update the parameter values in the **azuredeploy.parameters.json** file

# How my forked repository is structured

## Official Sitecore templates "as-is"

* [xp0](Sitecore%208.2.1/xp0) - official template "as-is"
* [xp](Sitecore%208.2.1/xp) - official template "as-is"
* [xm](Sitecore%208.2.1/xm) - official template "as-is"
* [xdb](Sitecore%208.2.1/xdb) - official template "as-is"

## Unofficial Sitecore template to create an Azure Web App Slot for XM

* [xm-slot](Sitecore%208.2.1/xm-slot) - based on the official XM Template, custom template to deploy XM packages/services on an Azure Web App Slot

## My custom XM Sitecore templates

My playground with custom changes. Use them, share them, adapt them and let's be creative! ;)

* [keyvault](Sitecore%208.2.1/keyvault) - more details by following the link.
* [my-xm](Sitecore%208.2.1/my-xm) - more details by following the link.
* [my-xm-slot](Sitecore%208.2.1/my-xm-slot) - more details by following the link.

## Visual Studio Team Service (VSTS) deployment

Furthermore, you could find my entire documentation to setup the associated Visual Studio Team Service (VSTS) deployment with this [blog article](https://alwaysupalwayson.blogspot.com/2017/03/advanced-sitecore-arm-templates.html).


