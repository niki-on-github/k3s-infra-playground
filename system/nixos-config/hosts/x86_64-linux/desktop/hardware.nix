{ config, lib, pkgs, ... }:

{
  boot.initrd.availableKernelModules = [ "nvme" "ahci" "xhci_pci" "usbhid" "usb_storage" "virtio_pci" "sr_mod" "virtio_blk" "sd_mod" "sdhci_pci" "aesni_intel" "cryptd" ];
  boot.initrd.kernelModules = [ ];
  boot.kernelModules = [ "kvm-amd" ];
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

  fileSystems."/" =
    { device = "/dev/mapper/system";
      fsType = "btrfs";
      options = [ "subvol=@" "compress=zstd" "noatime" ];
    };

  fileSystems."/home" =
    { device = "/dev/mapper/system";
      fsType = "btrfs";
      options = [ "subvol=@home" "compress=zstd" "noatime" ];
    };

  fileSystems."/nix" =
    { device = "/dev/mapper/system";
      fsType = "btrfs";
      options = [ "subvol=@nix" "compress=zstd" "noatime" ];
    };

  fileSystems."/var/log" =
    { device = "/dev/mapper/system";
      fsType = "btrfs";
      options = [ "subvol=@log" "compress=zstd" "noatime" ];
      neededForBoot = true;
    };

  fileSystems."/opt" = {
    device = "/dev/mapper/system";
    fsType = "btrfs";
    options = [ "subvol=@opt" "compress=zstd" "noatime" ];
  };

  fileSystems."/boot/efi" =
    { device = "/dev/disk/by-partlabel/boot";
      fsType = "vfat";
    };

  # fileSystems."/swap" =
  #   { device = "/dev/mapper/system";
  #     fsType = "btrfs";
  #     options = [ "subvol=@swap" "compress=zstd" "noatime" ];
  #   };

  # systemd.services = {
  #   create-swapfile = {
  #     serviceConfig.Type = "oneshot";
  #     wantedBy = [ "swap-swapfile.swap" ];
  #     script = ''
  #       ${pkgs.coreutils}/bin/truncate -s 0 /swap/swapfile
  #       ${pkgs.e2fsprogs}/bin/chattr +C /swap/swapfile
  #       ${pkgs.btrfs-progs}/bin/btrfs property set /swap/swapfile compression none
  #     '';
  #   };
  # };

  # swapDevices = [{
  #   device = "/swap/swapfile";
  #   size = (1024 * 16) + (1024 * 2); # RAM size + 2 GB
  # }];

  hardware.cpu.amd.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
}
