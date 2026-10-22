{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    eza
    bat
    tree
    glow
    nano
    msedit
    ripgrep
    curl
    wget
    mtr
    htop
    btop
    bottom
    nload
    dysk
    iperf
    unzip
    git
  ];
}
