{
  description = "Welkin's Dotfiles";
  inputs = {
    # Nixpkgs source
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    # Use Lix
    lix-module = {
      url = "https://git.lix.systems/lix-project/nixos-module/archive/stable.tar.gz";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    # Deployment tool
    colmena.url = "github:zhaofengli/colmena";
  };
  outputs =
    {
      self,
      nixpkgs,
      lix-module,
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
            system = "x86_64-linux";
          };
        };

        Welkin = {
          deployment = {
            buildOnTarget = true;
            targetUser = "deployer";
            tags = [
              "welkin"
              "dom0"
            ];
          };
          imports = [
            ./dom0
            lix-module.nixosModules.default
          ];
        };

        #Everpivot = { };
        #Archiva = { };
        #Goatfold = { };
      };

      # A nix develop shell including formatter and linter to be used with Neovim
      devShells.${system}.default = pkgs.mkShell {
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
