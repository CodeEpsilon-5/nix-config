{
  disko.devices = {
    disk = {
      main = {
        type = "disk";
        device = "/dev/disk/by-id/ata-ibridge_ngff_512GB_AA000000000000000093"; 
        content = {
          type = "gpt";
          partitions = {
            ESP = {
              size = "1G";
              type = "EF00";
              content = {
                type = "filesystem";
                format = "vfat";
                mountpoint = "/boot";
                mountOptions = [ "umask=0077" ];
              };
            };
            swap = {
              size = "8G";
              content = {
                type = "swap";
                discardPolicy = "both"; # Ativa TRIM para SSDs na swap
              };
            };
            zfs = {
              size = "100%";
              content = {
                type = "zfs";
                pool = "zroot";
              };
            };
          };
        };
      };
    };
    zpool = {
      zroot = {
        type = "zpool";
        options = {
          ashift = "12";
          autotrim = "on";
        };
        rootFsOptions = {
          canmount = "off";
          compression = "zstd";
          mountpoint = "none";
          normalization = "formD"; 
          acltype = "posixacl";
          xattr = "sa";
        };
        datasets = {
          "local/root" = {
            type = "zfs_fs";
            mountpoint = "/";
            options.mountpoint = "legacy";
            options.atime = "off";
            postCreateHook = "zfs snapshot zroot/local/root@blank";
          };
          "local/nix" = {
            type = "zfs_fs";
            mountpoint = "/nix";
            options.atime = "off";
            options.mountpoint = "legacy";
          };
          "safe/persist" = {
            type = "zfs_fs";
            mountpoint = "/persist";
            options.atime = "off";
            options.mountpoint = "legacy";
          };
        };
      };
    };
  };
  fileSystems."/persist".neededForBoot = true;
}
