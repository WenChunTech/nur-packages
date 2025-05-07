{
  description = "My personal NUR repository and NixOS/Darwin configurations";

  nixConfig = {
    substituters = [
      "https://mirrors.ustc.edu.cn/nix-channels/store"
      "https://cache.nixos.org"
    ];
  };

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    nix-darwin.url = "github:nix-darwin/nix-darwin/master";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nix-homebrew.url = "github:zhaofengli-wip/nix-homebrew";
    # Optional: Declarative tap management
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
      # Define system architectures. User should verify/update these as needed.
      # "MacBookPro" is assumed to be aarch64-darwin.
      # "NixOS" is a placeholder for a NixOS host, assumed x86_64-linux.
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
              users.${vars.user} = { pkgs, ... }: import ./common/home-manager/default.nix { inherit vars pkgs; };
            };
          }
        ];
      };

      nixosConfigurations."NixOS" = nixpkgs.lib.nixosSystem {
        system = vars.nixosSystemArch;
        specialArgs = {
          inherit inputs vars;
          hostName = "NixOS";
        };
        modules = [
          ./hosts/nixos/default.nix
          home-manager.nixosModules.home-manager
        ];
      };

      # Expose the common library from common/lib/default.nix
      lib = import ./common/lib/default.nix;

      # legacyPackages and packages that relied on a root ./default.nix have been removed.
      # Users can define overlays or specific packages to be exposed by the flake here if needed.
      # Example for overlays:
      # overlays.default = import ./overlays/default.nix;
      # Example for packages:
      # packages.${darwinSystemArch}.myTool = inputs.nixpkgs.legacyPackages.${darwinSystemArch}.callPackage ./pkgs/my-tool {};
    };
}
