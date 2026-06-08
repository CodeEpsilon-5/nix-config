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
  networking = {
    hostId = "5ecf1629"; 
    hostName = "amichan";
    firewall = {
      allowedTCPPorts = [ ];
      allowedUDPPorts = [ ];
    };
    nameservers = [
      "9.9.9.9"
      "149.112.112.112"
    ];
  };

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
    eza
  ];

  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  nix.extraOptions = ''
    !include /run/secrets/github-token
  '';

  users = {
    mutableUsers = false;
    users.epsilon = {
      isNormalUser = true;
      extraGroups = [ "wheel" ];
      hashedPasswordFile = config.sops.secrets."passwords/epsilon".path;
      openssh.authorizedKeys.keys = [
        "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIOynkENF3FcMTDFbqvwFupS7Y0E9tlAW7ECXsMGpQh/x lucas@CodeEpsilon-5"
      ];
      linger = true;
    };
  };

  environment.shellAliases = {
    vim = "nvim";
    vi = "nvim";
    v = "nvim";
    ls = "eza --color=auto";
    ll = "eza -alh --color=auto";
    la = "eza -A --color=auto";
    l = "eza -CF --color=auto";
    rebuild = "sudo nixos-rebuild switch --flake github:CodeEpsilon-5/nix-config --refresh";
  }

  system.stateVersion = "26.05";
}