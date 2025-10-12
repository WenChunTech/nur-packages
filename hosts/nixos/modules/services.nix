{
      # Configure keymap in X11
  services.xserver.xkb = {
    layout = "cn";
    variant = "";
  };

  services.openssh.enable = true;
}