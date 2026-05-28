{ ... }:
{
  imports = [
    ./certs.nix
    ./caddy.nix
    ./postgresql.nix
    ./valkey.nix

    ./keycloak.nix
    ./oauth2-proxy.nix

    ./cloudflared.nix
    ./netbird.nix
  ];
}
