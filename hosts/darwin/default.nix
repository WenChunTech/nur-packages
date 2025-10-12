{ vars, ... }:
{
  imports = [
    ../../common/modules/nix.nix
    ../../common/modules/fonts.nix
    ./modules/env.nix
    ./modules/homebrew.nix
    ./modules/system.nix
    ./modules/users.nix
  ];

  nixpkgs.hostPlatform = "${vars.darwinSystemArch}";
}
