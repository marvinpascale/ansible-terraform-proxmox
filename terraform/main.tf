module "ubuntu" {
  source       = "./pve-vm"
  vmid         = "201"
  hostname     = "ubuntu01"
  cores        = 2
  memory       = 512
  target_br    = "vmbr0"
  target_node  = "gamora"
  storage      = "qnap_nfs"

  pm_api_url   = var.pm_api_url
  pm_user      = var.pm_user
  pm_password  = var.pm_password
}

module "web-server" {
  source       = "./lxc-container"
  vmid         = "202"
  os_image_id  = "bk:vztmpl/debian-10-standard_10.5-1_amd64.tar.gz"
  cores        = 2
  memory       = 512
  storage_size = "10GB"
  hostname     = "lxc-web-server"
  target_br    = "vmbr0"
  target_node  = "gamora"
  storage      = "qnap_nfs"

  pm_api_url   = var.pm_api_url
  pm_user      = var.pm_user
  pm_password  = var.pm_password
}
