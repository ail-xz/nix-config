{ config, ... }:
let
  webapps = {
    discord = {
      name = "Discord";
      url = "https://discord.com/app";
      icon = "discord";
      allowedHosts = [
        "discord.com"
        "discordapp.com"
        "discordapp.net"
        "discord.gg"
      ];
    };
    slack = {
      name = "Slack";
      url = "https://app.slack.com/client";
      icon = "slack";
      allowedHosts = [
        "slack.com"
        "slack-edge.com"
        "slack-files.com"
      ];
    };
  };

  # kioskはタブバーも戻るボタンも無いため、新しいタブではなく別ウィンドウで開く。
  # allowedHosts 以外への遷移は mozilla.cfg (nixos/firefox-webapps) が通常プロファイルの Firefox へ回す
  webappSettings = id: {
    "browser.link.open_newwindow" = 2;
    "browser.link.open_newwindow.restriction" = 0;
    "webapps.externalLinks.allowedHosts" = builtins.concatStringsSep "," webapps.${id}.allowedHosts;
    "webapps.externalLinks.profile" = "${config.xdg.configHome}/mozilla/firefox/default";
  };

  mkExec =
    id: app: "firefox --no-remote -P ${id} --class firefox-${id} --kiosk --new-window ${app.url}";
in
{
  programs.firefox = {
    enable = true;
    package = null;
    configPath = "${config.xdg.configHome}/mozilla/firefox";
    profiles = {
      default = {
        id = 0;
        isDefault = true;
      };
      discord = {
        id = 1;
        name = "discord";
        isDefault = false;
        settings = webappSettings "discord";
      };
      slack = {
        id = 2;
        name = "slack";
        isDefault = false;
        settings = webappSettings "slack";
      };
    };
  };

  xdg.desktopEntries = builtins.mapAttrs (id: app: {
    name = "${app.name} (Firefox)";
    genericName = "Web App";
    exec = mkExec id app;
    icon = app.icon;
    categories = [
      "Network"
      "InstantMessaging"
    ];
    terminal = false;
  }) webapps;
}
