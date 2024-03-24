{
  description = "Your new nix config";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-23.11";

    home-manager = {
      url = "github:nix-community/home-manager/release-23.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    hardware.url = "github:nixos/nixos-hardware";
  };

  outputs =
    { self
    , nixpkgs
    , hardware
    , home-manager
    , ...
    } @ inputs:
    let
      inherit (self) outputs;
      system = "x86_64-linux";
    in
    {
      # Available through 'nixos-rebuild --flake .#your-hostname'
      nixosConfigurations = {
        framework = nixpkgs.lib.nixosSystem {
          specialArgs = { inherit inputs outputs; };
          modules = [ ./nixos/configuration.nix hardware.nixosModules.framework-13-7040-amd ];
        };
      };

      # Available through 'home-manager --flake .#your-username@your-hostname'
      homeConfigurations = {
        "david@framework" = home-manager.lib.homeManagerConfiguration {
          pkgs = nixpkgs.legacyPackages.${system};
          extraSpecialArgs = { inherit inputs outputs; };
          modules = [ ./home-manager/home.nix ];
        };
      };
    };
}
