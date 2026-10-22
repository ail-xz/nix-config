{ flake, ... }:
{
  imports = [
    flake.homeModules.shared
    flake.homeModules.darwin
  ];

  home.stateVersion = "24.11";
}
