terraform {
  required_providers {
    proxmox = {
      source  = "Telmate/proxmox"
      version = "2.6.7"
    }
  }
  required_version = ">=0.14"
}

resource "proxmox_lxc" "lxc-container" {
  target_node     = var.target_node
  hostname        = var.hostname
  cores           = var.cores
  memory          = var.memory
  ostemplate      = var.os_image_id
  password        = var.password
  unprivileged    = var.unprivileged
  ssh_public_keys = var.ssh_key
  start           = true
  vmid            = var.vmid
  pool            = var.pool

  // we need to define a root fs or terraform is not able to provision the container
  rootfs {
    storage = var.storage
    size    = var.storage_size
  }

  network {
    name     = "eth0"
    bridge   = var.target_br
    gw       = var.target_gw
    ip       = "${var.target_lan}.${var.vmid}/24"
    firewall = var.firewall
  }

  features {
    keyctl  = true
    nesting = true
  }

  lifecycle {
    ignore_changes = [network, rootfs, start, ostype, ssh_public_keys, ostemplate, ]
  }
}
