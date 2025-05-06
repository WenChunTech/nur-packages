{
  pkgs,
  ...
}:
{
  # this is internal compatibility configuration for home-manager,
  # don't change this!
  home.stateVersion = "24.11";
  # Let home-manager install and manage itself.
  programs.home-manager.enable = true;

  home.packages = with pkgs; [
    go
    rustup
    aria2
  ];

  home.sessionPath = [
    "/Users/fwc/Library/Python/3.9/bin"
    "/Users/fwc/go/bin"
    "/Users/fwc/.local/bin"
    "/Users/fwc/.deno/bin"
  ];

  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;
    historySubstringSearch.enable = true;
    # oh-my-zsh = {
    #   enable = true;
    #   theme = "rkj-repos"; # powerlevel10k xiong-chiamiov
    # };
    initContent = ''
      # The powerlevel theme I'm using is distgusting in TTY, let's default
      # to something else
      # See https://github.com/romkatv/powerlevel10k/issues/325
      # Instead of sourcing this file you could also add another plugin as
      # this, and it will automatically load the file for us
      # (but this way it is not possible to conditionally load a file)
      # {
      #   name = "powerlevel10k-config";
      #   src = lib.cleanSource ./p10k-config;
      #   file = "p10k.zsh";
      # }
      if zmodload zsh/terminfo && (( terminfo[colors] >= 256 )); then
        [[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
      else
        [[ ! -f ~/.p10k_tty.zsh ]] || source ~/.p10k_tty.zsh
      fi
    '';
    plugins = [
      {
        # A prompt will appear the first time to configure it properly
        # make sure to select MesloLGS NF as the font in Konsole
        name = "powerlevel10k";
        src = pkgs.zsh-powerlevel10k;
        file = "share/zsh-powerlevel10k/powerlevel10k.zsh-theme";
      }
    ];

    shellAliases = {
      grep = "grep --binary-files=without-match";
      ll = "ls -al";
      switch = "darwin-rebuild switch --flake ~/.config/nix";
    };

    sessionVariables = {
      RUSTUP_DIST_SERVER = "https://rsproxy.cn";
      RUSTUP_UPDATE_ROOT = "https://rsproxy.cn/rustup";
      HOMEBREW_API_DOMAIN = "https://mirrors.tuna.tsinghua.edu.cn/homebrew-bottles/api";
      HOMEBREW_BOTTLE_DOMAIN = "https://mirrors.tuna.tsinghua.edu.cn/homebrew-bottles";
      HOMEBREW_BREW_GIT_REMOTE = "https://mirrors.tuna.tsinghua.edu.cn/git/homebrew/brew.git";
      HOMEBREW_CORE_GIT_REMOTE = "https://mirrors.tuna.tsinghua.edu.cn/git/homebrew/homebrew-core.git";
      HOMEBREW_PIP_INDEX_URL = "https://pypi.tuna.tsinghua.edu.cn/simple";
      ANDROID_HOME = "/Users/fwc/Library/Android/sdk";
      BUN_INSTALL = "$HOME/.bun";
      PATH = "$BUN_INSTALL/bin:$ANDROID_HOME/tools:$ANDROID_HOME/tools/bin:$ANDROID_HOME/platform-tools:$PATH";
    };
  };

  programs.git = {
    enable = true;
    userName = "fwc";
    userEmail = "1643806656@qq.com";
    ignores = [ ".DS_Store" ];
    extraConfig = {
      init.defaultBranch = "master";
      push.autoSetupRemote = true;
    };
  };
}
