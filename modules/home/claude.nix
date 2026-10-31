{
  config,
  inputs,
  lib,
  pkgs,
  ...
}:
let
  sbx = inputs.agent-sandbox.lib.${pkgs.stdenv.hostPlatform.system};

  claude-sandboxed = sbx.mkSandbox {
    pkg = pkgs.claude-code;
    binName = "claude";
    outName = "claude-sandboxed";
    allowedPackages = sbx.commonTools;
    allowNix = true;
    allowUnixSockets = true;
    rwDirs = [
      "$HOME/.claude"
      "$HOME/.cache/nix"
      "$HOME/.config/nix"
      "$HOME/.local/share/nix"
    ];
    roFiles = [
      "$HOME/.config/git/config"
    ];
    roDirs = [
      "$HOME/Pictures/Screenshots"
    ]
    ++ lib.optionals pkgs.stdenv.hostPlatform.isLinux [
      "$HOME/.config/niri"
      "$HOME/.config/noctalia"
      "$HOME/.config/fcitx5"
    ];
    env = {
      CLAUDE_CODE_OAUTH_TOKEN = "$CLAUDE_CODE_OAUTH_TOKEN";
      CLAUDE_CONFIG_DIR = "$HOME/.claude";
      NIX_CONFIG = "experimental-features = nix-command flakes";
    };
  };
in
{
  home.packages = [ claude-sandboxed ];

  home.sessionVariables.CLAUDE_CONFIG_DIR = "${config.home.homeDirectory}/.claude";
}
