{ ... }:
{
  services.openssh = {
    enable = true;
    settings = {
      PasswordAuthentication = true;
      PermitRootLogin = "prohibit-password";
    };
  };

  networking.firewall.allowedTCPPorts = [ 22 ];
}