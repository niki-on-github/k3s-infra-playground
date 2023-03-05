{ config, lib, pkgs, modulesPath, ... }:

{
  imports =
    [ (modulesPath + "/installer/scan/not-detected.nix")
    ];

  boot.initrd.availableKernelModules = [ "nvme" "ahci" "xhci_pci" "usbhid" "usb_storage" "virtio_pci" "mptspi" "sr_mod" "virtio_blk" "sd_mod" "sdhci_pci" "aesni_intel" "cryptd" ];
  boot.initrd.kernelModules = [ ];

  # vmware user must use the module blow:
  # boot.initrd.kernelModules = [ "vmw_pvscsi" ];

  boot.kernelModules = [ "kvm-intel" ];
  boot.extraModulePackages = [ ];
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.efi.efiSysMountPoint = "/boot/efi";
  boot.loader.grub = {
    enable = true;
    version = 2;
    device = "nodev";
    efiSupport = true;
    enableCryptodisk = true;
  };
  boot.kernelParams = [
    "boot.shell_on_fail"
  ];

  boot.initrd = {
    luks.devices.system = {
        device = "/dev/disk/by-partlabel/root";
        preLVM = true;
        keyFile = "/disk.key";
        allowDiscards = true;
    };
    secrets = {
        "disk.key" = "/boot/disk.key";
    };
  };


  fileSystems."/" = {
    device = "/dev/mapper/system";
    fsType = "btrfs";
    options = [ "subvol=@" "compress=zstd" "noatime" ];
  };

  fileSystems."/nix" = {
    device = "/dev/mapper/system";
    fsType = "btrfs";
    options = [ "subvol=@nix" "compress=zstd" "noatime" ];
  };

  fileSystems."/home" = {
    device = "/dev/mapper/system";
    fsType = "btrfs";
    options = [ "subvol=@home" "compress=zstd" "noatime" ];
  };

  fileSystems."/opt" = {
    device = "/dev/mapper/system";
    fsType = "btrfs";
    options = [ "subvol=@opt" "compress=zstd" "noatime" ];
  };

  fileSystems."/var/log" = {
    device = "/dev/mapper/system";
    fsType = "btrfs";
    options = [ "subvol=@log" "compress=zstd" "noatime" ];
  };

  fileSystems."/swap" = {
    device = "/dev/mapper/system";
    fsType = "btrfs";
    options = [ "subvol=@swap" "compress=zstd" "noatime" ];
  };


  fileSystems."/boot/efi" = {
    device = "/dev/disk/by-partlabel/boot";
    fsType = "vfat";
  };


  fileSystems."/opt/k3s/longhorn" = {
    device = "/dev/mapper/data";
    fsType = "ext4";
    encrypted = {
        enable = true;
        label = "data";
        blkDev = "/dev/disk/by-partlabel/data";
        keyFile = "/disk.key";
      };
  };

  swapDevices = [ ];

  networking.useDHCP = lib.mkDefault true;

  hardware.cpu.intel.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
}
