{
  description = "Svelte site";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
  };

  outputs = {nixpkgs, ...}: let
    pkgs = nixpkgs.legacyPackages."x86_64-linux";
  in {
    devShells.x86_64-linux.default = pkgs.mkShell {
      buildInputs = with pkgs; [
        prettierd
        nodejs
        nodePackages.npm
        nodePackages.yarn
        nodePackages.pnpm
        nodePackages.typescript
        nodePackages.typescript-language-server
        bun
        openssl
      ];
    };
  };
}
