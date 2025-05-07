{
  vars,
  ...
}:
{
  programs.git = {
    enable = true;
    userName = "${vars.user}";
    userEmail = "${vars.userEmail}";
    ignores = [ ".DS_Store" ];
    extraConfig = {
      init.defaultBranch = "master";
      push.autoSetupRemote = true;
    };
  };

}
