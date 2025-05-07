# common/home-manager/default.nix
{ vars, pkgs, ... }:
{
  home.stateVersion = "24.11";
  programs.home-manager.enable = true;
  imports = [
    (import ./zsh.nix { inherit pkgs; })
    (import ./git.nix { inherit vars; })
  ];
}
