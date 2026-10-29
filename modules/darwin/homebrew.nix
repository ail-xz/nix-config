{
  homebrew = {
    enable = true;
    enableZshIntegration = true;

    casks = [
      "chatgpt"
      "claude"
      "google-gemini"
      "lm-studio"

      "rio"
      "ghostty"
      "termius"
      "coteditor"
      "visual-studio-code"

      "finicky"
      "brave-browser"
      "google-chrome"
      "microsoft-edge"

      "discord"
      "discord@ptb"
      "discord@canary"
      "discord@development"
      "vesktop"
      "slack"
      "zoom"
      "nani"

      "spotify"

      "microsoft-office"

      "adguard-vpn"
      "bitwarden"
      "ente-auth"
      "localsend"
      "tailscale-app"
      "wireshark-app"
      "yubico-authenticator"

      "macusb"
      "raspberry-pi-imager"
      "android-platform-tools"
      "altserver"

      "lunar-client"
      "modrinth"

      "obs"

      "pictogram"
      "appcleaner"
      "keyboardcleantool"
      "mx-power-gadget"

      "azookey"
      "alt-tab"
      "linearmouse"
      "karabiner-elements"
      "betterdisplay"
      "bettertouchtool"
      "finetune"
      "miclock"
      "snapzy"
      "stats"
      "keka"
      "kekaexternalhelper"
    ];

    masApps = {
      # "LINE" = 539883307;
      # "BetterSnapTool" = 417375580;
      # "AmorphousDiskMark" = 1168254295;
      # "Blackmagic Disk Speed Test" = 425264550;
      # "Speedtest" = 1153157709;
    };

    brews = [
      "macpow"
      "iproute2mac"
      "rustnet"
      "tftp-now"
      "container"
      "container-compose"
    ];

    taps = [
      {
        name = "k06a/tap";
        trusted = true;
      }
      {
        name = "wantbefree/tap";
        trusted = true;
      }
    ];

    onActivation = {
      cleanup = "zap";
      # autoUpdate = true;
      # upgrade = true;
    };
  };
}
