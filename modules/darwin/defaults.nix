{ config, ... }:
{
  system.defaults = {
    hitoolbox.AppleFnUsageType = "Do Nothing";
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
      persistent-apps = [
        "/Applications/Google Chrome.app"
        "/Applications/Microsoft Edge.app"
        "/Applications/Microsoft Outlook.app"
        "/Applications/vesktop.app"
        "/Applications/Slack.app"
        "/Applications/Ghostty.app"
        "/Applications/Termius.app"
        "/Applications/Nani.app"
        "/Applications/Claude.app"
        "/Applications/ChatGPT.app"
        "/Applications/Modrinth App.app"
        "/Applications/CotEditor.app"
        "/Applications/Visual Studio Code.app"
        "/Applications/Spotify.app"
        "/System/Applications/Messages.app"
        "/System/Applications/Phone.app"
        "/Applications/Bitwarden.app"
        "/Applications/Ente Auth.app"
        "/Applications/LocalSend.app"
        "/System/Applications/Utilities/Activity Monitor.app"
        "/System/Applications/System Settings.app"
        "/Applications/FineTune.app"
      ];
      persistent-others = [ ];
    };
    trackpad = {
      FirstClickThreshold = 0;
      SecondClickThreshold = 0;
      ActuationStrength = 0;
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
    controlcenter.BatteryShowPercentage = true;
    CustomUserPreferences = {
      NSGlobalDomain = {
        TSMLanguageIndicatorEnabled = false;
        NSGlassTintAmount = 0.5;
        "com.apple.mouse.linear" = true;
        "com.apple.trackpad.scrolling" = 0.3125;
      };
      "com.apple.dock".enterMissionControlByTopWindowDrag = false;
      "com.apple.controlcenter" = {
        "NSStatusItem VisibleCC AirDrop" = true;
        "NSStatusItem VisibleCC Battery" = true;
        "NSStatusItem VisibleCC BentoBox-0" = true;
        "NSStatusItem VisibleCC Bluetooth" = true;
        "NSStatusItem VisibleCC Clock" = true;
        "NSStatusItem VisibleCC Display" = true;
        "NSStatusItem VisibleCC FocusModes" = true;
        "NSStatusItem VisibleCC KeyboardBrightness" = true;
        "NSStatusItem VisibleCC Sound" = true;
        "NSStatusItem VisibleCC UserSwitcher" = true;
        "NSStatusItem VisibleCC WiFi" = true;
      };
      "com.apple.Spotlight" = {
        PasteboardHistoryEnabled = true;
        PasteboardHistoryTimeout = 604800;
      };
      "com.apple.CrashReporter".DialogType = "none";
      "com.apple.screencapture".name = "";
      "com.apple.desktopservices" = {
        DSDontWriteNetworkStores = true;
        DSDontWriteUSBStores = true;
      };
    };
  };
}
