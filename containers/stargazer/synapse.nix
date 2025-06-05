{ ... }:
# The Matrix homeserver
{
  services.postgresql = {
    enable = true;
    ensureDatabases = [ "matrix-synapse" ];
    ensureUsers = [
      {
        name = "matrix-synapse";
        ensureDBOwnership = true;
      }
    ];
  };

  services.matrix-synapse = {
    enable = true;
    settings = {
      server_name = "ckgxrg.io";
      public_baseurl = "https://stargazer.ckgxrg.io";
      listeners = [
        {
          port = 8008;
          bind_addresses = [ "0.0.0.0" ];
          type = "http";
          tls = false;
          x_forwarded = true;
          resources = [
            {
              names = [
                "client"
                "federation"
              ];
              compress = true;
            }
          ];
        }
      ];
      oidc_providers = [
        {
          idp_id = "authelia";
          idp_name = "Authelia";
          idp_icon = "mxc://authelia.com/cKlrTPsGvlpKxAYeHWJsdVHI";
          discover = true;
          issuer = "https://auth.welkin.ckgxrg.io";
          userinfo_endpoint = "https://auth.welkin.ckgxrg.io/api/oidc/userinfo";
          user_profile_method = "userinfo_endpoint";
          client_id = "matrix-synapse";
          client_secret_path = "/var/secrets/synapse/client-secret";
          scopes = [
            "openid"
            "profile"
            "email"
          ];
          allow_existing_users = true;
          user_mapping_provider.config = {
            localpart_template = "{{ user.name }}";
            display_name_template = "{{ user.name }}";
            email_template = "{{ user.email }}";
          };
        }
      ];
    };
    extraConfigFiles = [
      "/var/secrets/synapse/registration-secret.conf"
    ];
  };

  services.frp.settings.proxies = [
    {
      name = "stargazer";
      type = "tcp";
      localIP = "127.0.0.1";
      localPort = 8008;
      remotePort = 7400;
    }
  ];
}
