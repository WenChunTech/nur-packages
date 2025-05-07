{ vars, ... }:
{
  imports = [
    ../../common/modules/users.nix
    ../../common/modules/nix.nix
    ../../common/modules/fonts.nix
    ./modules/system.nix
    ./modules/homebrew.nix
  ];

  nixpkgs.hostPlatform = "${vars.darwinSystemArch}";
}
