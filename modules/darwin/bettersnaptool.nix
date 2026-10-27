{ lib, ... }:
let
  unsetHotkeys = [
    "12"
    "13"
    "14"
    "15"
    "16"
    "19"
    "20"
    "21"
    "102"
    "104"
    "105"
    "106"
    "110"
    "111"
    "112"
    "113"
    "999"
    "2001"
    "2002"
    "2003"
    "2004"
    "2005"
    "2006"
    "2007"
    "2008"
    "5461"
  ];
in
{
  system.defaults.CustomUserPreferences."com.hegenberg.BetterSnapTool" = {
    showMenubarIcon = false;
    recognitionArea = 20;
    previewBorderWidth = 3;
    previewAnimationDuration = 0.1;
    cycle_lrm = false;
    cycle_quarters = false;
    float_on_top_m = false;
    float_on_top_noninteractive_m = false;
    BSTIncreaseSnappingArea = false;
    BSTSequoiaUseClassicSnapping = 0;
    BSTDuplicateMenubarMenu = false;
    # ⌃⌥⌘ + 矢印 / Space と ⌃⌥⇧⌘ + Space。未設定の ID もアプリの状態に合わせて書く
    registeredHotkeys = {
      "0" = {
        keyCode = 126;
        modifiers = 8395008;
      };
      "1" = {
        keyCode = 49;
        modifiers = 6912;
      };
      "2" = {
        keyCode = 123;
        modifiers = 8395008;
      };
      "4" = {
        keyCode = 124;
        modifiers = 8395008;
      };
      "8" = {
        keyCode = 49;
        modifiers = 6400;
      };
      "10" = {
        keyCode = 125;
        modifiers = 8395008;
      };
    }
    // lib.genAttrs unsetHotkeys (_: {
      keyCode = -1;
      modifiers = 0;
    });
  };
}
