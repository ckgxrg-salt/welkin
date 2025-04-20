{
  description = "Welkin's Dotfiles";
  inputs = {
    # Nixpkgs source
    nixpkgs.url = "github:nixos/nixpkgs/nixos-24.11-small";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";
    # Use Lix
    lix-module = {
      url = "https://git.lix.systems/lix-project/nixos-module/archive/2.92.0-3.tar.gz";
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
      nixpkgs-unstable,
      lix-module,
      disko,
      ...
    }:
    let
      system = "x86_64-linux";
      pkgs-unstable = import nixpkgs-unstable { inherit system; };
    in
    {
      colmena = {
        meta = {
          nixpkgs = import nixpkgs {
            inherit system;
          };
          specialArgs = {
            inherit pkgs-unstable;
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

        # Gateway
        Dispatcher = {
          deployment = {
            targetHost = "welkin.ckgxrg.io";
          };
          imports = [
            ./dispatcher
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
      devShells.${system}.default = pkgs-unstable.mkShellNoCC {
        name = "welkin";

        buildInputs = [
          pkgs-unstable.nixfmt-rfc-style
          pkgs-unstable.deadnix
          pkgs-unstable.colmena
        ];
      };

      # Support nix fmt command
      formatter.${system} = pkgs-unstable.nixfmt-rfc-style;
    };
}
