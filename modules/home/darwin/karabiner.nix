let
  commandAlone = side: key: {
    description = "${side} command alone → ${key}";
    type = "basic";
    from = {
      key_code = "${side}_command";
      modifiers.optional = [ "any" ];
    };
    to = [ { key_code = "${side}_command"; } ];
    to_if_alone = [ { key_code = key; } ];
  };
in
{
  xdg.configFile."karabiner/assets/complex_modifications/nix.json".text = builtins.toJSON {
    title = "nix";
    rules = [
      {
        description = "Use command keys alone as Eisuu / Kana";
        manipulators = [
          (commandAlone "left" "japanese_eisuu")
          (commandAlone "right" "japanese_kana")
        ];
      }
      {
        description = "Change capslock to command+control+option, and shift+caps_lock to caps_lock";
        manipulators = [
          {
            type = "basic";
            from = {
              key_code = "caps_lock";
              modifiers.mandatory = [ "shift" ];
            };
            to = [ { key_code = "caps_lock"; } ];
          }
          {
            type = "basic";
            from = {
              key_code = "caps_lock";
              modifiers.optional = [ "any" ];
            };
            to = [
              {
                key_code = "left_command";
                modifiers = [
                  "left_control"
                  "left_option"
                ];
              }
            ];
          }
        ];
      }
    ];
  };
}
