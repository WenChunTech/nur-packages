{
  pkgs,
  ...
}:
{
  fonts.packages = with pkgs; [
    nerd-fonts.fira-code
    nerd-fonts.jetbrains-mono
    maple-mono.NF-unhinted
    maple-mono.NF-CN-unhinted
  ];
}
