{
  config,
  lib,
  flake,
  hostName,
  ...
}:
let
  primaryUser = config.my.primaryUser;
in
{
  imports = [ flake.modules.common.packages ];

  options.my.primaryUser = lib.mkOption {
    type = lib.types.str;
    description = "Primary local user for this host";
  };

  config = {
    assertions = [
      {
        assertion = config.home-manager.users ? ${primaryUser};
        message = "my.primaryUser is \"${primaryUser}\", but hosts/${hostName}/users/${primaryUser}/home-configuration.nix does not exist.";
      }
    ];

    home-manager.extraSpecialArgs = { inherit hostName; };
    home-manager.backupFileExtension = "backup";

    nix.settings.experimental-features = [
      "nix-command"
      "flakes"
    ];

    nix.optimise.automatic = true;

    programs.nh = {
      enable = true;
      clean = {
        enable = true;
        extraArgs = "--keep 5 --keep-since 30d";
      };
    };

    time.timeZone = "Asia/Tokyo";

    programs.zsh.enable = true;

    # compinit は home-manager の programs.zsh側のみ
    programs.zsh.enableGlobalCompInit = false;
  };
}
