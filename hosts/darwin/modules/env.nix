{
  vars,
  ...
}:
{
  home-manager.users.${vars.user} = {
    home.sessionPath = [
      "/Users/fwc/go/bin"
      "/Users/fwc/.bun/bin"
      "/Users/fwc/.deno/bin"
      "/Users/fwc/.local/bin"
      "/Users/fwc/Library/Python/3.9/bin"
    ];

    programs.zsh = {
      sessionVariables = {
        HOMEBREW_API_DOMAIN = "https://mirrors.tuna.tsinghua.edu.cn/homebrew-bottles/api";
        HOMEBREW_BOTTLE_DOMAIN = "https://mirrors.tuna.tsinghua.edu.cn/homebrew-bottles";
        HOMEBREW_BREW_GIT_REMOTE = "https://mirrors.tuna.tsinghua.edu.cn/git/homebrew/brew.git";
        HOMEBREW_CORE_GIT_REMOTE = "https://mirrors.tuna.tsinghua.edu.cn/git/homebrew/homebrew-core.git";
        HOMEBREW_PIP_INDEX_URL = "https://pypi.tuna.tsinghua.edu.cn/simple";
        ANDROID_HOME = "/Users/fwc/Library/Android/sdk";
        PATH = "$ANDROID_HOME/tools:$ANDROID_HOME/tools/bin:$ANDROID_HOME/platform-tools:$PATH";
      };
    };
  };
}
