{ flake, ... }:
{
  imports = [ flake.darwinModules.shared ];

  nixpkgs.hostPlatform = "aarch64-darwin";
  my.primaryUser = "ail";

  system.stateVersion = 6;
}
