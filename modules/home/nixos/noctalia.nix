{
  config,
  lib,
  pkgs,
  ...
}:
{
  programs.alacritty.settings = {
    general.import = [ "~/.config/alacritty/themes/noctalia.toml" ];
    colors = lib.mkForce { };
  };

  # mozc のトレイアイコンを文字にする
  xdg.configFile."fcitx5/conf/classicui.conf".text = ''
    Theme=noctalia
    PreferTextIcon=True
    TrayTextColor=#c0caf5
    TrayOutlineColor=#1a1b26
  '';
  xdg.dataFile."fcitx5/inputmethod/mozc.conf".text = ''
    [InputMethod]
    Name=Mozc
    Icon=fcitx_mozc
    Label=ja
    LangCode=ja
    Addon=mozc
    Configurable=True
  '';

  home.packages = [
    pkgs.adw-gtk3
    (pkgs.papirus-icon-theme.override { color = "blue"; })
  ];
  dconf.settings."org/gnome/desktop/interface" = {
    gtk-theme = "adw-gtk3-dark";
    icon-theme = "Papirus-Dark";
  };

  programs.nixvim = {
    extraPlugins = [ pkgs.vimPlugins.base16-nvim ];
    extraConfigLuaPost = ''
      local ok, matugen = pcall(require, 'matugen')
      if ok then matugen.setup() end
    '';
  };

  services.tailscale-systray.enable = true;

  programs.btop = {
    enable = true;
    package = null;
    settings.color_theme = "noctalia";
  };

  programs.noctalia = {
    enable = true;
    package = null;
    settings = {
      osd.kinds.keyboard_layout = false;
      nightlight.enabled = true;
      location.auto_locate = true;
      idle = {
        behavior_order = [
          "screen-off"
          "lock"
          "lock-and-suspend"
        ];
        behavior = {
          screen-off = {
            action = "screen_off";
            enabled = true;
            timeout = 120;
          };
          lock = {
            action = "lock";
            enabled = true;
            timeout = 180;
          };
          lock-and-suspend = {
            action = "lock_and_suspend";
            enabled = false;
            timeout = 180;
          };
        };
      };
      lockscreen = {
        transition_duration = 400;
        allow_empty_password = true;
      };
      theme = {
        source = "builtin";
        builtin = "Tokyo-Night";
        mode = "dark";
        wallpaper_scheme = "m3-content";
        templates = {
          builtin_ids = [
            "alacritty"
            "btop"
            "gtk3"
            "gtk4"
            "kcolorscheme"
            "niri"
            "qt"
          ];
          community_ids = [
            "claude-code"
            "neovim"
            "vscode"
            "obs"
            "fcitx5"
          ];
        };
      };
      shell = {
        font_family = "Noto Sans CJK JP";
        screenshot.directory = "${config.home.homeDirectory}/Pictures/Screenshots";
        greeter_sync.auto_sync = true;
        app_icon_color = "primary";
        launcher.compact = true;
        animation.speed = 2.0;
      };
      bar.order = [
        "top"
        "bottom"
      ];
      bar.top = {
        enabled = true;
        thickness = 28;
        margin_edge = 5;
        margin_ends = 5;
        start = [
          "session"
          "settings"
          "wallpaper"
        ];
        center = [
          "temp"
          "cpu"
          "gpu"
          "ram"
        ];
        end = [
          "tray"
          "notifications"
          "nightlight"
          "media"
          "clipboard"
          "network"
          "bluetooth"
          "volume"
          "brightness"
          "battery"
        ];
      };
      bar.bottom = {
        enabled = true;
        position = "bottom";
        thickness = 28;
        margin_edge = 5;
        margin_ends = 5;
        start = [ "workspaces" ];
        center = [ "taskbar" ];
        end = [
          "date"
          "clock"
        ];
      };
      widget = {
        clock = {
          format = "{:%H:%M:%S}";
        };
        date = {
          type = "clock";
          format = "{:%-m/%-d (%a)}";
        };
        media.album_art_only = true;
        brightness.show_label = false;
        network.show_label = false;
        volume = {
          show_label = false;
          mute_color = "on_surface";
        };
        tray.drawer = true;
        spacer.type = "spacer";
        taskbar = {
          icon_scale = 1.5;
          only_active_workspace = true;
          taskbar_max_width = 640;
          inactive_opacity = 0.5;
          show_active_indicator = false;
        };
        gpu = {
          type = "sysmon";
          stat = "gpu_usage";
        };
      };
    };
  };
}
