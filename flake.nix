{
  description = "NixOS 26.05 com ZFS Impermanence e Disko Flake Setup";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-26.05";
    
    disko = {
      url = "github:nix-community/disko";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    impermanence.url = "github:nix-community/impermanence";

    sops-nix.url = "github:Mic92/sops-nix";

    nix-secrets = {
      url = "git+ssh://git@github.com/CodeEpsilon-5/nix-secrets?ref=simple";
      inputs = { };
    };
  };

  outputs = { self, nixpkgs, disko, impermanence, sops-nix, nix-secrets, ... }@inputs: {
    nixosConfigurations.amichan = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      specialArgs = { inherit inputs; };
      modules = [
        sops-nix.nixosModules.sops
        disko.nixosModules.disko
        impermanence.nixosModules.impermanence
        ./hosts/amichan
      ];
    };
  };
}
