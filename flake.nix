{
  description = "Welkin's Dotfiles";
  inputs = {
    # Nixpkgs source
    nixpkgs.url = "github:nixos/nixpkgs/nixos-24.11";
    # Use Lix
    lix-module = {
      url = "https://git.lix.systems/lix-project/nixos-module/archive/stable.tar.gz";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    # Helper for libvirt
    nixvirt = {
      url = "https://flakehub.com/f/AshleyYakeley/NixVirt/0.5.0.tar.gz";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    # Deployment tool
    colmena = {
      url = "github:zhaofengli/colmena";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    disko = {
      url = "github:nix-community/disko";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };
  outputs =
    {
      self,
      nixpkgs,
      lix-module,
      nixvirt,
      disko,
      colmena,
      ...
    }:
    let
      system = "x86_64-linux";
      pkgs = import nixpkgs {
        inherit system;
      };
    in
    {
      colmenaHive = colmena.lib.makeHive self.outputs.colmena;
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
            tags = [
              "welkin"
              "host"
            ];
          };
          imports = [
            ./host
            lix-module.nixosModules.default
            nixvirt.nixosModules.default
            disko.nixosModules.disko
          ];
        };

        # Minecraft server
        Goatfold = {
          deployment = {
            buildOnTarget = true;
            targetUser = "hyhy156";
            tags = [
              "goatfold"
              "vm"
            ];
          };
          imports = [
            ./vm/goatfold
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
            nixvirt.nixosModules.default
            disko.nixosModules.disko
          ];
        };
        Goatfold = nixpkgs.lib.nixosSystem {
          inherit system;
          modules = [
            ./vm/goatfold
            lix-module.nixosModules.default
            disko.nixosModules.disko
          ];
        };
      };

      # A nix develop shell including formatter and linter to be used with Neovim
      devShells.${system}.default = pkgs.mkShellNoCC {
        name = "welkin";

        buildInputs = with pkgs; [
          nixfmt-rfc-style
          deadnix
          colmena.packages.${system}.colmena
        ];

        shellHook = ''
          exec nu
        '';
      };

      # Support nix fmt command
      formatter.${system} = pkgs.nixfmt-rfc-style;
    };
}
