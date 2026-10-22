{ pkgs, inputs, ... }:
let
  src = inputs.rinertia;
in
pkgs.rustPlatform.buildRustPackage {
  pname = "rinertia";
  version = "0.1.0-unstable-${src.lastModifiedDate or "unknown"}";
  inherit src;
  cargoLock.lockFile = "${src}/Cargo.lock";

  meta = {
    description = "Inertial scrolling daemon for Linux touchpads";
    homepage = "https://github.com/JimMoen/rinertia";
    license = pkgs.lib.licenses.mit;
    mainProgram = "rinertia";
    platforms = pkgs.lib.platforms.linux;
  };
}
