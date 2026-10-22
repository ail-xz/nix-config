{ flake, ... }:
{
  imports = [
    flake.homeModules.shell
    flake.homeModules.terminals
    flake.homeModules.packages
    flake.homeModules.nixvim
    flake.homeModules.claude
  ];
}
