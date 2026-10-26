{
  config,
  lib,
  pkgs,
  hostName,
  ...
}:
{
  programs.nh = {
    enable = true;
    flake = lib.mkDefault "${config.home.homeDirectory}/nix";
  };

  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestion.enable = true;
    defaultKeymap = "emacs";
    history = {
      size = 100000;
      save = 100000;
      extended = true;
      ignoreSpace = true;
      findNoDups = true;
    };
    setOptions = [
      "NOBEEP"
      "NOLISTBEEP"
      "IGNORE_EOF"
      "HIST_REDUCE_BLANKS"
      "HIST_NO_STORE"
      "AUTO_PARAM_SLASH"
      "AUTO_MENU"
      "AUTO_LIST"
      "CORRECT"
      "AUTO_PUSHD"
      "PUSHD_IGNORE_DUPS"
    ];
    shellAliases = {
      sudo = "sudo ";
      ls = "eza -la";
      rm = "rm -i";
      v = "nvim";
      b = "bat";
      ex = "exit";
      neofetch = "fastfetch";
      rebuild = "nh ${
        if pkgs.stdenv.hostPlatform.isDarwin then "darwin" else "os"
      } switch -H ${hostName}";
    };
  };

  home.packages = [ pkgs.zsh-completions ];

  programs.starship = {
    enable = true;
    presets = [ "tokyo-night" ];
    settings = {
      character = {
        success_symbol = "[ >](bold green)";
        error_symbol = "[ >](bold red)";
      };
      # 記号がいやなので
      directory.substitutions = {
        "Documents" = "Documents";
        "Downloads" = "Downloads";
        "Music" = "Music";
        "Pictures" = "Pictures";
        "Developer" = "Developer";
      };
    };
  };

  programs.tmux = {
    enable = true;
    terminal = "tmux-256color";
    clock24 = true;
  };

  programs.git = {
    enable = true;
    settings.user = {
      name = "ail";
      email = "166195177+ail-xz@users.noreply.github.com";
    };
  };

  programs.gh = {
    enable = true;
  };
}
