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
      DynamicUser = true;
      LoadCredential = "config.json:${config.sops.secrets."configs/newt.json".path}";
      ExecStart = "${pkgs.fosrl-newt}/bin/newt --config-file \${CREDENTIALS_DIRECTORY}/config.json";
      Restart = "always";
      RestartSec = "5";
    };
  };
}