resource "hyperv_network_switch" "sw" {
  name = "sw"
}

resource "hyperv_vhd" "master1" {
  path = "C:\\Users\\nolan\\HyperV\\master1.vhdx" #Needs to be absolute path
  size = 10737418240                          #10GB
}

resource "hyperv_machine_instance" "master1" {
  name = "master1"
  generation             = 2
  dynamic_memory = true
  static_memory = null
  wait_for_state_timeout = 10
  wait_for_ips_timeout   = 10

  network_adaptors {
    name         = "wan"
    switch_name  = hyperv_network_switch.sw.name
    wait_for_ips = false
  }

  hard_disk_drives {
    controller_type     = "Ide"
    path                = hyperv_vhd.master1.path
    controller_number   = 0
    controller_location = 0
  }

  dvd_drives {
    controller_number   = 0
    controller_location = 1
    path                = "C:\\Users\\nolan\\HyperV\\dvds\\debian-12.7.0-amd64-netinst.iso"
  }
}
