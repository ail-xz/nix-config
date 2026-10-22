{ flake, ... }:
{
  imports = [ flake.modules.common.fonts ];

  fonts.fontconfig.defaultFonts.monospace = [
    "JetBrainsMono Nerd Font"
    "Noto Sans Mono CJK JP"
  ];
  fonts.fontconfig.defaultFonts.sansSerif = [
    "Noto Sans"
    "Noto Sans CJK JP"
  ];
  fonts.fontconfig.defaultFonts.serif = [
    "Noto Serif"
    "Noto Serif CJK JP"
  ];
}
