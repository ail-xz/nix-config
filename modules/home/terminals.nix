{
  lib,
  pkgs,
  ...
}:
let
  isDarwin = pkgs.stdenv.hostPlatform.isDarwin;
  terminalFont = "UDEV Gothic 35NF";

  # Brogrammer
  palette = {
    background = "#131313";
    foreground = "#d6dbe5";
    cursor = "#b9b9b9";
    cursorText = "#101010";
    selectionBackground = "#5a647e";
    selectionForeground = "#e6e1dc";
    normal = {
      black = "#000000";
      red = "#f81118";
      green = "#2dc55e";
      yellow = "#ecba0f";
      blue = "#2a84d2";
      magenta = "#4e5ab7";
      cyan = "#1081d6";
      white = "#d6dbe5";
    };
    bright = {
      black = "#585858";
      red = "#de352e";
      green = "#1dd361";
      yellow = "#f3bd09";
      blue = "#1081d6";
      magenta = "#5350b9";
      cyan = "#0f7ddb";
      white = "#ffffff";
    };
  };

  ansiNames = [
    "black"
    "red"
    "green"
    "yellow"
    "blue"
    "magenta"
    "cyan"
    "white"
  ];
  ghosttyPalette =
    lib.imap0 (i: name: "${toString i}=${palette.normal.${name}}") ansiNames
    ++ lib.imap0 (i: name: "${toString (i + 8)}=${palette.bright.${name}}") ansiNames;
in
{
  programs.ghostty = {
    enable = true;
    package = if isDarwin then null else pkgs.ghostty;
    settings = {
      title = "Ghostty";
      theme = "Brogrammer";
      font-size = 10;
      font-family = terminalFont;
      font-thicken = false;
      background-opacity = 0.9;
      background-blur = 20;
      window-height = 35;
      window-width = 125;
      window-padding-x = 10;
      window-padding-y = 10;
      term = "xterm-256color";
    }
    // lib.optionalAttrs isDarwin {
      macos-icon = "custom-style";
      macos-icon-frame = "plastic";
      macos-icon-ghost-color = "60A5FA";
      macos-icon-screen-color = "000000";
      quick-terminal-position = "center";
      quick-terminal-autohide = false;
      keybind = [
        "super+c=copy_to_clipboard"
        "super+v=paste_from_clipboard"
        "shift+command+up=new_split:up"
        "shift+command+down=new_split:down"
        "shift+command+right=new_split:right"
        "shift+command+left=new_split:left"
        "global:control+option+space=toggle_quick_terminal"
      ];
    };
    themes.Brogrammer = {
      palette = ghosttyPalette;
      inherit (palette) background foreground;
      cursor-color = palette.cursor;
      cursor-text = palette.cursorText;
      selection-background = palette.selectionBackground;
      selection-foreground = palette.selectionForeground;
    };
  };

  programs.rio = {
    enable = true;
    package = if isDarwin then null else pkgs.rio;
    settings = {
      theme = "Brogrammer";
      padding-x = 10;
      padding-y = [
        10
        10
      ];
      confirm-before-quit = false;
      cursor = {
        shape = "underline";
        blinking = true;
        blinking-interval = 600;
      };
      window = {
        width = 1100;
        height = 720;
        mode = "windowed";
        opacity = 0.8;
        blur = true;
        decorations = "Enabled";
      }
      // lib.optionalAttrs isDarwin {
        macos-use-shadow = true;
        macos-use-unified-titlebar = false;
      };
      keyboard.ime-cursor-positioning = true;
      fonts = {
        family = terminalFont;
        size = 13;
      };
      navigation = {
        mode = "Plain";
        clickable = true;
        hide-if-single = false;
      };
    }
    // lib.optionalAttrs isDarwin {
      bindings.keys = [
        {
          key = "up";
          "with" = "shift|super";
          action = "SplitUp";
        }
        {
          key = "down";
          "with" = "shift|super";
          action = "SplitDown";
        }
        {
          key = "right";
          "with" = "shift|super";
          action = "SplitRight";
        }
        {
          key = "left";
          "with" = "shift|super";
          action = "SplitLeft";
        }
      ];
    };
    themes.Brogrammer.colors = {
      inherit (palette) background foreground cursor;
      selection-background = palette.selectionBackground;
      selection-foreground = palette.selectionForeground;
    }
    // palette.normal
    // lib.mapAttrs' (name: lib.nameValuePair "light-${name}") palette.bright;
  };

  programs.alacritty = {
    enable = true;
    settings = {
      env.TERM = "xterm-256color";
      window = {
        dimensions = {
          columns = 125;
          lines = 35;
        };
        padding = {
          x = 10;
          y = 10;
        };
        opacity = 0.9;
        blur = true;
      };
      cursor.style = {
        shape = "underline";
        blinking = "on";
      };
      font = {
        normal.family = terminalFont;
        size = 12;
      };
      colors = {
        primary = {
          inherit (palette) background foreground;
        };
        cursor = {
          cursor = palette.cursor;
          text = palette.cursorText;
        };
        selection = {
          background = palette.selectionBackground;
          text = palette.selectionForeground;
        };
        inherit (palette) normal bright;
      };
    };
  };
}
