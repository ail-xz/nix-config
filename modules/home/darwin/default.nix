{ config, ... }:
{
  imports = [ ./karabiner.nix ];

  xdg.configFile."finicky/finicky.js".source = ./finicky/finicky.js;
  # ファイル単位のリンクはアプリの保存で置き換わるので、ディレクトリごとリポジトリへリンクする
  xdg.configFile."linearmouse".source =
    config.lib.file.mkOutOfStoreSymlink "${config.programs.nh.flake}/modules/home/darwin/linearmouse";
  xdg.configFile."snapzy".source =
    config.lib.file.mkOutOfStoreSymlink "${config.programs.nh.flake}/modules/home/darwin/snapzy";
}
