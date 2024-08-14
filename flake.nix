{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-parts.url = "github:hercules-ci/flake-parts";
    agenix-shell.url = "github:aciceri/agenix-shell";
  };

  outputs = inputs@{ self, nixpkgs, flake-parts, agenix-shell, ... }:
    flake-parts.lib.mkFlake {inherit inputs;} {
      systems = nixpkgs.lib.systems.flakeExposed;

      imports = [
        # agenix-shell.flakeModules.default
      ];

      # agenix-shell = {
      #   secrets = {
      #     foo.file = ./secrets/foo.age;
      #   };
      # };

      perSystem = {
        pkgs,
        config,
        lib,
        ...
      }: 
      let
        inherit (pkgs.darwin.apple_sdk.frameworks) CoreFoundation;
      in
      {
        devShells.default = pkgs.mkShell.override {
          stdenv = pkgs.llvmPackages.libcxxStdenv;
        } {
          packages = with pkgs; [
            rustc
            cargo
            clippy
            maturin
            python3
            darwin.libobjc
            libiconv
            python3
            python312Packages.pip
          ];

        };
      };
    };
}