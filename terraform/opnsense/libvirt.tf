resource "libvirt_volume" "terraform-opnsense-base-qcow2" {
  name = "terraform-opnsense-base.qcow2"
  pool = "default"
  source = "./opnsense.qcow2"
  format = "qcow2"
}

resource "libvirt_volume" "terraform-opnsense-qcow2" {
  name = "terraform-opnsense.qcow2"
  pool = "default"
  format = "qcow2"
  size = 20000000000
  base_volume_id = libvirt_volume.terraform-opnsense-base-qcow2.id
}

data "template_file" "user_data" {
  template = "${file("${path.module}/cloud_init.cfg")}"
}

resource "libvirt_cloudinit_disk" "terraform-opnsense-commoninit" {
  name = "terraform-opnsense-commoninit.iso"
  pool = "default"
  user_data = "${data.template_file.user_data.rendered}"
}

resource "libvirt_domain" "terraform-opnsense" {
  name   = "terraform-opnsense"
  memory = "2048"
  vcpu   = 2

  cpu {
    mode = "host-passthrough"
  }

  network_interface {
    network_name = "default"
  }

  disk {
    volume_id = "${libvirt_volume.terraform-opnsense-qcow2.id}"
  }

  cloudinit = "${libvirt_cloudinit_disk.terraform-opnsense-commoninit.id}"

  console {
    type = "pty"
    target_type = "serial"
    target_port = "0"
  }

  graphics {
    type = "spice"
    listen_type = "address"
    autoport = true
  }
}
