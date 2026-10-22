{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    macmon
    mactop
  ];
}
