{ ... }: 
{
    imports = [
        ./impermanence.nix
        ./sops.nix
        ./openssh.nix
        ./newt.nix
        ./docker.nix
        ./resolved.nix
    ];
}