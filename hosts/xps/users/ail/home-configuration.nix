{ flake, ... }:
let
  scale = 1.6;
in
{
  imports = [
    flake.homeModules.shared
    flake.homeModules.nixos
  ];

  wayland.windowManager.niri.settings._children = [
    {
      output = {
        _args = [ "LG Display 0x0804 Unknown" ];
        mode = "2560x1600@120.002";
        inherit scale;
      };
    }
  ];

  # tkinter は Tk() 作成時に読み込む。X11 経由では niri の scale が効かないため
  home.file.".Tk.tcl".text = ''
    tk scaling [expr {${toString scale} * 96 / 72.0}]
    # X11 の既定フォントはピクセル指定で拡大されないため、ポイント指定に直す
    foreach f [font names] {
        set s [font configure $f -size]
        if {$s < 0} { font configure $f -size [expr {round(-$s * 72 / 96.0)}] }
    }
  '';

  home.stateVersion = "24.11";
}
