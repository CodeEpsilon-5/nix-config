{ pkgs, lib, config, ... }: {

  imports = [
    ./disko-config.nix
    ./hardware-configuration.nix
  ];

  # Configurações Essenciais de Boot e ZFS
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.supportedFilesystems = [ "zfs" ];
  boot.zfs.forceImportRoot = true;

  # O ZFS exige um HostID único de 8 caracteres hexadecimais
  networking.hostId = "5ecf1629"; 
  networking.hostName = "amichan";
  networking.firewall.allowedTCPPorts = [ 22 ];

  environment.systemPackages = with pkgs; [
    neovim
    git
    curl
    wget
    btop
    zfs
    bat
    fzf
    ripgrep
    fd
  ];

  users = {
    mutableUsers = false;
    users.epsilon = {
      isNormalUser = true;
      extraGroups = [ "wheel" "docker" ];
      hashedPasswordFile = config.sops.secrets."passwords/epsilon".path;
      openssh.authorizedKeys.keys = [
        "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIOynkENF3FcMTDFbqvwFupS7Y0E9tlAW7ECXsMGpQh/x lucas@CodeEpsilon-5"
      ];
    };
  };

  system.stateVersion = "26.05";
}