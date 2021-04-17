terraform {
  required_providers {
    proxmox = {
      source  = "Telmate/proxmox"
      version = "2.6.7"
    }
  }
  required_version = ">=0.14"
}

resource "proxmox_vm_qemu" "pve_vm" {
  name        = var.hostname
  target_node = var.target_node
  pool        = var.pool
  vmid        = var.vmid

  clone = var.os_template_id

  os_type = "cloud-init"
  cores   = var.cores
  memory  = var.memory

  disk {
    size    = var.storage_size
    type    = "scsi"
    storage = var.storage
  }

  network {
    model  = "virtio"
    bridge = var.target_br
  }

  # Cloud Init Settings
  ciuser     = "root"
  cipassword = var.password
  ipconfig0  = "ip=${var.target_lan}.${var.vmid}/24,gw=${var.target_gw}"

  sshkeys = <<EOF
  ${var.ssh_key}
  EOF
}
