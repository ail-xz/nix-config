{ flake, ... }:
{
  imports = [
    ./hardware-configuration.nix
    ./laptop.nix
    flake.nixosModules.shared
    flake.nixosModules.desktop
    flake.nixosModules.gaze
    flake.nixosModules.rinertia
  ];

  my.primaryUser = "ail";

  system.stateVersion = "25.05";
}
