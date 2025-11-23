{ pkgs, ... }:
let
  java25 = pkgs.temurin-jre-bin-25;
in
{
  programs.tmux = {
    enable = true;
    # So server keeps running with we ssh out
    secureSocket = false;
    clock24 = true;
  };

  networking.firewall.allowedTCPPorts = [
    25565
  ];

  # Thanks the Minecraft wiki for this script
  # This by default uses Java 24
  systemd.services."minecraft@" = {
    description = "Minecraft Server: %i";
    after = [ "network.target" ];
    path = [
      java25
      pkgs.bash
    ];
    serviceConfig = {
      Type = "forking";
      WorkingDirectory = "/srv/minecraft/%i";
      PrivateUsers = true;
      User = "goat";
      Group = "minecraft";
      ProtectSystem = "full";
      ProtectHome = true;
      ProtectKernelTunables = true;
      ProtectControlGroups = true;

      ExecStart = "${pkgs.tmux}/bin/tmux new-session -d -s %i 'bash run.sh'";
      ExecStop = "${pkgs.tmux}/bin/tmux send-keys -t %i 'say Server is shutting down.' C-m 'save-all' C-m 'stop' C-m";
    };
    wantedBy = [ "multi-user.target" ];
  };
}
