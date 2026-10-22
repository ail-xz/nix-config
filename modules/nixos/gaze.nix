{ inputs, ... }:
{
  imports = [ inputs.gaze.nixosModules.default ];

  services.gaze = {
    enable = true;
    gui.enable = true;
    # Nixで管理するので gaze config を無効化
    mutableConfig = false;
    settings.cameras = {
      rgb = "primary";
      # XPS 13 (DX13260) の IR Cam
      ir = "usb:0bda:55bc";
    };
    settings.security.level = "medium";
    # TPM で暗号化
    settings.storage.encrypt_templates = true;
  };

  security.pam.services.login.gaze.enable = true;

  # パスワードと並行して認証
  security.pam.services.sudo.gaze.simultaneous = true;
  security.pam.services.polkit-1.gaze.simultaneous = true;
}
