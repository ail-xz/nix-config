{ pkgs, perSystem, ... }:
let
  configFile = (pkgs.formats.toml { }).generate "rinertia.toml" {
    scroll = {
      enabled = true;
      damping_curve = "macos";
      natural_scroll = true;
      scroll_factor = 0.35;
    };
    pointer.enabled = false;
    interrupt.enabled = true;
  };
in
{
  hardware.uinput.enable = true;

  systemd.services.rinertia = {
    description = "rinertia - inertial scrolling for touchpads";
    wantedBy = [ "multi-user.target" ];
    after = [ "systemd-udev-settle.service" ];
    serviceConfig = {
      ExecStart = "${perSystem.self.rinertia}/bin/rinertia --config ${configFile}";
      Restart = "on-failure";
      RestartSec = 3;
    };
  };
}
