{ ... }:
# Samba Shares
{
  services.samba = {
    enable = true;
    openFirewall = true;
    settings = {
      global = {
        "case sensitive" = "no";
        "invalid users" = [
          "root"
          "bse"
        ];
        security = "user";
        "passwd program" = "/run/wrappers/bin/passwd %u";
        "map to guest" = "Bad User";
        "guest account" = "nobody";
        workgroup = "Welkin";
        "server string" = "Welkin - Everlight Pivot";
      };
      # Public shares
      Gallery = {
        browseable = "yes";
        comment = "Everlight Pivot Gallery";
        "guest ok" = "yes";
        "write list" = "scribe";
        "force user" = "scribe";
        "force group" = "storage";
        "directory mask" = "0775";
        path = "/data/Gallery";
      };
      Animes = {
        browseable = "yes";
        comment = "Everlight Pivot Animes";
        "guest ok" = "yes";
        "write list" = "scribe";
        "force user" = "scribe";
        "force group" = "storage";
        "directory mask" = "0775";
        path = "/data/Animes";
      };
      Movies = {
        browseable = "yes";
        comment = "Everlight Pivot Movies";
        "guest ok" = "yes";
        "write list" = "scribe";
        "force user" = "scribe";
        "force group" = "storage";
        "directory mask" = "0775";
        path = "/data/Movies";
      };

      # Private shares
      Private = {
        browseable = "yes";
        comment = "Everlight Pivot Private";
        "guest ok" = "no";
        "write list" = "scribe";
        "force user" = "scribe";
        "force group" = "storage";
        path = "/data/Private";
      };
    };
  };

  # Samba dedicated user
  users = {
    users."scribe" = {
      description = "Samba Admin";
      isSystemUser = true;
      group = "storage";
    };
    groups."storage" = {
      gid = 1024;
    };
  };

  # Make it discoverable
  services.avahi.extraServiceFiles."samba" = ''
    <?xml version="1.0" standalone='no'?>
    <!DOCTYPE service-group SYSTEM "avahi-service.dtd">
    <service-group>
      <name replace-wildcards="yes">Everlight Pivot Storage</name>
      <service>
        <type>_smb._tcp</type>
        <port>445</port>
      </service>
    </service-group>
  '';
  services.samba-wsdd = {
    enable = true;
    openFirewall = true;
    hostname = "Everlight Pivot";
  };
}
