{ pkgs, config, ... }: {
  services.newt = {
    enable = true;
    package = pkgs.newt;
    environmentFile = config.sops.secrets."configs/newt.env".path;
  };
}