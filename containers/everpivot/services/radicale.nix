{ ... }:
# Radicale CalDAV & CardDAV server
{
  services.radicale = {
    enable = true;
    settings = {
      server = {
        hosts = [
          "0.0.0.0:5232"
          "[::]:5232"
        ];
      };
      auth = {
        type = "htpasswd";
        htpasswd_filename = "/etc/radicale/passwd";
        htpasswd_encryption = "bcrypt";
      };
      storage = {
        filesystem_folder = "/var/lib/radicale/storage";
      };
      rights = {
        type = "owner_only";
      };
    };
  };

  # Dedicated user
  users = {
    users."radicale" = {
      description = "Radicale *DAV Server";
      isSystemUser = true;
    };
    groups."radicale" = { };
  };

  # Open firewall
  networking.firewall = {
    allowedTCPPorts = [ 5232 ];
  };
}
