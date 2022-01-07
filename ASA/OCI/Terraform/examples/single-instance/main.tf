module "asa-1" {
  source            = "../../"
  num_instances     = var.num_instances
  vm_ads_number     = var.vm_ads_number
  user_ocid         = var.user_ocid
  fingerprint       = var.fingerprint
  tenancy_ocid      = var.tenancy_ocid
  private_key_path  = var.private_key_path
  region            = var.region
  compartment_id    = var.compartment_id
  label_prefix      = var.label_prefix
  networks          = var.networks
  admin_ssh_pub_key = var.admin_ssh_pub_key
  enable_password   = var.enable_password
  day_0_config      = var.day_0_config
  inside_network    = var.inside_network
  mgmt_network      = var.mgmt_network
  outside_network   = var.outside_network
  dmz1_network      = var.dmz1_network
  dmz2_network      = var.dmz2_network
  service_port      = 8080
}