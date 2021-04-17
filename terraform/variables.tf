variable "pm_api_url" {
  default = "https://192.168.1.15:8006/api2/json"
}

variable "pm_user" {
  default = "root@pam"
}

variable "pm_password" {
  default   = ""
  sensitive = true
}

variable "target_node" {
  default = "proxmox"
}

variable "target_lan" {
  default = "192.168.1"
}
variable "target_gw" {
  default = "192.168.1.1"
}