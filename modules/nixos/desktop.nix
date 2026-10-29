{
  config,
  flake,
  ...
}:
let
  primaryUser = config.my.primaryUser;
  userCursor = config.home-manager.users.${primaryUser}.home.pointerCursor;
in
{
  imports = [
    flake.nixosModules.fonts
    flake.nixosModules.ime
    flake.nixosModules.keyboard
    flake.nixosModules.firefox-webapps
  ];

  programs = {
    noctalia.enable = true;
    niri.enable = true;
    firefox.enable = true;
  };

  services.gvfs.enable = true;

  services.displayManager.noctalia-greeter = {
    enable = true;
    passwordlessSyncUsers = [ primaryUser ];
    cursorTheme = {
      inherit (userCursor) package name;
    };
    settings.cursor.size = userCursor.size;
  };
}
