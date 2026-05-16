{ ... }:
{
  imports = [
    ./certs.nix
    ./caddy.nix
    ./postgresql.nix

    ./keycloak.nix

    ./cloudflared.nix
    ./netbird.nix
  ];
}
