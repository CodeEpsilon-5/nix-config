{ config, pkgs, ... }:

{
  services.gitolite = {
    enable = true;
    adminPubkey = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIOynkENF3FcMTDFbqvwFupS7Y0E9tlAW7ECXsMGpQh/x lucas@CodeEpsilon-5";
    user = "git";
    group = "git";
    dataDir = "/var/lib/gitolite";
  };

  environment.persistance."/persist" = {
    hideMounts = true;
    directories = [
      "/var/lib/gitolite"
    ];
  };
}