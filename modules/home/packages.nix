{ pkgs, ... }:
{
  home.packages = with pkgs; [
    ffmpeg
    claude-code
    ookla-speedtest
    sl
    cmatrix
    asciiquarium
    fastfetch
  ];
}
