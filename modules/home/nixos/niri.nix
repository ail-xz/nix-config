{
  config,
  lib,
  pkgs,
  ...
}:
let
  cursor = {
    name = "Adwaita";
    size = 18;
  };

  directionKeys = {
    left = [
      "Left"
      "H"
    ];
    down = [
      "Down"
      "J"
    ];
    up = [
      "Up"
      "K"
    ];
    right = [
      "Right"
      "L"
    ];
  };

  directionActions = {
    "Mod+Shift" = {
      left = "move-column-left";
      down = "move-window-down";
      up = "move-window-up";
      right = "move-column-right";
    };
    "Mod+Ctrl" = {
      down = "focus-workspace-down";
      up = "focus-workspace-up";
    };
    "Mod+Shift+Ctrl" = {
      down = "move-column-to-workspace-down";
      up = "move-column-to-workspace-up";
    };
    "Mod+Alt" = lib.genAttrs (lib.attrNames directionKeys) (dir: "focus-monitor-${dir}");
    "Mod+Alt+Shift" = lib.genAttrs (lib.attrNames directionKeys) (dir: "move-column-to-monitor-${dir}");
  };

  directionBinds = lib.listToAttrs (
    lib.concatLists (
      lib.mapAttrsToList (
        mods: actions:
        lib.concatLists (
          lib.mapAttrsToList (
            dir: action: map (key: lib.nameValuePair "${mods}+${key}" { ${action} = { }; }) directionKeys.${dir}
          ) actions
        )
      ) directionActions
    )
  );
in
{
  home.pointerCursor = {
    enable = true;
    inherit (cursor) name size;
    package = pkgs.adwaita-icon-theme;
  };

  dconf.settings."org/gnome/desktop/interface" = {
    cursor-theme = cursor.name;
    cursor-size = cursor.size;
  };

  home.packages = [ pkgs.brightnessctl ];

  wayland.windowManager.niri = {
    enable = true;
    # portal は NixOS 側の programs.niri
    portalPackage = null;
    enableDefaultConfig = true;
    settings = {
      _children = [
        { spawn-at-startup = [ "noctalia" ]; }
        {
          spawn-at-startup = [
            "fcitx5"
            "-d"
          ];
        }
        {
          window-rule = {
            geometry-corner-radius = 12;
            clip-to-geometry = true;
            draw-border-with-background = false;
          };
        }
      ];

      prefer-no-csd = { };

      # noctalia のテーマテンプレートを読み込む
      include = {
        _props.optional = true;
        _args = [ "noctalia.kdl" ];
      };

      layout = {
        gaps = 8;
        focus-ring.width = 1;
      };

      hotkey-overlay.skip-at-startup = { };

      blur.offset = 3.0;

      input = {
        keyboard = {
          numlock = { };
          repeat-delay = 180;
          repeat-rate = 33;
        };
        touchpad = {
          tap = { };
          natural-scroll = { };
          scroll-factor = 0.35;
        };
      };

      cursor = {
        xcursor-theme = cursor.name;
        xcursor-size = cursor.size;
      };

      binds = directionBinds // {
        "Mod+Return" = {
          _props.hotkey-overlay-title = "Open a Terminal: alacritty";
          spawn = [ "alacritty" ];
        };
        "Mod+Backslash" = {
          _props.hotkey-overlay-title = "Open firefox: default";
          spawn = [
            "firefox"
            "--profile"
            "${config.xdg.configHome}/mozilla/firefox/default"
          ];
        };
        "Mod+Shift+Backslash" = {
          _props.hotkey-overlay-title = "Open firefox: Profile 1";
          spawn = [
            "firefox"
            "--profile"
            "${config.xdg.configHome}/mozilla/firefox/POzqMC0L.Profile 1"
          ];
        };
        "Mod+Slash" = {
          _props.hotkey-overlay-title = "Open Files: nemo";
          spawn = [ "nemo" ];
        };
        "Mod+Space" = {
          _props.hotkey-overlay-title = "Run an Application: noctalia";
          spawn = [
            "noctalia"
            "msg"
            "panel-toggle"
            "launcher"
          ];
        };
        "Ctrl+Alt+L" = {
          _props.hotkey-overlay-title = "Lock the Screen: noctalia";
          spawn = [
            "noctalia"
            "msg"
            "session"
            "lock"
          ];
        };
      };
    };
  };
}
