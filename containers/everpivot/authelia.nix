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
            client_secret = "$pbkdf2-sha512$310000$h8pJ0DwNuKF1xQSkS/nBaw$brZPQ4tibLrFsieSItyeR8yGOg4SjZLZpAwCWO7h3G33xybRYIUM8z3xu.TW97klZlOft31lPgmO/r4tIe7rxw";
            client_name = "Matrix";
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
          {
            client_id = "jellyfin";
            client_secret = "$pbkdf2-sha512$310000$mkRcEYKEO9PyUplyfCtUmg$E9G4781j4AiMMmpmAwICsF69tY0zbhv99Y8WRQSrDn92XZgORBX/dQmAJ3kOCjFHaGZaZxT.E531nUMCWh9idw";
            client_name = "Jellyfin";
            authorization_policy = "one_factor";
            redirect_uris = [ "https://welkin.ckgxrg.io/jellyfin/sso/OID/redirect/authelia" ];
            scopes = [
              "openid"
              "profile"
              "groups"
            ];
            userinfo_signed_response_alg = "none";
            token_endpoint_auth_method = "client_secret_post";
          }
          {
            client_id = "gitea";
            client_secret = "$pbkdf2-sha512$310000$Re0xJIX9hI7TKtgsYc306w$43Z.l5T3Jo2ty8QRq.LSmAwQ0Z/7JUOHsYy92jcDlW36VpJdRU77BjjnGfT/e5C9.tiIEeMFLiiea/QY/.n67Q";
            client_name = "Gitea";
            authorization_policy = "one_factor";
            redirect_uris = [ "https://archiva.ckgxrg.io/user/oauth2/authelia/callback" ];
            scopes = [
              "openid"
              "email"
              "profile"
            ];
            userinfo_signed_response_alg = "none";
            token_endpoint_auth_method = "client_secret_basic";
          }
          {
            client_id = "mealie";
            client_secret = "$pbkdf2-sha512$310000$.4z4aG.rGjNuqRieKKQ69Q$a3trExILXestrXn0mH2v0KfBSCrJXmOkKt1v5G6eM5KunHwsO2gC/UZW0nYPYgEYzx66HeyoN3pYkVbau3Zm4A";
            client_name = "Mealie";
            authorization_policy = "one_factor";
            redirect_uris = [ "https://mealie.welkin.ckgxrg.io/login" ];
            scopes = [
              "openid"
              "email"
              "profile"
              "groups"
            ];
            userinfo_signed_response_alg = "none";
            token_endpoint_auth_method = "client_secret_basic";
          }
          {
            client_id = "miniflux";
            client_secret = "$pbkdf2-sha512$310000$6Pc6L/0c58.EoViD8jyKVw$9XE7vgDzyEZHGg0xua6KMgDWwq4k1z3NEQIuxAWg.YXACFqgTmfrhYsmdPlnxJ0y/a3QvcAIPYpBp.JwKQNEwA";
            client_name = "Miniflux";
            authorization_policy = "one_factor";
            redirect_uris = [ "https://welkin.ckgxrg.io/miniflux/oauth2/oidc/callback" ];
            scopes = [
              "openid"
              "email"
              "profile"
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
