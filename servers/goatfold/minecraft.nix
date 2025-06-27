{ pkgs, ... }:
let
  java24 = pkgs.temurin-jre-bin-24;
in
{
  services.frp.settings.proxies = [
    {
      name = "goatfold-ssh";
      type = "tcp";
      localIP = "127.0.0.1";
      localPort = 22;
      remotePort = 7322;
    }
  ];

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
    path = [ java24 ];
    serviceConfig = {
      WorkingDirectory = "/srv/minecraft/%i";
      Type = "simple";
      PrivateUsers = true;
      User = "goat";
      Group = "minecraft";
      ProtectSystem = "full";
      ProtectHome = true;
      ProtectKernelTunables = true;
      ProtectControlGroups = true;

      ExecStart = ''
        ${pkgs.tmux}/bin/tmux \
                new-session \
                -s %i \
                -d "bash run.sh"
      '';
      ExecStop = "${pkgs.tmux}/bin/tmux send-keys -t %i 'say Server is shutting down.' C-m 'save-all' C-m 'stop' C-m";
      ExecStopPost = "sleep 2";
    };
    wantedBy = [ "multi-user.target" ];
  };
}
