{ vars, lib, ... }:
lib.mkIf (vars.defaultShell == "zsh") {
    programs.zsh.enable = true;
}