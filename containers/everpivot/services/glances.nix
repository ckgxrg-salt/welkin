{ pkgs-unstable, ... }:
# Monitors all servers
{
  services.glances = {
    enable = true;
    package = pkgs-unstable.glances;
    openFirewall = true;
    port = 61208;
    extraArgs = [
      "--browser"
      "-w"
    ];
  };

  environment.etc."glances/glances.conf".text = ''
    [outputs]
    url_prefix=/glances/
    [serverlist]
    server_1_name=archiva
    server_1_port=61208
    server_2_name=goatfold
    server_2_port=61208
    server_3_name=stargazer
    server_3_port=61208
    server_4_name=paralace
    server_4_port=61208
  '';
}
