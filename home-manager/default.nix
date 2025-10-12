# common/home-manager/default.nix
{
  vars,
  pkgs,
  inputs,
  self,
  ...
}:
{
  home.stateVersion = "24.11";
  programs.home-manager.enable = true;
  imports = [
    ./git.nix
    ./pkg.nix
    ./static.nix
    ./zsh.nix
  ];
}
