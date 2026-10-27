{
  config,
  flake,
  ...
}:
let
  primaryUser = config.my.primaryUser;
in
{
  imports = [
    flake.modules.common.shared
    flake.modules.common.fonts
    flake.darwinModules.packages
    flake.darwinModules.homebrew
    flake.darwinModules.defaults
    flake.darwinModules.bettersnaptool
  ];

  users.users.${primaryUser}.home = "/Users/${primaryUser}";

  system.primaryUser = primaryUser;

  security.pam.services.sudo_local.touchIdAuth = true;
  # tmux, screen でも動くようにする
  security.pam.services.sudo_local.reattach = true;
}
