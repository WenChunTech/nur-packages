{ inputs, ... }:

inputs.nix-darwin.lib.darwinSystem {
  specialArgs = inputs; # 传递所有 flake inputs
  modules = [
    # 核心系统配置
    ./modules/core.nix
    ./modules/system.nix
    ./modules/homebrew.nix # 这个在原始 flake.nix 中是一个顶层模块

    # Home Manager 配置
    inputs.home-manager.darwinModules.home-manager
    {
      home-manager.useGlobalPkgs = true;
      home-manager.useUserPackages = true;
      home-manager.verbose = true;
      # home.nix 的导入路径需要相对于这个新的 default.nix
      home-manager.users.fwc = import ./modules/home.nix;
    }

    # Nix-Homebrew 配置
    inputs.nix-homebrew.darwinModules.nix-homebrew
    {
      nix-homebrew = {
        enable = true;
        enableRosetta = false; # 根据原始 flake
        user = "fwc"; # 根据原始 flake
        taps = {
          "homebrew/homebrew-core" = inputs.homebrew-core;
          "homebrew/homebrew-cask" = inputs.homebrew-cask;
          "homebrew/homebrew-bundle" = inputs.homebrew-bundle;
        };
        mutableTaps = false; # 根据原始 flake
      };
    }
  ];
}
