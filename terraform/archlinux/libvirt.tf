resource "libvirt_volume" "terraform-archlinux-base-qcow2" {
  name = "terraform-archlinux-base.qcow2"
  pool = "default"
  source = "https://geo.mirror.pkgbuild.com/images/latest/Arch-Linux-x86_64-cloudimg.qcow2"
  format = "qcow2"
}

resource "libvirt_volume" "terraform-archlinux-qcow2" {
  name = "terraform-archlinux.qcow2"
  pool = "default"
  format = "qcow2"
  size = 128000000000
  base_volume_id = libvirt_volume.terraform-archlinux-base-qcow2.id
}

data "template_file" "user_data" {
  template = "${file("${path.module}/cloud_init.cfg")}"
}

resource "libvirt_cloudinit_disk" "terraform-archlinux-commoninit" {
  name = "terraform-archlinux-commoninit.iso"
  pool = "default"
  user_data = "${data.template_file.user_data.rendered}"
}

resource "libvirt_domain" "terraform-archlinux" {
  name   = "terraform-archlinux"
  memory = "16384"
  vcpu   = 12

  cpu {
    mode = "host-passthrough"
  }

  network_interface {
    network_name = "default"
  }

  disk {
    volume_id = "${libvirt_volume.terraform-archlinux-qcow2.id}"
  }

  cloudinit = "${libvirt_cloudinit_disk.terraform-archlinux-commoninit.id}"

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

