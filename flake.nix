{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable-small";
    ckgpkgs = {
      url = "github:ckgxrg-salt/ckgpkgs";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    deploy-rs = {
      url = "github:serokell/deploy-rs";
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
      self,
      nixpkgs,
      ckgpkgs,
      deploy-rs,
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
      dkgs = import nixpkgs {
        inherit system;
        overlays = [
          deploy-rs.overlays.default
          (_: super: {
            deploy-rs = {
              inherit (pkgs) deploy-rs;
              lib = super.deploy-rs.lib;
            };
          })
        ];
      };
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
          deploy-rs.packages.${system}.default
        ];
      };

      deploy.nodes = {
        "Welkin" = {
          profiles.system = {
            user = "deployer";
            path = dkgs.deploy-rs.lib.activate.nixos self.nixosConfigurations."Welkin";
            remoteBuild = true;
          };
        };
      };

      checks = builtins.mapAttrs (_: deployLib: deployLib.deployChecks self.deploy) deploy-rs.lib;
    };
}
