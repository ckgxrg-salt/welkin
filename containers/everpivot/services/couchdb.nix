{ ... }:
# CouchDB for Obsidian-livesync
{
  services.couchdb = {
    enable = true;
    bindAddress = "127.0.0.1";
    port = 5984;
    configFile = "/var/lib/couchdb/local.ini";
    adminUser = "root";
  };

  # Dedicated user
  users = {
    users."couchdb" = {
      description = "CouchDB Server user";
      isSystemUser = true;
      group = "couchdb";
    };
    groups."couchdb" = { };
  };
}
