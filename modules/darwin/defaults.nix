{ config, ... }:
{
  system.defaults = {
    hitoolbox.AppleFnUsageType = "Do Nothing";
    ".GlobalPreferences"."com.apple.mouse.scaling" = -1.0;
    NSGlobalDomain = {
      AppleInterfaceStyle = "Dark";
      AppleIconAppearanceTheme = "RegularDark";
      AppleShowAllExtensions = true;
      ApplePressAndHoldEnabled = false;
      InitialKeyRepeat = 12;
      KeyRepeat = 2;
      "com.apple.trackpad.scaling" = 2.0;
    };
    dock = {
      tilesize = 42;
      show-recents = false;
      mru-spaces = false;
      wvous-br-corner = 1;
    };
    WindowManager = {
      EnableStandardClickToShowDesktop = false;
      EnableTilingByEdgeDrag = false;
      EnableTopTilingByEdgeDrag = false;
      EnableTilingOptionAccelerator = false;
      EnableTiledWindowMargins = false;
    };
    finder = {
      AppleShowAllFiles = true;
      ShowPathbar = true;
      _FXSortFoldersFirst = true;
      _FXShowPosixPathInTitle = true;
      FXEnableExtensionChangeWarning = false;
      FXDefaultSearchScope = "SCcf";
      FXPreferredViewStyle = "Nlsv";
      NewWindowTarget = "Other";
      NewWindowTargetPath = "file:///Users/${config.my.primaryUser}/Downloads/";
    };
    screencapture = {
      type = "png";
      disable-shadow = true;
      location = "~/Pictures/Screenshots";
    };
    menuExtraClock = {
      ShowDate = 1;
      ShowSeconds = true;
    };
    CustomUserPreferences = {
      "com.apple.CrashReporter".DialogType = "none";
      "com.apple.screencapture".name = "";
      "com.apple.desktopservices" = {
        DSDontWriteNetworkStores = true;
        DSDontWriteUSBStores = true;
      };
    };
  };
}
