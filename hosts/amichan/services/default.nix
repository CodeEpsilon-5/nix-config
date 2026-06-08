{ ... }: 
{
    imports = [
        ./impermanence.nix
        ./sops.nix
        ./openssh.nix
        ./newt.nix
        ./docker.nix
        ./mdns.nix
    ];
}