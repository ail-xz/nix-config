{ pkgs, ... }:
let
  opener = pkgs.writeShellScript "firefox-open-external" ''
    unset MOZ_NO_REMOTE MOZ_LAUNCHED_CHILD MOZ_APP_REMOTINGNAME \
      XRE_PROFILE_PATH XRE_PROFILE_LOCAL_PATH XRE_PROFILE_NAME XRE_START_OFFLINE
    exec /run/current-system/sw/bin/firefox --profile "$1" --new-tab "$2"
  '';
in
{
  programs.firefox = {
    package = pkgs.firefox.override {
      extraAutoConfig = ''pref("general.config.sandbox_enabled", false);'';
    };
    autoConfigFiles = [
      (pkgs.replaceVars ./external-links.js { inherit opener; })
    ];
  };
}
