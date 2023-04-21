<!-- BEGIN_TF_DOCS -->
# Create FTDv firewall Servers module

## Overview

Create Create FTDv firewall servers with spacified values

## Module Name
firewall

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="prefix"></a> [prefix](#prefix) |Prefix to prepend resource names| `string` |cisco-FTDv| yes |
| <a name="fmc_prefix"></a> [fmc_prefix](#fmc_prefix) |Prefix to prepend to FMC resource names| `string` |cisco-FMCv| yes |
| <a name="instances"></a> [instances](#instances) |Number of FTDv instances| `number` |`""`| yes |
| <a name="image_version"></a> [image_version](#image_version) |Version of the FTD | `string` |67065.0.0| yes |
| <a name="fmc_image_version"></a> [fmc_image_version](#fmc_image_version) |Version of the FMC | `string` |73069.0.0| yes |
| <a name="rg_name"></a> [resource group name](#rg_name) |Azure Resource Group | `string` |`""`| yes |
| <a name="location"></a> [location](#location) |Spacify location | `string` |`""`| yes|
| <a name="vm_size"></a> [vm_size](#vm_size) |Spacify VM size | `string` |Standard_D3_v2| yes |
| <a name="instancename"></a> [instancename](#instancename) |Spacify instance name | `string` | FTD01 | yes|
| <a name="username"></a> [username](#username) |Spacify username of FTDv server | `string` | cisco | yes|
| <a name="password"></a> [password](#password) |Spacify password of FTDv server | `string` | `""` | yes|
| <a name="azs"></a> [azs"](#azs") |Azure Availability Zones | `list` | [1,2,3] | yes|
| <a name="ftdv-interface-management"></a> [ftdv-interface-management](#ftdv-interface-management) |ftdv-interface-management | `list` | `""` | yes|
| <a name="ftdv-interface-diagnostic"></a> [ftdv-interface-diagnostic](#ftdv-interface-diagnostic) |ftdv-interface-diagnostic | `list` | `""` | yes|
| <a name="ftdv-interface-outside"></a> [ftdv-interface-outside](#ftdv-interface-outside) |ftdv-interface-outside | `list` | `""` | yes|
| <a name="ftdv-interface-inside"></a> [ftdv-interface-inside](#ftdv-interface-inside) |ftdv-interface-inside | `list` | `""` | yes|
| <a name="tags"></a> [tags](#tags) |Spacify tags witch prepend to resoupces | `map` | {} | yes|

<!-- END_TF_DOCS -->
