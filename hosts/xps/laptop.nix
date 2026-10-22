{ pkgs, ... }:
{
  boot.kernelPackages = pkgs.linuxPackages_latest;
  boot.loader.systemd-boot.consoleMode = "auto";

  boot.zswap.enable = true;

  # zramSwap.enable = true;

  hardware.enableRedistributableFirmware = true;
  hardware.bluetooth = {
    enable = true;
    powerOnBoot = true;
  };

  hardware.graphics = {
    enable = true;
    extraPackages = with pkgs; [
      intel-media-driver
      intel-compute-runtime
      vpl-gpu-rt
    ];
  };

  hardware.firmware = with pkgs; [
    sof-firmware
    alsa-firmware
  ];

  services.fwupd.enable = true;
  services.fstrim.enable = true;
  services.power-profiles-daemon.enable = true;
  services.upower.enable = true;

  time.hardwareClockInLocalTime = true;

  services.logind.settings.Login = {
    HandleLidSwitch = "suspend";
    HandleLidSwitchExternalPower = "suspend";
    HandlePowerKey = "suspend";
    HandlePowerKeyLongPress = "suspend";
  };

  services.udev.packages = [ pkgs.brightnessctl ];
}
