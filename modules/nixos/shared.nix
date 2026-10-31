{
  lib,
  pkgs,
  flake,
  hostName,
  config,
  ...
}:
{
  imports = [
    flake.modules.common.shared
    flake.nixosModules.packages
    flake.nixosModules.locale
  ];

  networking.hostName = lib.mkDefault hostName;
  networking.networkmanager.enable = true;

  services.resolved.enable = true;
  programs.yubikey-manager.enable = true;
  services.tailscale.enable = true;
  services.tailscale.extraSetFlags = [ "--operator=${config.my.primaryUser}" ];

  services.timesyncd = {
    servers = [ "time.cloudflare.com" ];
    fallbackServers = [
      "ntp1.jst.mfeed.ad.jp"
      "ntp2.jst.mfeed.ad.jp"
      "ntp3.jst.mfeed.ad.jp"
    ];
  };

  boot.loader.systemd-boot.enable = true;
  boot.loader.systemd-boot.configurationLimit = 5;
  boot.loader.efi.canTouchEfiVariables = true;

  programs.nix-ld.enable = true;

  users.users.${config.my.primaryUser} = {
    isNormalUser = true;
    extraGroups = [
      "wheel"
      "networkmanager"
      "video"
      "dialout"
    ];
    shell = pkgs.zsh;
  };
}
