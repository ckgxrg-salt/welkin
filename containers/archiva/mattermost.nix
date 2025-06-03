{ ... }:
{
  services.mattermost = {
    enable = true;
    siteName = "Archiva Projects";
    siteUrl = "https://projects.ckgxrg.io";
    port = 8192;
    database = {
      driver = "postgres";
      peerAuth = true;
    };

    mutableConfig = true;
    preferNixConfig = true;

    telemetry = {
      enableSecurityAlerts = false;
      enableDiagnostics = false;
    };

    settings = {
      TeamSettings = {
        EnableUserCreation = false;
        CustomDescriptionText = "Archiva Project Comms";
        CustomBrandText = "Archiva";
        EnableCustomBrand = true;
      };
      SupportSettings = {
        EnableAskCommunityLink = false;
        HelpLink = "https://nope.ckgxrg.io";
        TermsOfServiceLink = "https://nope.ckgxrg.io";
        PrivacyPolicyLink = "https://nope.ckgxrg.io";
        AboutLink = "https://nope.ckgxrg.io";
      };
    };
  };

  services.postgresql = {
    enable = true;
    ensureDatabases = [ "mattermost" ];
    ensureUsers = [
      {
        name = "mattermost";
        ensureDBOwnership = true;
      }
    ];
  };

  services.frp.settings.proxies = [
    {
      name = "mattermost";
      type = "tcp";
      localip = "127.0.0.1";
      localport = 8192;
      remoteport = 7301;
    }
  ];
}
