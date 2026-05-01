{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-25.11";
    ckgpkgs = {
      url = "github:ckgxrg-salt/ckgpkgs";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    colmena = {
      url = "github:zhaofengli/colmena";
      inputs.nixpkgs.follows = "nixpkgs";
    };
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
      nixpkgs,
      ckgpkgs,
      colmena,
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
      nixosConfigurations = {
        "Welkin" = nixpkgs.lib.nixosSystem {
          inherit system;
          specialArgs = { inherit ckgs; };
          modules = [
            ./host
            ./secrets
            disko.nixosModules.disko
            sops-nix.nixosModules.sops
          ];
        };
      };

      devShells.${system}.default = pkgs.mkShellNoCC {
        name = "welkin";

        nativeBuildInputs = with pkgs; [
          sops
          colmena.packages.${system}.colmena
        ];
      };

      colmenaHive = colmena.lib.makeHive {
        meta = {
          nixpkgs = pkgs;
          specialArgs = { inherit ckgs; };
        };

        "Welkin" = {
          deployment = {
            targetHost = "Welkin";
            targetUser = "deployer";
            buildOnTarget = true;
          };
          imports = [
            ./host
            ./secrets
            disko.nixosModules.disko
            sops-nix.nixosModules.sops
          ];
        };
      };
    };
}
