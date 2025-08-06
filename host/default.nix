{ ... }:
# Host entrypoint
{
  imports = [
    ./boot.nix
    ./disko.nix
    ./login.nix
    ./settings.nix
    ./security.nix

    ./certs.nix
    ./cloudflared.nix
    ./tailscale.nix
    ./services.nix

    ../servers
  ];

  networking = {
    hostName = "Welkin";
    hostId = "9ff456c1";
  };

  system.stateVersion = "24.11";
}
