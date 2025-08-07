{
  description = "Welkin's Dotfiles";
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable-small";
    ckgpkgs = {
      url = "github:ckgxrg-salt/ckgpkgs";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    colmena.url = "github:zhaofengli/colmena";
    disko = {
      url = "github:nix-community/disko";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    sops-nix = {
      url = "github:mic92/sops-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };
  outputs =
    {
      self,
      colmena,
      nixpkgs,
      ckgpkgs,
      disko,
      sops-nix,
      ...
    }:
    let
      system = "x86_64-linux";
      pkgs = import nixpkgs {
        inherit system;
      };
      ckgs = ckgpkgs.packages.${system};
    in
    {
      colmenaHive = colmena.lib.makeHive self.outputs.colmena;
      colmena = {
        meta = {
          nixpkgs = import nixpkgs {
            inherit system;
          };
          specialArgs = {
            inherit ckgs;
          };
        };

        # Host
        Welkin = {
          deployment = {
            buildOnTarget = true;
            targetUser = "deployer";
            targetHost = "192.168.50.100";
          };
          imports = [
            ./host
            ./secrets
            disko.nixosModules.disko
            sops-nix.nixosModules.sops
          ];
        };
      };

      nixosConfigurations = {
        Welkin = nixpkgs.lib.nixosSystem {
          inherit system;
          modules = [
            ./host
            disko.nixosModules.disko
            sops-nix.nixosModules.sops
          ];
        };
      };

      # A nix develop shell including formatter and linter to be used with Neovim
      devShells.${system}.default = pkgs.mkShellNoCC {
        name = "welkin";

        buildInputs = [
          pkgs.nixfmt-rfc-style
          pkgs.deadnix
          pkgs.sops
          colmena.packages.${system}.colmena
        ];
      };

      # Support nix fmt command
      formatter.${system} = pkgs.nixfmt-rfc-style;
    };
}
