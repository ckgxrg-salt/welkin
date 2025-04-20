{ ... }:
# Minecraft servers
{
  imports = [
    ./frp.nix
    ./glances.nix
    ./login.nix
    ./security.nix
    ./settings.nix
    ./tmux.nix
  ];

  # Hostname & Host ID
  networking = {
    hostName = "Goatfold";
    hostId = "951c4139";
  };

  system.stateVersion = "24.11";
}
