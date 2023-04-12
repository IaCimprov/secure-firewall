#-------------------azure common Variables-------------#
variable "subscription_id" {
  type        = string
  description = ""
}

variable "tenant_id" {
  type        = string
  description = ""
}

variable "client_id" {
  type        = string
  description = ""
}

variable "client_secret" {
  type        = string
  description = ""
}

# --------------------resource group variables----------------------------#

variable "rg_name" {
  type        = string
  description = "Azure Resource Group"
}

variable "location" {
  description = "Geographic region resource will be deployed into"
  type        = string
}

variable "instances" {
  type        = number
  description = "Number of FTDv instances"
}
