{
  description = "Puppy's NixOS Flake";

  nixConfig = {
    # override the default substituters
    substituters = [
      "https://cache.nixos.org"
      "https://nix-community.cachix.org"
    ];
    trusted-public-keys = [
      "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
      "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
    ];
  };

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    sysc-greet = {
      url = "github:Nomadcxx/sysc-greet";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };
  outputs = { self, nixpkgs, sysc-greet, ... }: {
      nixosConfigurations.crate = nixpkgs.lib.nixosSystem {
	  modules = [ 
            ./configuration.nix
            sysc-greet.nixosModules.default
            {
              nix.settings.trusted-users = [ "puppy" ];
            }
          ];
      };
  };
}
