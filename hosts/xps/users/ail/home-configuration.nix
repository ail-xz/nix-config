{ flake, ... }:
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
        scale = 1.6;
      };
    }
  ];

  home.stateVersion = "24.11";
}
