{
  description = "nix-darwin system flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-24.11-darwin";
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    nix-darwin.url = "github:LnL7/nix-darwin";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";
    home-manager.url = "github:nix-community/home-manager/release-24.11";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = inputs@{ self, nixpkgs, nixpkgs-unstable, nix-darwin, home-manager, ... }:
  let
    overlays = [
      (import ./overlays/local.nix)
      (import ./overlays/override.nix)
    ];
    username = "smancill";
  in
  {
    darwinConfigurations.macbook-pro-intel = nix-darwin.lib.darwinSystem {
      system = "x86_64-darwin";
      modules = [
        ./darwin.nix
        home-manager.darwinModules.home-manager {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.users.${username} = import ./home;
          home-manager.extraSpecialArgs = {
            unstable = import nixpkgs-unstable {
              system = "x86_64-darwin";
              overlays = [ (import ./overlays/unstable.nix) ];
            };
          };
        }
        ({
          nixpkgs.overlays = overlays;
          nixpkgs.config = { allowUnfree = true; };
        })
      ];
      specialArgs = {
        inherit inputs username;
        hostname = "tatooine";
      };
    };
  };
}
