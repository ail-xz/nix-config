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
    (vscode.override { commandLineArgs = chromiumArgs; })
    termius
    obs-studio
    bitwarden-desktop
    yubioath-flutter
    nemo-with-extensions
    gnome-disk-utility
    file-roller
    unar
    tio
  ];

  programs.zathura = {
    enable = true;
    package =
      (pkgs.zathura.override {
        zathura_core = pkgs.zathuraPkgs.zathura_core.overrideAttrs (old: {
          patches = (old.patches or [ ]) ++ [ ./zathura-hires-wheel.patch ];
        });
      }).overrideAttrs
        (old: {
          # プラグインごとの desktop を 1 つにまとめ、画像や zip には関連付けない
          buildCommand = old.buildCommand + ''
            rm $out/share/applications/org.pwmt.zathura-*.desktop
            desktop=$out/share/applications/org.pwmt.zathura.desktop
            src=$(readlink -f $desktop)
            rm $desktop
            {
              cat $src
              echo "MimeType=application/pdf;application/oxps;application/epub+zip;application/x-fictionbook;application/x-mobipocket-ebook;application/postscript;application/eps;application/x-eps;image/eps;image/x-eps;image/vnd.djvu;image/vnd.djvu+multipage;application/x-cbr;application/x-cbz;application/x-cb7;application/x-cbt;"
            } > $desktop
          '';
        });
    options = {
      guioptions = "";
      selection-clipboard = "clipboard";
    };
  };

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
