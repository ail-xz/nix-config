{ pkgs, ... }:
pkgs.stdenvNoCC.mkDerivation (finalAttrs: {
  pname = "man-pages-ja";
  version = "20261015";

  src = pkgs.fetchurl {
    url = "https://github.com/linux-jm/manual/releases/download/v${finalAttrs.version}/man-pages-ja-${finalAttrs.version}.tar.gz";
    hash = "sha256-jLfyd4y8hX+v8WhdNxAaeTJf+WnJOWsnze3w5TnXbr4=";
  };

  # Makefile の既定ターゲットは対話式の make config
  dontBuild = true;

  # SysVinit, man, netkit, eject は NixOS では別実装 (systemd, man-db, iputils, util-linux) が入る
  # shadow は nixpkgs の shadow に新しい訳がある
  installPhase = ''
    runHook preInstall
    LC_ALL=C awk -v exclude="SysVinit man netkit eject shadow" \
      -f ${./select.awk} script/pkgs.list manual/*/translation_list |
      while read -r pkg dir page; do
        install -Dm644 "manual/$pkg/$dir/$page" "$out/share/man/ja/$dir/$page"
      done

    # util-linux などの同名ページより nixpkgs の shadow の訳を優先し、system-path での衝突も避ける
    for f in ${pkgs.shadow.man}/share/man/ja/man*/*.gz; do
      rm -f "$out/share/man/ja/$(basename "$(dirname "$f")")/$(basename "$f" .gz)"
    done
    runHook postInstall
  '';

  meta = {
    description = "Japanese translations of Linux manual pages by the JM Project";
    homepage = "https://linuxjm.sourceforge.io/";
    platforms = pkgs.lib.platforms.linux;
  };
})
