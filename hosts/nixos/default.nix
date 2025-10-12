{ config, lib, pkgs, vars, self, ... }:
{
  imports = [
    ../../common/modules/fonts.nix
    ../../common/modules/nix.nix
    ./modules/hardware-configuration.nix
    ./modules/services.nix
    ./modules/shell.nix
    ./modules/system.nix
    ./modules/users.nix
  ];

  nixpkgs.hostPlatform = "${vars.nixosSystemArch}";
}
