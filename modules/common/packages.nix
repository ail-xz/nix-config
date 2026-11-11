{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    fd
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
