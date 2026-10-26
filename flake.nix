{
  description = "NixOS / nix-darwin configurations (blueprint)";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs?ref=nixos-unstable";

    blueprint.url = "github:numtide/blueprint";
    blueprint.inputs.nixpkgs.follows = "nixpkgs";

    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    nix-darwin.url = "github:nix-darwin/nix-darwin";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";

    nixvim.url = "github:nix-community/nixvim";
    nixvim.inputs.nixpkgs.follows = "nixpkgs";

    agent-sandbox.url = "github:archie-judd/agent-sandbox.nix";
    agent-sandbox.inputs.nixpkgs.follows = "nixpkgs";

    rinertia.url = "github:JimMoen/rinertia";
    rinertia.flake = false;

    gaze.url = "github:GunduLabs/gaze";
    gaze.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs =
    inputs:
    inputs.blueprint {
      inherit inputs;
      # x86_64-darwin があると評価が失敗する
      systems = [
        "x86_64-linux"
        "aarch64-darwin"
      ];
      nixpkgs.config.allowUnfree = true;
    };
}
