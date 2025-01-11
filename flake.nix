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
  };
  outputs = {
      nixpkgs,
      lix-module,
      ...
    }:
    let
      system = "x86_64-linux";
      pkgs = import nixpkgs {
        inherit system;
      };
    in
    {
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
              "host"
            ];
          };
          imports = [
            ./welkin
            lix-module.nixosModules.default
          ];
        };
      };

      # A nix develop shell including formatter and linter to be used with Neovim
      devShells.${system}.default = pkgs.mkShell {
        name = "dotfiles";

        buildInputs = with pkgs; [
          nixfmt-rfc-style
          deadnix
          colmena
        ];

        shellHook = ''
          exec nu
        '';
      };

      # Support nix fmt command
      formatter.${system} = pkgs.nixfmt-rfc-style;
    };
}
