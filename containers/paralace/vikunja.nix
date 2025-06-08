{ pkgs, ... }:
{
  # A vikunja bug make it impossible to use env var to pass secrets
  # Thus secrets have to be embedded into the config
  environment.etc."vikunja/config.yaml".source = "/var/secrets/vikunja.yaml";
  environment.systemPackages = [
    pkgs.vikunja
  ];

  systemd.services.vikunja = {
    description = "vikunja";
    after = [
      "network.target"
      "postgresql.service"
    ];
    wantedBy = [ "multi-user.target" ];
    path = [ pkgs.vikunja ];

    serviceConfig = {
      Type = "simple";
      User = "vikunja";
      Group = "vikunja";
      StateDirectory = "vikunja";
      ExecStart = "${pkgs.vikunja}/bin/vikunja";
      Restart = "always";
    };
  };

  users = {
    users."vikunja" = {
      description = "Vikunja";
      isSystemUser = true;
      group = "vikunja";
    };
    groups."vikunja" = { };
  };

  services.postgresql = {
    ensureUsers = [
      {
        name = "vikunja";
        ensureDBOwnership = true;
      }
    ];
    ensureDatabases = [ "vikunja" ];
  };

  services.frp.settings.proxies = [
    {
      name = "vikunja";
      type = "tcp";
      localIP = "127.0.0.1";
      localPort = 4571;
      remotePort = 7504;
    }
  ];
}
