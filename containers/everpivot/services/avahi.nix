{ ... }:
# Zeroconf
{
  services.avahi = {
    enable = true;
    openFirewall = true;
    hostName = "Everpivot";
    nssmdns4 = true;
    nssmdns6 = true;
    publish = {
      enable = true;
      userServices = true;
      addresses = true;
    };
  };
}
