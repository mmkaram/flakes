{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
  };

  outputs = {
    self,
    nixpkgs,
  }: let
    system = "x86_64-linux";
    pkgs = import nixpkgs {
      inherit system;
      config.allowUnfree = true;
      overlays = [
        (final: prev: {
          python311 = prev.python311.override {
            packageOverrides = python-final: python-prev: {
              opencv4 = python-prev.opencv4.override {
                enableGtk2 = true;
              };
            };
          };
        })
      ];
    };
  in {
    devShells.${system}.default = pkgs.mkShell {
      buildInputs = with pkgs; [
        (python311.withPackages (ps:
          with ps; [
            setuptools
            imutils
            numpy
            flask
            tensorflow # missing hub
            pylint
            matplotlib
            pyenchant
            pytest
            opencv4
          ]))
        stdenv.cc.cc.lib
      ];
      LD_LIBRARY_PATH = "${pkgs.stdenv.cc.cc.lib}/lib";
    };
  };
}
