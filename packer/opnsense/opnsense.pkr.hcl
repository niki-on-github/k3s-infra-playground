variable "password" {
  type = string
  default = "opnsense"
}

variable "lan_ip" {
  type = string
  default = "192.168.1.1"
}

source "qemu" "opnsense" {
  # iso_url           = "https://mirror.dns-root.de/opnsense/releases/23.1/OPNsense-23.1-OpenSSL-dvd-amd64.iso.bz2"
  iso_url           = "./OPNsense-23.1-OpenSSL-dvd-amd64.iso"
  iso_checksum      = "md5:154230cfb64827f9cfe45858e5a44c5c"
  output_directory  = "output-opnsense"
  disk_size         = "16G"
  format            = "qcow2"
  accelerator       = "kvm"
  ssh_username      = "root"
  ssh_password      = "${var.password}"
  ssh_timeout       = "15m"
  vm_name           = "opnsense.qcow2"
  net_device        = "virtio-net"
  disk_interface    = "virtio"
  memory            = 2048
  boot_wait         = "75s"
  qemuargs = [
        [ "-m", "2048M" ],
        [
            "-netdev",
            "user,id=inet,",
            ""
        ],
        [
            "-netdev",
            "user,id=intnet,",
            ""
        ],
        [ "-device", "virtio-net,netdev=inet" ],
        [ "-device", "virtio-net,netdev=intnet" ]
    ]
  boot_command = [
    # Log in as the 'installer' user
    "installer", "<enter>",
    "<wait1>",

    # With the 'opnsense' password
    "opnsense", "<enter>",
    "<wait1>",

    # Continue with default keymap
    "<enter>",
    "<wait1>",

    # Insall (ZFS)
    "<down>", "<wait1>", "<enter>", "<wait5>",
    "<wait1>",

    # Select 'Stripe'
    "<enter>",
    "<wait1>",

    # Select 'da0' disk
    "<spacebar>", "<wait1>", "<enter>",
    "<wait1>",

    # Confirm selection
    "<left>", "<wait1>", "<enter>",

    # Wait for OS install
    "<wait90>",

    # Select 'Root Password"
    "<enter>",
    "<wait1>",

    # Set root password
    "${var.password}", "<wait1>", "<enter>",
    "<wait1>",

    # Confirm password
    "${var.password}", "<wait1>", "<enter>",

    # Wait for the password to be changed
    "<wait20>",

    # Select 'Complete Install'
    "<down>", "<wait1>", "<enter>",
    "<wait1>",
    "<leftCtrlOn>c<leftCtrlOff>",
    "root", "<enter>",
    "<wait1>",
    "${var.password}", "<enter>",
    "<wait1>",
    "8", "<enter>",
    "<wait1>",

    # chroot install cloud init
    "chroot /mnt /bin/csh", "<wait1>", "<enter>", "<wait2>",
    "pkg install -y net/cloud-init", "<wait1>", "<enter>", "<wait100>",
    "exit", "<wait1>", "<enter>", "<wait2>",

    "echo 'cloudinit_enable=\"YES\"' >> /mnt/usr/local/etc/rc.conf", "<enter>",
    "<wait1>",
    "echo 'cloudinit_enable=\"YES\"' >> /mnt/etc/rc.conf", "<enter>",
    "<wait1>",

    "echo 'openssh_enable=\"YES\"' >> /mnt/usr/local/etc/rc.conf", "<enter>",
    "<wait1>",
    "echo 'openssh_enable=\"YES\"' >> /mnt/etc/rc.conf", "<enter>",
    "<wait1>",
    "sed -i '' 's/<ssh>/<ssh>\\n\\t\\t<enabled>enabled<\\/enabled>/g' /mnt/conf/config.xml", "<enter> ",
    "<wait1>",
    "sed -i '' 's/<ssh>/<ssh>\\n\\t\\t<permitrootlogin>1<\\/permitrootlogin>/g' /mnt/conf/config.xml", "<enter> ",
    "<wait1>",
    "sed -i '' 's/<ssh>/<ssh>\\n\\t\\t<passwordauth>1<\\/passwordauth>/g' /mnt/conf/config.xml", "<enter> ",
    "<wait1>",
    "sed -i '' 's/<ssh>/<ssh>\\n\\t\\t<noauto>1<\\/noauto>/g' /mnt/conf/config.xml", "<enter> ",
    "<wait1>",
    "sed -i '' 's/<ssh>/<ssh>\\n\\t\\t<interfaces \\/>/g' /mnt/conf/config.xml", "<enter> ",
    "<wait1>",
    "sed -i '' 's/192.168.1.1/${var.lan_ip}/g' /mnt/conf/config.xml", "<enter> ",
    "<wait1>",

    # shutdown system
    "exit", "<wait1>", "<enter>", "<wait2>", "5", "<enter>", "<wait1>", "y", "<enter>", "<wait5>"
  ]
  communicator = "none"
}

build {
  sources = ["source.qemu.opnsense"]
}
