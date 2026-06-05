{ pkgs, config, ... }: {
  environment.systemPackages = with pkgs; [
    fosrl-newt
  ];

  systemd.services.newt-tunnel = {
    description = "Newt Tunnel Client";
    after = [ "network-online.target" ];
    wants = [ "network-online.target" ];
    wantedBy = [ "multi-user.target" ];

    serviceConfig = {
      ExecStart = "${pkgs.fosrl-newt}/bin/newt --config-file ${config.sops.secrets."configs/newt.json".path}";
      Restart = "always";
      RestartSec = "5";
      DynamicUser = true;
    };
  };
}