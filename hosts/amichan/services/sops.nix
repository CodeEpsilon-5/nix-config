{ config, inputs, ... }:

{
    sops.defaultSopsFile = "${inputs.nix-secrets.outPath}/secrets.yaml";
    sops.age.sshKeyPaths = [ 
        "/persist/etc/ssh/ssh_host_ed25519_key" 
    ];

    sops.secrets = {
        "passwords/epsilon" = {
            neededForUsers = true;
        };
        "configs/newt.json" = {};
        "configs/newt.env" = {};
    };
}