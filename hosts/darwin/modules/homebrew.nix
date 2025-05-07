{
  homebrew = {
    enable = true;

    onActivation = {
      autoUpdate = true;
      upgrade = false;
      # 'zap': uninstalls all formulae(and related files) not listed here.
      # cleanup = "zap";
    };

    taps = [ ];

    # brew install
    brews = [ ];
    # brew install --cask
    # these need to be updated manually
    casks = [
      "raycast"
      "warp"
      "obsidian"
    ];

    # mac app store
    # click
    masApps = { };
  };
}
