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
    obs-studio
    bitwarden-desktop
    yubioath-flutter
    nemo-with-extensions
    gnome-disk-utility
    file-roller
    unar
  ];

  dconf.settings = {
    "org/nemo/preferences".default-folder-viewer = "list-view";
    "org/cinnamon/desktop/applications/terminal" = {
      exec = "alacritty";
      exec-arg = "";
    };
  };

  xdg.dataFile."nemo/actions/unar.nemo_action".text = ''
    [Nemo Action]
    Active=true
    Name=Extract here with unar
    Comment=Extract with unar, auto-detecting the filename encoding
    Exec=unar -q -o "%P" %F
    Selection=notnone
    Extensions=zip;
    Quote=double
    Dependencies=unar;
    Icon-Name=package-x-generic
  '';
}
