locals {
  master_count = 3
  worker_count = 0
}

resource "hyperv_network_switch" "hyperv" {
  name = "hyperv"
}

resource "hyperv_vhd" "masterVHDs" {
  count = local.master_count

  path = "C:\\Users\\nolan\\HyperV\\master${count.index}.vhdx" #Needs to be absolute path
  
  size = 20 * pow(1024, 3)
  # size      = count.index == 0 ? 10 * pow(1024, 3) : null
  # source_vm = count.index > 0 ? local.masterVMs[0] : null
  # source = "C:\\Users\\nolan\\HyperV\\debian-ready.vhdx"
}

resource "hyperv_machine_instance" "masterVMs" {
  count = local.master_count

  name                   = "master${count.index}"
  generation             = 2
  dynamic_memory         = true
  memory_minimum_bytes   = 2 * pow(1024, 3)
  memory_maximum_bytes   = 2 * pow(1024, 3)
  memory_startup_bytes   = 2 * pow(1024, 3)
  processor_count        = 2
  wait_for_state_timeout = 10
  wait_for_ips_timeout   = 10

  vm_firmware {
    enable_secure_boot = "Off"
  }

  network_adaptors {
    name         = "Ethernet"
    switch_name  = "Default Switch"
    wait_for_ips = false
  }

  network_adaptors {
    name         = "VNet"
    switch_name  = hyperv_network_switch.hyperv.name
    wait_for_ips = false
  }

  hard_disk_drives {
    path                = hyperv_vhd.masterVHDs[count.index].path
    controller_number   = 0
    controller_location = 1
  }

  dvd_drives {
    controller_number   = 0
    controller_location = 0
    path                = "C:\\Users\\nolan\\HyperV\\dvds\\debian.iso"
  }
}

resource "hyperv_vhd" "workerVHDs" {
  count = local.worker_count

  path = "C:\\Users\\nolan\\HyperV\\worker${count.index}.vhdx"
  
  size = 20 * pow(1024, 3)
}

resource "hyperv_machine_instance" "workerVMs" {
  count = local.worker_count

  name                   = "worker${count.index}"
  generation             = 2
  dynamic_memory         = true
  memory_minimum_bytes   = pow(1024, 3)
  memory_maximum_bytes   = pow(1024, 3)
  memory_startup_bytes   = pow(1024, 3)
  processor_count        = 1
  wait_for_state_timeout = 10
  wait_for_ips_timeout   = 10

  vm_firmware {
    enable_secure_boot = "Off"
  }

  network_adaptors {
    name         = "eth0"
    switch_name  = "Default Switch"
    wait_for_ips = false
  }

  network_adaptors {
    name         = "eth1"
    switch_name  = hyperv_network_switch.hyperv.name
    wait_for_ips = false
  }

  hard_disk_drives {
    path                = hyperv_vhd.workerVHDs[count.index].path
    controller_number   = 0
    controller_location = 1
  }

  dvd_drives {
    controller_number   = 0
    controller_location = 0
    path                = "C:\\Users\\nolan\\HyperV\\dvds\\debian.iso"
  }
}
