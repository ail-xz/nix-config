{ pkgs, ... }:
let
  chromiumArgs = "--enable-features=WaylandUnscaledTouchpadScrolling:scroll_scaling_factor/1.0 --disable-smooth-scrolling";
in
{
  imports = [
    ./niri.nix
    ./noctalia.nix
    ./webapps.nix
  ];

  home.packages = with pkgs; [
    (google-chrome.override { commandLineArgs = chromiumArgs; })
    (microsoft-edge.override { commandLineArgs = chromiumArgs; })
    termius
    vscode
    bitwarden-desktop
    yubioath-flutter
    onlyoffice-desktopeditors
    obs-studio
    nemo
  ];
}
