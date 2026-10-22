{ pkgs, ... }:
pkgs.mkShell {
  packages = [ pkgs.uv ];
}
