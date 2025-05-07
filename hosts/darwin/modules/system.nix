{
  security.pam.services.sudo_local.touchIdAuth = true;
  system = {
    stateVersion = 5;
    activationScripts.postUserActivation.text = ''
      # activateSettings -u will reload the settings from the database and apply them to the current session,
      # so we do not need to logout and login again to make the changes take effect.
      /System/Library/PrivateFrameworks/SystemAdministration.framework/Resources/activateSettings -u
    '';
    defaults = {
      trackpad.Clicking = true;
      trackpad.TrackpadRightClick = true;
      trackpad.Dragging = true;
      trackpad.TrackpadThreeFingerDrag = true;

      NSGlobalDomain.AppleShowAllFiles = true;
      NSGlobalDomain.AppleShowAllExtensions = true;
      NSGlobalDomain.AppleInterfaceStyleSwitchesAutomatically = true;
      NSGlobalDomain.NSAutomaticCapitalizationEnabled = false;
      NSGlobalDomain.NSDocumentSaveNewDocumentsToCloud = false;
      NSGlobalDomain.InitialKeyRepeat = 15;
      NSGlobalDomain.KeyRepeat = 3;
      NSGlobalDomain.NSAutomaticDashSubstitutionEnabled = false; # disable auto dash substitution(智能破折号替换)
      NSGlobalDomain.NSAutomaticPeriodSubstitutionEnabled = false; # disable auto period substitution(智能句号替换)
      NSGlobalDomain.NSAutomaticQuoteSubstitutionEnabled = false; # disable auto quote substitution(智能引号替换)
      NSGlobalDomain.NSAutomaticSpellingCorrectionEnabled = false; # disable auto spelling correction(自动拼写检查)
      NSGlobalDomain.NSNavPanelExpandedStateForSaveMode = true; # expand save panel by default(保存文件时的路径选择/文件名输入页)
      NSGlobalDomain.NSNavPanelExpandedStateForSaveMode2 = true;

      dock.minimize-to-application = true;
      dock.autohide = true;

      screencapture.location = "~/Pictures/Screenshots";

      finder._FXShowPosixPathInTitle = true;
      finder.AppleShowAllExtensions = true;
      finder.FXEnableExtensionChangeWarning = false;
      finder.AppleShowAllFiles = true;
      finder.ShowStatusBar = true;
      finder.ShowPathbar = true;
      finder.FXDefaultSearchScope = "SCcf";
      finder.FXPreferredViewStyle = "Nlsv";
      finder.QuitMenuItem = true;
    };

    keyboard.enableKeyMapping = true;
    # keyboard.remapCapsLockToControl = true;
  };
}
