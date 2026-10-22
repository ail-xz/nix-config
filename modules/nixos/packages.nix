{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    rustnet
  ];
}
