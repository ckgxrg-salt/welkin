{
  description = "Welkin's Dotfiles";
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable-small";
    ckgpkgs = {
      url = "github:ckgxrg-salt/ckgpkgs";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    lollypops = {
      url = "github:pinpox/lollypops";
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
      lollypops,
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
      nixosConfigurations = {
        "Welkin" = nixpkgs.lib.nixosSystem {
          inherit system;
          specialArgs = { inherit ckgs; };
          modules = [
            lollypops.nixosModules.default
            {
              lollypops.deployment = {
                local-evaluation = true;
                ssh.user = "deployer";
                sudo.enable = true;
              };
            }

            ./host
            ./secrets
            disko.nixosModules.disko
            sops-nix.nixosModules.sops
          ];
        };
      };

      devShells.${system}.default = pkgs.mkShellNoCC {
        name = "welkin";

        buildInputs = with pkgs; [
          nixfmt
          deadnix
          sops
        ];
      };

      packages.x86_64-linux.deploy = lollypops.packages.x86_64-linux.default.override {
        configFlake = self;
      };
    };
}
