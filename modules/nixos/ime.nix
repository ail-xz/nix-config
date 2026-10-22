{ pkgs, inputs, ... }:
{
  i18n.inputMethod = {
    enable = true;
    type = "fcitx5";
    fcitx5 = {
      addons = [ inputs.nixpkgs-stable.legacyPackages.${pkgs.stdenv.hostPlatform.system}.fcitx5-mozc-ut ];
      waylandFrontend = true;
      settings = {
        globalOptions = {
          "Hotkey/ActivateKeys"."0" = "Henkan";
          "Hotkey/DeactivateKeys"."0" = "Muhenkan";
          # Ctrl+Space を Neovim (blink.cmp) で使うため既定の TriggerKeys から外す
          "Hotkey/TriggerKeys"."0" = "Zenkaku_Hankaku";
          "Behavior".ActiveByDefault = false;
          "Behavior".ShowInputMethodInformation = false;
          "Behavior".showInputMethodInformationWhenFocusIn = false;
        };
      };
    };
  };
}
