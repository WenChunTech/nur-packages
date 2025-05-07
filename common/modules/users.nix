# common/modules/users.nix
{
  vars,
  ...
}:
{
  users.users = {
    ${vars.user} = {
      name = "${vars.user}";
      home = "${vars.userHome}";
      # isNormalUser = true;
      # extraGroups = [ "wheel" ];
    };
  };
}
