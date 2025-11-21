{ pkgs, ... }:
{
  services.redis = {
    package = pkgs.valkey;
    servers."" = {
      enable = true;
      port = 6379;
    };
  };
}
