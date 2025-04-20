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
  '';
}
