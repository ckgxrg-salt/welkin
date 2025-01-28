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
        "server string" = "Welkin - Everpivot";
      };
      Pictures = {
        browseable = "yes";
        comment = "Everlight Pivot Gallery";
        "guest ok" = "yes";
        "write list" = "scribe";
        "force user" = "scribe";
        "force group" = "samba";
        path = "/data/Pictures";
      };
    };
  };

  # Samba dedicated user
  users = {
    users."scribe" = {
      description = "Samba Admin";
      isSystemUser = true;
      group = "samba";
    };
    groups."samba" = { };
  };

  # Make it discoverable
  services.avahi.extraServiceFiles."samba" = ''
    <?xml version="1.0" standalone='no'?>
    <!DOCTYPE service-group SYSTEM "avahi-service.dtd">
    <service-group>
      <name replace-wildcards="yes">%h Storage</name>
      <service>
        <type>_smb._tcp</type>
        <port>445</port>
      </service>
    </service-group>
  '';
  services.samba-wsdd = {
    enable = true;
    openFirewall = true;
    hostname = "Everpivot";
  };
}
