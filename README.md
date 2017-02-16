/!\ Caution: non official repo for the Sitecore ARM Templates, official ones could be found [here](https://github.com/Sitecore/Sitecore-Azure-Quickstart-Templates).

This repo is my playground to customize what Sitecore provides by default and share other features and practices you could use for your own project and needs.
/!\ Caution: watch what is done here before using them, you are responsible for the cost in Azure and other consideration which could be generated and impacted by these templates.

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

* [XP0](xp0/README.md) - official template "as-is"
* [XP](xp/README.md) - official template "as-is"
* [XM](xm/README.md) - official template "as-is"

## My XM Sitecore template to create an Azure Web App Slot for XM

* [XM-Slot](xm-slot/README.md) - custom template to deploy XM packages/services on an Azure Web App Slot

## My custom XM Sitecore templates

* [MY-XM](my-xm/README.md) - my playground with custom changes. Use them, share them, adapt them and let's be creative! ;)


