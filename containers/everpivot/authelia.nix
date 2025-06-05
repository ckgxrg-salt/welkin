{ ... }:
{
  services.authelia.instances."Welkin" = {
    enable = true;
    user = "authelia";
    group = "authelia";
    secrets = {
      jwtSecretFile = "/var/secrets/authelia/jwt";
      sessionSecretFile = "/var/secrets/authelia/session";
      storageEncryptionKeyFile = "/var/secrets/authelia/storage";
      oidcHmacSecretFile = "/var/secrets/authelia/hmac";
      oidcIssuerPrivateKeyFile = "/var/secrets/authelia/oidc-issuer";
    };
    environmentVariables = {
      AUTHELIA_STORAGE_POSTGRES_PASSWORD_FILE = "/var/secrets/authelia/dbpasswd";
    };
    settings = {
      server = {
        address = "tcp://:1976";
        asset_path = "/var/lib/authelia-Welkin/assets";
        endpoints.authz.auth-request.implementation = "AuthRequest";
      };
      theme = "dark";
      authentication_backend = {
        password_reset.disable = true;
        password_change.disable = true;
        file = {
          path = "/var/secrets/authelia/users.yaml";
          password.algorithm = "argon2";
        };
      };
      access_control = {
        default_policy = "deny";
        rules = [
          {
            domain = "welkin.ckgxrg.io";
            policy = "one_factor";
          }
          {
            domain = "*.welkin.ckgxrg.io";
            policy = "one_factor";
          }
        ];
      };
      identity_providers.oidc = {
        clients = [
          {
            client_id = "matrix-synapse";
            # Hashed
            client_secret = "$pbkdf2-sha512$310000$h8pJ0DwNuKF1xQSkS/nBaw$brZPQ4tibLrFsieSItyeR8yGOg4SjZLZpAwCWO7h3G33xybRYIUM8z3xu.TW97klZlOft31lPgmO/r4tIe7rxw";
            client_name = "Matrix Synapse";
            authorization_policy = "one_factor";
            redirect_uris = [ "https://stargazer.ckgxrg.io/_synapse/client/oidc/callback" ];
            scopes = [
              "openid"
              "profile"
              "email"
            ];
            userinfo_signed_response_alg = "none";
            token_endpoint_auth_method = "client_secret_basic";
          }
        ];
      };
      session = {
        cookies = [
          {
            domain = "ckgxrg.io";
            authelia_url = "https://auth.welkin.ckgxrg.io";
            default_redirection_url = "https://welkin.ckgxrg.io";
          }
        ];
      };
      storage = {
        postgres = {
          address = "tcp://127.0.0.1:5432";
          database = "authelia";
          username = "authelia";
        };
      };
      notifier = {
        filesystem.filename = "/var/lib/authelia-Welkin/notifications.txt";
      };
    };
  };

  users = {
    users."authelia" = {
      description = "Authelia user";
      isSystemUser = true;
      group = "authelia";
    };
    groups."authelia" = { };
  };

  services.postgresql = {
    ensureUsers = [
      {
        name = "authelia";
        ensureDBOwnership = true;
      }
    ];
    ensureDatabases = [ "authelia" ];
  };

  services.frp.settings.proxies = [
    {
      name = "authelia";
      type = "tcp";
      localIP = "127.0.0.1";
      localPort = 1976;
      remotePort = 7106;
    }
  ];
}
