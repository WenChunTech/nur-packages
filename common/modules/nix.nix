# common/modules/nix.nix
{
  vars,
  self,
  pkgs,
  ...
}:

{
  system.configurationRevision = self.rev or self.dirtyRev or null;

  # Necessary for using flakes on this system.
  nix.settings = {
    # enable flakes globally
    experimental-features = [
      "nix-command"
      "flakes"
    ];
    substituters = [
      "https://mirror.sjtu.edu.cn/nix-channels/store"
      "https://nix-community.cachix.org"
    ];
    trusted-public-keys = [
      "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
    ];

    trusted-users = [
      "root"
      "${vars.user}"
    ];
    trusted-substituters = [
      "https://mirror.sjtu.edu.cn/nix-channels/store"
      "https://nix-community.cachix.org"
    ];
    builders-use-substitutes = true;
  };

  nix.package = pkgs.nix;
  nixpkgs.config.allowUnfree = true;
}
