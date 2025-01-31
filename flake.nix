{
  description = "Welkin's Dotfiles";
  inputs = {
    # Nixpkgs source
    nixpkgs.url = "github:nixos/nixpkgs/nixos-24.11-small";
    # Use Lix
    lix-module = {
      url = "https://git.lix.systems/lix-project/nixos-module/archive/stable.tar.gz";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    # Deployment tool
    colmena.url = "github:zhaofengli/colmena";
    disko = {
      url = "github:nix-community/disko";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };
  outputs =
    {
      nixpkgs,
      lix-module,
      disko,
      ...
    }:
    let
      system = "x86_64-linux";
      host-pkgs = import <nixpkgs> { inherit system; };
    in
    {
      colmena = {
        meta = {
          nixpkgs = import nixpkgs {
            inherit system;
          };
        };

        # Host
        Welkin = {
          deployment = {
            buildOnTarget = true;
            targetUser = "deployer";
          };
          imports = [
            ./host
            lix-module.nixosModules.default
            disko.nixosModules.disko
          ];
        };
      };

      # For initial deployment with nixos-anywhere
      nixosConfigurations = {
        Welkin = nixpkgs.lib.nixosSystem {
          inherit system;
          modules = [
            ./host
            lix-module.nixosModules.default
            disko.nixosModules.disko
          ];
        };
      };

      # A nix develop shell including formatter and linter to be used with Neovim
      devShells.${system}.default = host-pkgs.mkShellNoCC {
        name = "welkin";

        buildInputs = [
          host-pkgs.nixfmt-rfc-style
          host-pkgs.deadnix
          host-pkgs.colmena
        ];
      };

      # Support nix fmt command
      formatter.${system} = host-pkgs.nixfmt-rfc-style;
    };
}
