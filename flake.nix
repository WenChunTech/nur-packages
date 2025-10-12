{
  description = "My personal NUR repository and NixOS/Darwin configurations";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    nix-darwin.url = "github:LnL7/nix-darwin/master";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nix-homebrew.url = "github:zhaofengli/nix-homebrew";
    homebrew-core = {
      url = "github:homebrew/homebrew-core";
      flake = false;
    };
    homebrew-cask = {
      url = "github:homebrew/homebrew-cask";
      flake = false;
    };
    homebrew-bundle = {
      url = "github:homebrew/homebrew-bundle";
      flake = false;
    };
  };

  outputs =
    {
      self,
      nix-darwin,
      nixpkgs,
      home-manager,
      nix-homebrew,
      homebrew-core,
      homebrew-cask,
      homebrew-bundle,
      ...
    }@inputs:
    let
      vars = {
        user = "fwc";
        userEmail = "1643806656@qq.com";
        userHome = "/Users/${vars.user}";
        defaultShell = "zsh";
        darwinSystemArch = "aarch64-darwin";
        nixosSystemArch = "x86_64-linux";
      };
      systems = [
        "i686-linux"
        "x86_64-linux"
        "aarch64-linux"
        "x86_64-darwin"
        "aarch64-darwin"
      ];
      forAllSystems = f: nixpkgs.lib.genAttrs systems (system: f system);
    in
    {
      legacyPackages = forAllSystems (
        system:
        import ./default.nix {
          pkgs = import nixpkgs { inherit system; };
        }
      );
      packages = forAllSystems (
        system: nixpkgs.lib.filterAttrs (_: v: nixpkgs.lib.isDerivation v) self.legacyPackages.${system}
      );

      darwinConfigurations."MacBookPro" = nix-darwin.lib.darwinSystem {
        system = vars.darwinSystemArch;
        specialArgs = {
          inherit inputs vars self;
        };
        modules = [
          ./hosts/darwin/default.nix
          home-manager.darwinModules.home-manager
          {
            home-manager = {
              useGlobalPkgs = true;
              useUserPackages = true;
              verbose = true;
              extraSpecialArgs = { inherit vars inputs self; };
              users.${vars.user} = import ./common/home-manager/default.nix;
            };
          }
          nix-homebrew.darwinModules.nix-homebrew
          {
            nix-homebrew = {
              enable = true;
              enableRosetta = true;
              user = "${vars.user}";
              taps = {
                "homebrew/homebrew-core" = homebrew-core;
                "homebrew/homebrew-cask" = homebrew-cask;
                "homebrew/homebrew-bundle" = homebrew-bundle;
              };
              mutableTaps = false;
            };
          }
        ];
      };

      nixosConfigurations."NixOS" = nixpkgs.lib.nixosSystem {
        system = vars.nixosSystemArch;
        specialArgs = {
          inherit inputs vars self;
          hostName = "NixOS";
        };
        modules = [
          ./hosts/nixos/default.nix
          home-manager.nixosModules.home-manager
          {
            home-manager = {
              useGlobalPkgs = true;
              useUserPackages = true;
              extraSpecialArgs = { inherit vars inputs self; };
              users.${vars.user} = import ./common/home-manager/default.nix;
            };
          }
        ];
      };
    };
}
