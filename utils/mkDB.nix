name: {
  services.postgresql = {
    ensureUsers = [
      {
        inherit name;
        ensureDBOwnership = true;
      }
    ];
    ensureDatabases = [ name ];
  };
}
