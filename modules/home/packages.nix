{ pkgs, ... }:
{
  home.packages = with pkgs; [
    ffmpeg
    claude-code
    antigravity-cli
    ookla-speedtest
    sl
    cmatrix
    asciiquarium
    fastfetch
  ];
}
