{
  description = "Welkin's Dotfiles";
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable-small";
    ckgpkgs = {
      url = "github:ckgxrg-salt/ckgpkgs";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    lix-module = {
      url = "https://git.lix.systems/lix-project/nixos-module/archive/2.93.0.tar.gz";
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
    microvm = {
      url = "github:astro/microvm.nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };
  outputs =
    {
      self,
      colmena,
      nixpkgs,
      ckgpkgs,
      lix-module,
      disko,
      sops-nix,
      microvm,
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
          };
          imports = [
            ./host
            ./secrets
            lix-module.nixosModules.default
            disko.nixosModules.disko
            sops-nix.nixosModules.sops
            microvm.nixosModules.host
          ];
        };

        # Gateway
        Dispatcher = {
          deployment = {
            targetHost = "deploy.welkin.ckgxrg.io";
          };
          imports = [
            ./dispatcher
            sops-nix.nixosModules.sops
          ];
        };
      };

      nixosConfigurations = {
        Welkin = nixpkgs.lib.nixosSystem {
          inherit system;
          modules = [
            ./host
            lix-module.nixosModules.default
            disko.nixosModules.disko
            sops-nix.nixosModules.sops
            microvm.nixosModules.host
          ];
        };
        Dispatcher = nixpkgs.lib.nixosSystem {
          inherit system;
          modules = [
            ./dispatcher
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
