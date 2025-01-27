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
        "guest account" = "samba-guest";
        workgroup = "Welkin";
        "server string" = "Welkin - Everpivot";
      };
      Pictures = {
        browseable = "yes";
        comment = "Everlight Pivot Gallery";
        "guest ok" = "yes";
        "write list" = "samba ckgxrg";
        "force user" = "samba";
        "force group" = "samba";
        path = "/data/Pictures";
      };
    };
  };

  # Samba dedicated user
  users = {
    users."samba" = {
      description = "Samba Admin";
      isSystemUser = true;
      group = "samba";
    };
    users."samba-guest" = {
      description = "Samba Public Shares";
      isSystemUser = true;
      group = "samba";
    };
    groups."samba" = { };
  };

  # Make it discoverable by Windows
  services.samba-wsdd = {
    enable = true;
    openFirewall = true;
    hostname = "Everpivot";
  };
}
