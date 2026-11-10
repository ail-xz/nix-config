{ pkgs, ... }:
let
  inherit (pkgs) lib;
  isLinux = pkgs.stdenv.hostPlatform.isLinux;
in
pkgs.mkShell {
  packages = [
    pkgs.uv
  ]
  ++ lib.optionals isLinux [ (pkgs.python3.withPackages (ps: [ ps.tkinter ])) ];
  # uv 管理の Python の Tk は Xft なしでフォントが拡大されないため、nixpkgs の Python を使う
  env = lib.optionalAttrs isLinux { UV_PYTHON_PREFERENCE = "only-system"; };
}
