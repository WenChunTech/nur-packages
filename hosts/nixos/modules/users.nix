{ config, lib, pkgs, vars, ... }:
{
  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.${vars.user} = {
    isNormalUser = true;
    description = "this is the system user";
    extraGroups = [ "networkmanager" "wheel" ];
    shell = pkgs.${vars.defaultShell};
    packages = with pkgs; [
    ];
  };
}